## Atualização de conformidade — dados pessoais 1.5.0

| Operação | Contrato atual | Backend/frontend |
|---|---|---|
| POST /usuarios | ADMIN + CSRF; dadosPessoais obrigatório para todos os perfis: cpf/dataNascimento, telefone/endereco opcionais | Implementados |
| PUT /usuarios/{id} | ADMIN + CSRF; dadosPessoais omitido preserva; enviado substitui conjunto completo | Implementados |
| GET /usuarios/{id}/dados-pessoais | ADMIN; consulta completa de qualquer usuário | Implementados |
| GET /usuarios/me/dados-pessoais | Sessão; apenas proprietário pelo sub Google | Implementados |
| PATCH /usuarios/me | Nome obrigatório; contato opcional; rejeita CPF/nascimento/email/perfil/estado | Implementados |
| UsuarioResponse/listagens/auth | Somente cadastroCompleto adicional; sem CPF/nascimento/contato | Implementados |

CPF/nascimento eram ausentes tanto do código quanto dos contratos; classificação: contrato incompleto frente aos novos requisitos. Não foi comprovada remoção histórica. V7 preserva dados/IDs e permite regularização sem bloqueio de legados. [Regras completas](DADOS-PESSOAIS.md). As linhas históricas abaixo devem ser lidas com estas alterações.

# Conformidade da integração — 22/11/2026

## Diagnóstico e decisões

Inspeção durante a integração: o OpenAPI 1.3.0 ainda descrevia JWT, senha e troca de idToken; requisitos e guias do backend já descreviam OIDC/sessão/convites. Classificação: **documentação desatualizada**. A arquitetura OIDC atual substitui esses contratos legados; não serão restaurados.

O OpenAPI e a instrução atual definem ADMIN/MEDICO/PACIENTE; enum Java, V5 e guias recentes usavam ADMINISTRADOR. Classificação: **backend incompatível com o contrato**. A correção será uma V6 que renomeia o valor preservando registros e vínculos; V1–V5 permanecem intactas. RECEPCIONISTA só existe no histórico e nas migrações que convertem dados antigos.

O frontend original enviava Bearer, dependia de sessionStorage, exigia senha e usava mock fixo. Classificação: **frontend incompatível com o contrato atual**. Os scripts de testes apontavam para arquivos ausentes.

Falhas OAuth retornavam JSON no navegador. O retorno seguro à tela inicial e o código de rejeição CSRF eram **comportamentos não documentados/contrato incompleto**, agora registrados no OpenAPI atualizado.

## Matriz de endpoints

Todos os caminhos REST abaixo têm prefixo `/api/v1`, exceto onde indicado. Escritas exigem CSRF; paginação começa em 0, size 1–100 (padrão 20). P representa `content,page,size,totalElements,totalPages`. U representa UsuarioResponse: `id,nome,email,perfil,ativo,criadoEm,atualizadoEm,statusCadastro,master,ativadoEm`. Identidade Google não é exposta.

| Funcionalidade | Endpoint documentado | Método | Request DTO/parâmetros | Response | Autenticação | Permissão | Backend local | Frontend final | Divergências/limites |
|---|---|---|---|---|---|---|---|---|---|
| Iniciar Google | `/oauth2/authorization/google` (raiz) | GET | — | 302 Google | Pública | Todos | Implementado | Integrado | Navegação completa |
| Callback | `/login/oauth2/code/google` (raiz) | GET | code/state do Google | 302 frontend | OIDC | Identidade autorizada | Implementado | Retorno e bootstrap | Falha: auth_error=login_failed |
| Sessão | `/auth/me` | GET | — | 200 U / 401 | Sessão | Todos ativos/ativados | Implementado | Integrado | Sem medicoId; não inventar campo |
| Estado | `/auth/status` | GET | — | 200 autenticado:boolean | Pública | Todos | Implementado | Bootstrap usa me | Não requer segunda consulta |
| CSRF | `/auth/csrf` | GET | — | headerName,token | Pública | Todos | Implementado | Integrado | Token em memória |
| Logout | `/auth/logout` | POST | Sem corpo + CSRF | 204 / 403 | Sessão/CSRF | Todos | Implementado | Integrado | Invalida no servidor |
| Listar usuários | `/usuarios` | GET | page,size,sort | 200 P de U | Sessão | ADMIN | Implementado | Integrado | perfil/busca continuam planejados |
| Criar usuário | `/usuarios` | POST | nome,email,perfil | 201 U + Location | Sessão | ADMIN | Implementado | Integrado | Sem senha; cadastro pendente |
| Consultar usuário | `/usuarios/{id}` | GET | id | 200 U / 404 | Sessão | ADMIN | Implementado | Integrado | — |
| Editar usuário | `/usuarios/{id}` | PUT | nome,email,perfil,ativo | 200 U / 409 | Sessão | ADMIN | Implementado | Integrado | Master, próprio perfil e e-mail vinculado protegidos |
| Inativar | `/usuarios/{id}` | DELETE | id | 204 / 409 | Sessão | ADMIN | Implementado | Integrado | Sem exclusão física |
| Próprio cadastro | `/usuarios/me` | GET/PATCH | PATCH: nome | 200 U | Sessão | Todos | Implementado | Integrado | E-mail somente leitura |
| Emitir convite | `/usuarios/{id}/convites` | POST | Sem corpo | 201 ConviteResponse com link | Sessão | ADMIN | Implementado | Integrado | Reemissão revoga anteriores |
| Histórico de convites | `/usuarios/{id}/convites` | GET | id | Lista ConviteResponse, link=null | Sessão | ADMIN | Implementado | Não utilizado | Fora das telas solicitadas |
| Revogar convite | `/usuarios/{id}/convites/{conviteId}` | DELETE | IDs | 204 / 409 | Sessão | ADMIN | Implementado | Não utilizado | Fora das telas solicitadas |
| Abrir convite | `/convite/{token}` (raiz) | GET | Token de uso único | 302 OAuth ou frontend com invite_invalid | Pública | Conta convidada | Implementado | Link completo | Link não persistido no navegador |
| Médicos | `/medicos`, `/medicos/{id}` | GET/POST/PATCH | MedicoRequest/AtualizarMedicoRequest; page,size,ativo,especialidade | P/MedicoResponse | Sessão | Leitura autenticada; escrita ADMIN | Ausente | Telas/serviços preservados | Contrato planejado, não implementar módulo neste trabalho |
| Agenda semanal | `/medicos/{id}/agenda` | GET/PUT | janelas: diaSemana,horaInicio,horaFim,duracaoMinutos | AgendaMedicoResponse | Sessão | Leitura autenticada; escrita ADMIN | Ausente | Preservado | Código citado no contrato em outra branch, não neste checkout |
| Bloqueios | `/medicos/{id}/bloqueios`, `/{bloqueioId}` | GET/POST/DELETE | inicio,fim,motivo | Lista/BloqueioAgendaResponse/204 | Sessão | ADMIN | Ausente | Preservado | Módulo pendente no checkout |
| Disponibilidade | `/medicos/{id}/horarios-disponiveis` | GET | data | Lista inicio,fim | Sessão | Todos | Ausente | Preservado | Módulo pendente no checkout |
| Agendamentos | `/agendamentos` | GET/POST | GET filtros de período/médico/paciente/status; POST medicoId,inicio,pacienteId opcional | P/AgendamentoResponse | Sessão | Listar ADMIN; criar ADMIN/PACIENTE | Ausente | Preservado | Módulo planejado |
| Consultas próprias | `/agendamentos/me`, `/agendamentos/{id}` | GET | page,size,status ou id | P/AgendamentoResponse | Sessão | Dono/médico; ADMIN consulta por ID | Ausente | Preservado | Módulo planejado |
| Alterar consulta | `/agendamentos/{id}/cancelamento`, `/reagendamento` | PATCH | motivo; inicio,motivo opcional | AgendamentoResponse | Sessão | Regras de propriedade e prazo DEC-03 | Ausente | Preservado | Módulo planejado |
| Notificações | `/notificacoes/me`, `/notificacoes/{id}/leitura` | GET/PATCH | page,size,somenteNaoLidas | P/204 | Sessão | Próprio usuário | Ausente | Preservado | Módulo planejado |

Não existe endpoint separado de pacientes: a listagem administrativa usa usuários. Rotas ausentes continuam reportando falha real, sem fallback silencioso para mocks. A matriz descreve implementação no código, não validação com Google ou banco de produção.
