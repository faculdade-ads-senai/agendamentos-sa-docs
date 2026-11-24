# Google Agenda opcional — contrato 1.6.1

O PostgreSQL determina consultas e disponibilidade. O calendário é uma cópia eventual das consultas do paciente, sem importação, free/busy, leitura geral de eventos ou integração com calendários de médicos. O login existente continua solicitando somente openid/email/profile.

## Configuração

1. No projeto Google Cloud existente, habilitar Google Calendar API e reutilizar **o mesmo cliente OAuth Web do SSO**, com os mesmos GOOGLE_CLIENT_ID e GOOGLE_CLIENT_SECRET. Não criar outro cliente.
2. Configurar a tela de consentimento e usuários de teste. Autorizar `openid` e `https://www.googleapis.com/auth/calendar.events.owned` nesse fluxo adicional. Avaliar verificação OAuth para publicação; no modo de teste o consentimento e refresh tokens podem expirar.
3. No mesmo cliente, manter `http://localhost:8080/login/oauth2/code/google` e adicionar `http://localhost:8080/api/v1/integracoes/google-agenda/callback` aos redirect URIs autorizados. Em produção cadastrar ambos com o endereço HTTPS público do backend.
4. Configurar as variáveis abaixo no ambiente **do backend**. Não enviar segredos ou refresh tokens para React/Capacitor. Não é necessário SDK Google no frontend.
5. Habilitar a integração somente após configurar credenciais e chave. Com `GOOGLE_AGENDA_ENABLED=false` as demais APIs continuam funcionando e status informa `disponivel=false`.

| Variável | Finalidade |
|---|---|
| GOOGLE_AGENDA_ENABLED | false por padrão |
| GOOGLE_CLIENT_ID / GOOGLE_CLIENT_SECRET | Mesmo cliente utilizado no SSO |
| GOOGLE_AGENDA_REDIRECT_URI | Callback registrado no Google |
| GOOGLE_AGENDA_RETURN_URI | Retorno fixo ao cliente; não aceita URL fornecida na requisição |
| GOOGLE_AGENDA_ENCRYPTION_KEY_BASE64 | Chave AES de 32 bytes aleatórios, independente de AES/HMAC cadastrais |
| GOOGLE_AGENDA_KEY_VERSION | Identificador da chave ativa |
| GOOGLE_AGENDA_PREVIOUS_KEYS_JSON | Mapa versão/base64 para leitura de envelopes anteriores; padrão `{}` |
| CONSULTORIO_LOCAL | Local opcional e genérico do consultório |

Gerar cada chave separadamente com `openssl rand -base64 32` ou gerador criptograficamente seguro equivalente. Não gerar novamente a cada inicialização. Guardar em gerenciador de segredos e manter backup protegido e separado do backup PostgreSQL; perda das chaves exige reconexão do calendário. Nunca colocar chaves reais no Git, comandos de diagnóstico ou logs. Uma chave ausente/inválida impede habilitar a integração.

Para rotacionar: adicionar a chave antiga ao mapa de versões, configurar nova chave/versão ativa, publicar e validar leitura dos envelopes antigos. Novas autorizações/renovações passam a usar a versão ativa. Manter chaves antigas até não haver credenciais e backups dependentes delas; não remover antes disso. A rotação cadastral existente continua independente.

## Consentimento

As variáveis GOOGLE_AGENDA_CLIENT_ID e GOOGLE_AGENDA_CLIENT_SECRET foram removidas: somente as credenciais configuradas no SSO são utilizadas. Conexões de um cliente antigo exigem novo consentimento; seus refresh tokens não são transferidos para o cliente compartilhado nem usados para renovação. O status informa requerReconexao e o worker inutiliza as credenciais incompatíveis sob lock. As consultas e vínculos com eventos são preservados.

PACIENTE autenticado navega para GET `/api/v1/integracoes/google-agenda/conectar`. O backend usa state aleatório de uso único e 10 minutos, nonce, PKCE S256 e acesso offline com consentimento explícito. O callback exige a mesma sessão local, usuário e geração da conexão; verifica assinatura RS256, emissor Google, audiência, validade, nonce e o mesmo `sub` utilizado no SSO. Outra conta Google é recusada sem substituir a sessão principal ou uma conexão anterior válida.

Somente é conectado quando existe refresh token utilizável. Se o Google não devolver um novo, somente pode ser preservado o anterior do mesmo cliente e `sub`; sem ele, é necessário reconectar. O token é criptografado AES-256-GCM com nonce aleatório e AAD vinculada ao usuário/finalidade. Access tokens são obtidos por renovação e mantidos apenas na memória da execução, nunca persistidos ou enviados ao navegador. Refresh token rotacionado é protegido antes de persistir.

Retorno fixo com `google_agenda=conectado` ou códigos: `consentimento_cancelado`, `consentimento_invalido`, `identidade_invalida`, `conta_google_diferente`, `escopo_nao_autorizado`, `reconexao_necessaria`, `google_conexao` e `google_<status>`. Exibir mensagens locais seguras, não o conteúdo bruto dos erros remotos. Sessão ausente retorna 401.

## Sincronização e desconexão

Somente consultas criadas ou reagendadas depois da conexão são elegíveis; não há carga retroativa. Eventos utilizam `primary`, título genérico, início/fim no fuso America/Sao_Paulo e local opcional. Não contêm CPF, nascimento, e-mail, especialidade, motivo ou informações clínicas. PATCH altera apenas início/fim e preserva título, descrição e demais alterações pessoais.

O identificador aleatório estável do evento é salvo antes do HTTP. Retentativas consultam apenas esse ID conhecido e verificam a marca privada `agendaSa` antes de alterar/excluir. Não existe listagem dos compromissos pessoais. Resultado desconhecido ou 409 de criação é reconciliado pela próxima tentativa. Se o paciente apagar um evento confirmado, ele será recriado com novo ID somente em uma nova versão de reagendamento; replay da mesma versão não o recria. Exclusão 404/410 é sucesso.

O consumidor relê o estado atual da consulta e verifica a versão depois do HTTP. Uma criação seguida imediatamente por cancelamento converge para ausência do evento; falhas Google não desfazem a consulta. É consistência eventual: requisições externas já em voo podem aparecer brevemente antes da reconciliação.

DELETE exige sessão PACIENTE e CSRF. Um lock de sessão PostgreSQL por usuário serializa sincronização, renovação, callback e desconexão entre instâncias, sem manter transação SQL durante HTTP. Se ocupado, retornar 503 e repetir com backoff. A desconexão invalida a geração, remove as credenciais, interrompe novas chamadas e tenta revogar o grant com timeout. Mantém consultas, sessão local e eventos já criados, sem novas atualizações. Se a revogação remota falhar, remover manualmente o acesso na conta Google; a desconexão local permanece efetiva.

**Limitação do provedor:** usando o mesmo cliente OAuth, a revogação pode remover todos os escopos do grant do projeto, não apenas Calendar. Revogar o calendário pode exigir novo consentimento no próximo login Google. A sessão HTTP atual não é invalidada. A revogação remota foi mantida por decisão explícita; não há promessa de revogação exclusiva do calendário.

## Referências oficiais

- [Escopos Calendar](https://developers.google.com/workspace/calendar/api/auth): `calendar.events.owned` atende o calendário principal; `calendar.app.created` limita-se a calendários secundários criados pela aplicação. A aplicação restringe as operações apesar do alcance mais amplo do escopo.
- [OAuth Web Server e acesso offline](https://developers.google.com/identity/protocols/oauth2/web-server).
- [Criação com ID fornecido pela aplicação](https://developers.google.com/workspace/calendar/api/v3/reference/events/insert).
- [PATCH de eventos](https://developers.google.com/workspace/calendar/api/v3/reference/events/patch).

## Validação manual externa

Configurar cliente/segredos e Calendar API reais; iniciar sessão de paciente ativado; conectar com a mesma conta; criar consulta; verificar o único evento; reagendar; verificar atualização; cancelar; verificar remoção. Testar também conta diferente, cancelamento do consentimento, consentimento revogado, evento apagado manualmente e desconexão. Nenhum desses testes reais é substituído pelos testes automatizados com gateway simulado.
