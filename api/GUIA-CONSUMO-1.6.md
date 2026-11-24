# Guia de consumo web/mobile — API 1.6.0

Atualização 1.6.1: Google Agenda usa o mesmo cliente OAuth Web do login, mantendo consentimento e callback separados. Não há mudança nos contratos de consumo. Conexões antigas incompatíveis informam requerReconexao=true; solicitar novo consentimento. Revogar o calendário pode exigir novo consentimento em um login futuro, sem encerrar a sessão HTTP atual.

Base local `http://localhost:8080/api/v1`. Usar HTTPS na publicação, cookies de sessão (`credentials: include`) e origens exatas autorizadas. Não usar Bearer/JWT próprio nem armazenar JSESSIONID. Rotas retornam Problem Details; 401 exige login, 403 indica permissão ou `code=csrf_invalid`. Somente nessa rejeição recuperar novo CSRF antes de uma repetição limitada.

Login: navegação completa à raiz `/oauth2/authorization/google`; retorno à FRONTEND_URL; GET `/auth/me` recupera usuário. GET `/auth/csrf` retorna headerName/token; enviar esse cabeçalho em toda escrita. POST `/auth/logout` encerra a sessão (204); não confundir com desconectar calendário.

| Operação | Rotas relativas à base | Permissão |
|---|---|---|
| Médicos | GET/POST `/medicos`; GET/PATCH `/medicos/{id}` | Leitura autenticada; escrita ADMIN |
| Agenda | GET/PUT `/medicos/{id}/agenda` | Leitura autenticada; PUT ADMIN |
| Bloqueios | GET/POST `/medicos/{id}/bloqueios`; DELETE `/{bloqueioId}` | ADMIN |
| Disponibilidade | GET `/medicos/{id}/horarios-disponiveis?data=YYYY-MM-DD` | Autenticado |
| Consultas | POST/GET `/agendamentos`; GET `/agendamentos/me`; GET `/{id}` | POST ADMIN/PACIENTE; listagem geral ADMIN; próprias MEDICO/PACIENTE; por ID somente autorizados |
| Alterações | PATCH `/agendamentos/{id}/reagendamento`, `/cancelamento`, `/conclusao` | Regras abaixo |
| Notificações | GET `/notificacoes/me`; PATCH `/notificacoes/{id}/leitura` | Somente proprietário |
| Calendário | GET `/integracoes/google-agenda/status`, `/conectar`, `/callback`; DELETE `/integracoes/google-agenda`; POST `/integracoes/google-agenda/reprocessamento` | PACIENTE, própria integração |

POST médico recebe **uma requisição** com nome/email/dadosPessoais + crm/ufCrm/especialidade. Cria o usuário e a ficha atomicamente. Alternativamente recebe somente usuarioId + dados profissionais para MEDICO ativo ainda sem ficha. Não misturar os modos. A resposta inclui usuarioId para emitir convite em POST `/usuarios/{usuarioId}/convites`; convite não é emitido automaticamente. Dados pessoais permanecem em Usuario e não aparecem na resposta médica. CPF/nascimento de todos os perfis só são alterados pelo ADMIN nas rotas administrativas existentes.

Médicos legados podem ter usuarioId/email nulos; PATCH permite primeiro vínculo, não troca do proprietário. Nome/email de médicos vinculados vêm de Usuario; alterações respeitam e-mail Google já vinculado, convites e unicidade. PATCH ativo altera a ficha; inativar o usuário também impede disponibilidade.

PUT agenda substitui todas as janelas ativas (`janelas`), incluindo lista vazia. Dias ISO 1–7, hora local `HH:mm[:ss]`, duração 30–60 minutos. Não permite sobreposição; consultas existentes permanecem. Bloqueios exigem inicio/fim com offset e motivo; conflito com consulta AGENDADA retorna 409. DELETE é lógico.

POST consulta: medicoId/inicio e pacienteId somente quando ADMIN; para PACIENTE o identificador da sessão prevalece. O paciente deve estar ativo e ativado pelo Google, inclusive no cadastro feito pelo ADMIN. O fim é calculado pelo servidor, não enviado. Disponibilidade é fotografia e será revalidada na confirmação. Fora da agenda/passado/inativo retorna 422; conflito 409. Nunca presumir confirmação após erro de rede: consultar o histórico antes de reenviar.

Reagendamento recebe inicio e motivo opcional (somente aviso interno); mantém o ID. Cancelamento exige motivo e mantém histórico. PACIENTE altera apenas a própria consulta até 24h antes do início; MEDICO somente cancela a própria agenda antes do atendimento; ADMIN cancela/reagenda antes do atendimento. Fora do prazo: 422 e orientação para falar com a clínica. Consulta de terceiro: 404. Conclusão é manual, ADMIN ou médico responsável depois do fim; repetição retorna a mesma consulta CONCLUIDA. Paciente não conclui.

Paginação: page começa em 0; size padrão 20, máximo 100; resposta `content,page,size,totalElements,totalPages`. Médicos aceitam ativo/especialidade (não ADMIN não lista inativos); consultas administrativas aceitam inicio/fim (datas inclusivas), medicoId/pacienteId/status. Consultas próprias aceitam status. Notificações aceitam somenteNaoLidas; leitura é idempotente e retorna 204.

Google Agenda: status informa disponivel/conectado/sincronizacaoAtiva/requerReconexao/falhas. Conectar por navegação completa, com a sessão atual. Callback volta à URL fixa com código `google_agenda`; chamar status novamente. DELETE e reprocessamento exigem CSRF. Falhas de sincronização não significam falha da consulta. Sem backfill; desconexão mantém os eventos existentes. [Configuração e regras](GOOGLE-AGENDA.md).

O contrato completo de campos, formatos e códigos é o [OpenAPI](openapi.yaml). Este trabalho não altera interfaces React ou Capacitor.
