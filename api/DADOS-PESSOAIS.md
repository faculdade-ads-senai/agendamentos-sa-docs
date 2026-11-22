# Cadastro completo e dados pessoais — contrato 1.5.0

Os dados pertencem diretamente a `Usuario`, para ADMIN, MEDICO e PACIENTE. Não há entidade adicional. O modelo anterior e o OpenAPI 1.4.0 não continham CPF/nascimento; a inspeção não comprovou remoção histórica desses campos. Esta entrega amplia o contrato, sem alterar a autenticação.

## Cadastro e acesso

Novos cadastros administrativos exigem nome (até 120), e-mail (até 254), perfil e `dadosPessoais` com CPF e nascimento. Telefone e endereço são opcionais. Conta Google não é exigida no cadastro: ADMIN cria o usuário e emite convite; a ativação continua exigindo o e-mail Google verificado correspondente.

```json
{
  "nome": "Pessoa de exemplo",
  "email": "pessoa@example.com",
  "perfil": "PACIENTE",
  "dadosPessoais": {
    "cpf": "52998224725",
    "dataNascimento": "1990-05-20",
    "telefone": "+5548999999999",
    "endereco": null
  }
}
```

Os valores são exclusivamente fictícios. Não usar dados reais em testes, exemplos ou capturas.

POST `/api/v1/usuarios` retorna 201 e UsuarioResponse. PUT `/api/v1/usuarios/{id}` mantém nome/email/perfil/ativo e aceita `dadosPessoais` opcional: omitido preserva; enviado substitui o conjunto completo, com CPF/nascimento obrigatórios. Opcionais vazios/nulos são removidos. As duas operações exigem ADMIN e CSRF.

GET `/api/v1/usuarios/{id}/dados-pessoais` permite ADMIN consultar qualquer registro. GET `/api/v1/usuarios/me/dados-pessoais` permite a todos consultar os próprios dados. Retorno: id, nome, email, cpf (11 dígitos), dataNascimento, telefone, endereco e cadastroCompleto. Campos não informados de legados retornam null. Ambas usam `Cache-Control: no-store`.

PATCH `/api/v1/usuarios/me` exige nome e aceita telefone/endereco. Contatos omitidos são preservados; nulos/vazios são removidos. CPF, nascimento, e-mail, perfil e situação são rejeitados nessa operação. ADMIN corrige CPF/nascimento próprios pela operação administrativa. MEDICO e PACIENTE não consultam nem alteram dados de terceiros. Preservam-se as restrições de Master, mudança do próprio perfil e e-mail vinculado ao Google.

Listagens, autenticação e respostas genéricas retornam apenas `cadastroCompleto`, sem CPF, nascimento ou contatos. Não são expostos envelopes criptográficos, HMAC, chaves ou cookies. Dados pessoais não são persistidos pelo frontend em armazenamento do navegador.

## Validação

- CPF aceita 11 dígitos ou máscara padrão, valida verificadores e rejeita sequências repetidas. A normalização remove pontuação **antes** de criptografar e indexar. É único entre todos os perfis, inclusive inativos.
- Nascimento usa LocalDate/ISO `YYYY-MM-DD`, ano a partir de 1, não futuro em America/Sao_Paulo, sem conversão para instante. Datas anteriores a 120 anos pedem confirmação administrativa na interface; não existe rejeição por idade no servidor.
- Telefone opcional aceita `+`, código do país e separadores usuais; é normalizado para E.164. Valida-se a estrutura, não a existência da linha. O país não é inferido.
- Endereço opcional é texto aparado de até 500 caracteres. Não há campos clínicos adicionais.
- Erros seguem Problem Details: 400 validação, 401 sessão ausente, 403 permissão, 404 inexistente, 409 CPF/e-mail duplicado ou alteração protegida. Mensagens não repetem valores pessoais.

## Migração e regularização

V7 acrescenta cinco colunas à tabela usuario: cpf_criptografado, cpf_indice, nascimento_criptografado, telefone_criptografado e endereco_criptografado. A restrição única `uk_usuario_cpf_indice` protege inclusive gravações concorrentes. O CHECK exige CPF, índice e nascimento presentes juntos ou ausentes juntos.

Usuários anteriores ficam incompletos, sem dados fictícios e sem perder acesso. `cadastroCompleto` é calculado, independente de `ativo` e de `statusCadastro` Google. ADMIN usa a ação de regularização no formulário. Master automático pode iniciar incompleto e regularizar os próprios dados. Inativar ou mudar o perfil preserva os valores e não libera o CPF.

IDs, FKs de agendamentos, vínculos Google e convites permanecem intactos. V1–V6 não são editadas. Faça backup antes de aplicar migrações no ambiente de uso. Não foi necessária conversão de CPF antigo em texto puro: nenhum campo dessa natureza foi encontrado no modelo anterior.

## Criptografia e configuração

O antigo BCrypt de senha era irreversível. Não serve para estes campos recuperáveis. Não existe senha no fluxo atual. A proteção é centralizada no backend com Java AES-256-GCM: nonce aleatório de 96 bits, tag de 128 bits e envelope `v1:versaoChave:nonce:ciphertextComTag`, em Base64URL. AAD associa usuário, campo, formato e versão da chave. O índice de CPF é HMAC-SHA-256 com chave independente; não é SHA simples nem cifra determinística.

Configure somente no backend:

```dotenv
DATA_ENCRYPTION_KEY_BASE64=configure-localmente
DATA_ENCRYPTION_KEY_VERSION=1
CPF_HMAC_KEY_BASE64=configure-localmente
DATA_ENCRYPTION_PREVIOUS_KEYS_JSON={}
```

Cada chave precisa de exatamente 32 bytes aleatórios, codificados em Base64. O servidor falha ao iniciar se faltarem chaves válidas, se a versão for inválida ou se AES e HMAC reutilizarem a mesma chave. Nunca gera chaves automaticamente. Os testes usam chaves fictícias em configuração isolada, sem ler segredos do `.env`.

Geração manual, executada **separadamente para cada chave**, em um terminal privado:

```powershell
$bytes = [byte[]]::new(32)
$rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
try { $rng.GetBytes($bytes) } finally { $rng.Dispose() }
[Convert]::ToBase64String($bytes)
```

Guarde a saída em gerenciador de segredos ou no `.env` local ignorado pelo Git. Nunca copie para frontend, logs, tickets ou exemplos públicos. Não troque as chaves de um banco existente sem rotação planejada.

### Backup e rotação

Mantenha backup criptografado do PostgreSQL e backup separado, restrito e recuperável das chaves, suas versões e a associação com cada ambiente. Teste restauração do banco com o conjunto correto de chaves. Perder a chave torna o conteúdo irrecuperável; não há recuperação pela conta Google.

Para rotação AES: disponibilize a chave anterior no mapa JSON de versões anteriores, configure nova chave/versão ativa e mantenha HMAC estável. Novas escritas usam a versão ativa; leituras aceitam versões anteriores. Para recriptografar todo o acervo, use manutenção controlada por serviço que leia e regrave os campos preservando a mesma identidade/AAD; o executor em lote não faz parte desta entrega. Remova uma chave antiga somente após confirmar ausência de envelopes dessa versão e avaliar os backups que ainda dependem dela.

Para trocar HMAC: interrompa as escritas de cadastro, faça backup, decripte e revalide cada CPF em processo restrito, recalcule todos os índices sob a nova chave e confirme unicidade antes de retomar o serviço com a nova configuração. Não execute uma troca isolada da variável: isso permitiria índices incompatíveis e duplicação de CPFs. Não há rotação automática nessa versão.

Mantenha HTTPS, cookies seguros, autorização e CSRF na publicação. Desative logging de corpos pessoais, binds SQL e detalhes de erros nos serviços/proxies; o backend não registra intencionalmente esses valores e desabilita binds Hibernate. Criptografia não protege contra acesso autorizado indevido nem constitui, isoladamente, conformidade integral com a LGPD.

## Retenção e descarte

A aplicação preserva registros inativados e sua unicidade, conforme a regra existente. Não há exclusão automática nem prazo de retenção inventado. A definição de prazo e procedimento de descarte, incluindo backups, deve ser estabelecida pelo responsável pelo sistema antes de introduzir exclusão física. Nenhuma funcionalidade de descarte foi adicionada nesta alteração.

Referência técnica: a [API Cipher do Java 21](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/javax/crypto/Cipher.html) descreve a autenticação GCM, o uso de AAD antes do ciphertext e a exigência de IV diferente por operação.
