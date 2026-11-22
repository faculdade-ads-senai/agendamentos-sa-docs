# Entrega — cadastro completo e dados pessoais

## Diagnóstico e resultado

Usuario e seus DTOs não possuíam CPF, nascimento ou contato, nem infraestrutura de proteção recuperável. Os contratos também não definiam esses campos; não foi comprovada remoção histórica. O antigo BCrypt de senha era um hash irreversível e não foi reutilizado para dados que precisam de consulta. A senha continua ausente.

Os dados agora pertencem diretamente a Usuario em todos os perfis: ADMIN, MEDICO e PACIENTE. ADMIN corrige qualquer registro, inclusive o próprio; os demais editam somente nome e contato próprios. As proteções de Master/perfil/e-mail vinculado continuam vigentes. Não foi criada entidade adicional nem alterada regra de agendamento.

Nome, CPF, nascimento e e-mail são obrigatórios em novos cadastros. Telefone e endereço são opcionais. Legados e Master automático podem iniciar incompletos, sem dados fictícios e sem bloqueio adicional de acesso. O formulário administrativo permite regularização.

## Arquivos e responsabilidades

### Backend

Sob `src/main/java/com/agendaSa/`:

| Arquivo | Alteração |
|---|---|
| `usuarios/model/Usuario.java` | Campos cifrados e índice HMAC; cadastroCompleto calculado; exclusão dos campos internos da serialização |
| `shared/crypto/DadosCryptoService.java` | Configuração validada, AES-GCM com AAD, envelopes versionados, leitura de chaves anteriores e HMAC |
| `shared/crypto/DadosProtegidosException.java` | Falha de integridade com mensagem segura, sem valores internos |
| `usuarios/validation/DadosPessoaisValidator.java` | CPF, nascimento LocalDate, telefone internacional e endereço |
| `usuarios/dto/DadosPessoaisRequest.java` | Objeto de entrada específico, validações e representação textual protegida |
| `usuarios/dto/DadosPessoaisResponse.java` | Consulta autorizada, separada das respostas genéricas |
| `usuarios/dto/CriarUsuarioRequest.java` | dadosPessoais obrigatório para todos os perfis |
| `usuarios/dto/AtualizarUsuarioRequest.java` | dadosPessoais opcional; envio substitui o conjunto completo |
| `usuarios/dto/AtualizarMeuUsuarioRequest.java` | Nome obrigatório, contato com distinção entre omitido e nulo; rejeição de campos protegidos |
| `usuarios/dto/UsuarioResponse.java` | Somente cadastroCompleto adicional, sem dados pessoais recuperáveis |
| `usuarios/service/DadosPessoaisService.java` | Normalização, proteção antes de persistir e leitura autorizada |
| `usuarios/service/UsuarioService.java` | Cadastro/edição transacionais, tratamento de duplicidade e preservação de regras administrativas |
| `usuarios/service/MeuUsuarioService.java` | Nome/contato próprios sem alterar CPF ou nascimento |
| `usuarios/repository/UsuarioRepository.java` | Consulta de duplicidade do índice protegido |
| `usuarios/controller/v1/DadosPessoaisController.java` | Consultas administrativa e própria com no-store |
| `usuarios/exception/UsuarioExceptionHandler.java` | Respostas seguras para corpo inválido e falha criptográfica |
| `auth/config/SecurityConfig.java` | Autorização da consulta própria antes das regras administrativas |

Outros arquivos: `src/main/resources/db/migration/V7__dados_pessoais_usuario.sql`, `src/main/resources/application.yaml` e `.env.example`. A V7 é aditiva e preserva IDs/FKs; exige consistência do grupo obrigatório e CPF único globalmente. Chaves reais não foram gravadas no exemplo nem geradas na inicialização.

Testes novos/ampliados: `ApplicationTests`, `DadosPessoaisTest`, `MeuCadastroPessoalTest`, `SecurityTest`, `UsuarioControllerTest`, `UsuarioServiceTest` e a suíte opcional `UsuarioPersistenceTest`.

### Frontend

| Arquivo | Alteração |
|---|---|
| `src/users/personal.js` | Máscara/validação, datas sem fuso, contato e payload normalizado |
| `src/users/PersonalFields.jsx` | Campos reutilizáveis, obrigatoriedade e identidade somente leitura |
| `src/users/Users.jsx` | Formulário completo para todos os perfis, regularização e aviso de nascimento antigo |
| `src/users/validation.js` | Validação do conjunto obrigatório sem senha |
| `src/account/Profile.jsx` | Consulta própria, edição de contatos, identidade somente leitura e link administrativo para ADMIN |
| `src/main.jsx` | Informação do usuário para a tela de cadastro próprio |
| `src/api.jsx` | Objeto dadosPessoais nas escritas e consultas específicas |
| `src/mock.js`, `src/mock.json` | Contratos simulados e estado de cadastro incompleto explícito |
| `test/users.test.mjs`, `test/browser/auth.spec.js` | Validação, cadastros dos três perfis e edição própria restrita |
| `README.md` | Referência ao contrato/configuração atual |

### Documentação

Atualizados `api/openapi.yaml` (1.5.0), `api/README.md`, `api/CONFORMIDADE.md`, `api/INTEGRACAO-OAUTH.md`, relatório OAuth histórico, README principal, requisitos, arquitetura, modelo de dados e ambientes. Criados este relatório e [DADOS-PESSOAIS.md](DADOS-PESSOAIS.md), com contratos completos, configuração e procedimentos de chaves. Os guias `API-USUARIOS.md` e `AUTENTICACAO.md` do backend também foram atualizados.

## Segurança e contratos

CPF aceita máscara na entrada, mas é normalizado para 11 dígitos antes da proteção. O banco armazena apenas ciphertext e HMAC. Nascimento/telefone/endereço também usam AES-256-GCM, nonce aleatório de 96 bits, tag de 128 bits e AAD por usuário/campo/versão. HMAC-SHA-256 usa chave independente e restrição única inclusive para inativos. Troca de ciphertext entre usuários ou campos falha na autenticação.

POST/PUT de usuários continuam restritos a ADMIN com CSRF. Consultas específicas entregam os dados completos somente para ADMIN ou proprietário autenticado; listagens e autenticação retornam apenas cadastroCompleto. PATCH próprio rejeita CPF/nascimento/e-mail/perfil/estado, inclusive para ADMIN nessa rota. OAuth, vínculo por sub, convites, sessão, logout e CORS permanecem.

Nenhuma chave privada vai ao React. Dados pessoais ficam somente em memória no cliente. Erros não repetem valores e binds Hibernate permanecem desativados. A proteção não substitui HTTPS, autorização, proteção dos backups nem política de retenção.

## Validação executada

| Verificação | Resultado final |
|---|---|
| Backend `mvn test` | 90 testes descobertos; 87 executados com sucesso; 3 opcionais ignorados; compilação aprovada |
| Banco PostgreSQL temporário | V1–V7, preservação dos legados/relacionamentos, persistência cifrada, CPF único e concorrência aprovados |
| Criptografia | Ida/volta, nonces distintos, adulteração, chave incorreta, AAD, versões anteriores, HMAC e configuração inválida aprovados |
| Autorização/edição própria | Consulta por proprietário, bloqueio de terceiros, CPF/nascimento protegidos e contato omitido/nulo aprovados |
| Frontend `npm test` | 7 testes aprovados |
| Frontend `npm run test:e2e` com Edge | 11 testes aprovados, utilizando API interceptada |
| Build real e mock explícito | Ambos aprovados; build final em modo real |
| OpenAPI | YAML analisado; 27 caminhos e 185 referências internas resolvidas |

A execução inicial do PostgreSQL foi impedida pelo ambiente restrito e repetida com a permissão necessária. A suíte de interface encontrou um problema de apresentação de CPF nulo em legados; foi corrigido e a suíte final passou. Os três testes opcionais de banco externo permaneceram condicionados a configuração explícita e não foram contados como aprovados. Não há comando de lint configurado no frontend.

## Configuração e limites

Antes de iniciar o backend, configure DATA_ENCRYPTION_KEY_BASE64, DATA_ENCRYPTION_KEY_VERSION e CPF_HMAC_KEY_BASE64, além das variáveis existentes de banco/Google/Master. O mapa DATA_ENCRYPTION_PREVIOUS_KEYS_JSON é opcional. As chaves devem ser geradas uma única vez por ambiente e preservadas; trocar por valores aleatórios em cada execução tornaria os registros antigos ilegíveis. [Procedimentos completos](DADOS-PESSOAIS.md).

Não foram alterados banco de uso/produção, `.env` privado ou credenciais reais. A aplicação falha de forma segura até que as chaves sejam configuradas. A validação Google real e da publicação HTTPS continua manual. Os módulos médicos/agendas/agendamentos/notificações ausentes no checkout continuam sendo uma pendência anterior, com telas preservadas.

Rotação em lote/reindexação e descarte automático não foram implementados: há suporte de leitura versionada, configuração e procedimentos documentados para manutenção controlada. Não foi inventado prazo de retenção. O script SQL documental de restrições não foi executado manualmente nesta entrega.

## Organização dos commits

Commits locais nas branches principais: backend em master, frontend/documentação em main, com mensagens no padrão existente em português. As alterações OAuth da etapa anterior ainda estavam sem commit e são incluídas por serem necessárias para reproduzir e compilar o estado atual. Alterações preexistentes de wrapper Maven, cache local e destino do banco de desenvolvimento ficam fora dos commits. Não há push, merge ou deploy nesta entrega.
