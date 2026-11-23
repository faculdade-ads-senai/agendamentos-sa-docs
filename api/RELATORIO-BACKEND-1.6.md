# Entrega do backend REST — Agenda SA 1.6.0

## 1. Resumo

Implementados os módulos na ordem aprovada: médicos/agendas/bloqueios; disponibilidade/agendamentos; notificações/Outbox; Google Agenda opcional; testes/documentação. O cadastro de médico novo cria Usuario e ficha profissional na mesma transação. Alternativamente vincula um MEDICO ativo existente, sem duplicar a pessoa. A resposta inclui usuarioId para emissão separada do convite.

Preservados login Google, convites, sessões, logout, CSRF, CORS, perfis ADMIN/MEDICO/PACIENTE e criptografia cadastral. Nenhum arquivo do frontend foi modificado. Nenhuma migração V1–V7 foi alterada. Não foram executadas migrações no banco de desenvolvimento/produção nem rebase. Os commits de entrega utilizam as branches master do backend e main da documentação, conforme os commits anteriores. Na publicação, o histórico remoto da documentação foi integrado por merge, preservando as atualizações compatíveis e os contratos atuais da versão 1.6.0.

Diagnóstico: OpenAPI inicial 1.5.0; tabelas de negócio existentes, mas módulos ausentes neste checkout. Código de médicos/agendas dos PRs revisados foi aproveitado e adaptado, sem importar a segurança JWT antiga. Corrigidos criação de usuário sem dados pessoais, identidade duplicada e atualização de email que ignorava as proteções Google. Decisões antigas de email/.ics foram explicitamente substituídas por notificações internas e Calendar opcional. O contrato atual é 1.6.0.

## 2. Endpoints

Prefixo `/api/v1`. Todas as escritas exigem sessão e CSRF. Paginação inicia em 0, size padrão 20/máximo 100.

| Método | Caminho | Regra principal |
|---|---|---|
| GET | /medicos | Listagem paginada; leitura autenticada |
| POST | /medicos | ADMIN; cadastro completo ou vínculo exclusivo |
| GET | /medicos/{medicoId} | Leitura autenticada |
| PATCH | /medicos/{medicoId} | ADMIN; atualização/desativação lógica |
| GET | /medicos/{medicoId}/agenda | Leitura autenticada |
| PUT | /medicos/{medicoId}/agenda | ADMIN; substitui janelas, preserva consultas |
| GET | /medicos/{medicoId}/bloqueios | ADMIN |
| POST | /medicos/{medicoId}/bloqueios | ADMIN; rejeita conflito com consulta |
| DELETE | /medicos/{medicoId}/bloqueios/{bloqueioId} | ADMIN; exclusão lógica |
| GET | /medicos/{medicoId}/horarios-disponiveis | Agenda/bloqueios/consultas/estado/fuso reais |
| POST | /agendamentos | ADMIN/PACIENTE; paciente ativo e ativado |
| GET | /agendamentos | ADMIN; filtros/paginação |
| GET | /agendamentos/me | Consultas próprias de paciente/médico |
| GET | /agendamentos/{agendamentoId} | ADMIN ou participante autorizado |
| PATCH | /agendamentos/{agendamentoId}/reagendamento | ADMIN ou paciente proprietário; prazo |
| PATCH | /agendamentos/{agendamentoId}/cancelamento | ADMIN, paciente/médico responsável; motivo |
| GET | /notificacoes/me | Somente destinatário; filtro não lidas |
| PATCH | /notificacoes/{notificacaoId}/leitura | Somente destinatário; idempotente |
| PATCH | /agendamentos/{agendamentoId}/conclusao | ADMIN/médico responsável após fim; auditada/idempotente |
| GET | /integracoes/google-agenda/status | PACIENTE; conexão própria, sem tokens |
| GET | /integracoes/google-agenda/conectar | PACIENTE; navegação completa |
| GET | /integracoes/google-agenda/callback | Sessão original + state/nonce/PKCE/OIDC |
| DELETE | /integracoes/google-agenda | PACIENTE; desconexão própria |
| POST | /integracoes/google-agenda/reprocessamento | PACIENTE conectado; falhas próprias |
| POST | /admin/outbox/{entregaId}/reprocessamento | ADMIN; somente falha terminal |

São 18 operações originais e 7 operações adicionais justificadas pelo plano aprovado: conclusão manual, cinco operações Calendar e reprocessamento administrativo. Parâmetros/corpos/respostas estão no [OpenAPI](openapi.yaml) e no [guia de consumo](GUIA-CONSUMO-1.6.md).

## 3. Arquivos

O inventário completo por arquivo e responsabilidade está no final deste relatório. Alterações locais preexistentes em `.gitignore`, wrapper Maven, application-dev.yaml e ENTREGA-SSO.md foram preservadas. `.env.example` recebeu somente as variáveis adicionais, mantendo as alterações locais anteriores. `.env` privado não foi modificado.

## 4. Migrações

| Migração nova | Efeito |
|---|---|
| V8__medico_identidade_usuario | Permite nome profissional nulo quando a identidade vem de Usuario; preserva legados sem vínculo |
| V9__auditoria_agendamento | Versão otimista e autoria/data de conclusão |
| V10__outbox_entregas | Eventos/entregas independentes, leases/retentativas e deduplicação de notificações |
| V11__google_agenda | Conexão com refresh criptografado e vínculo estável consulta/evento |

Reutilizadas as constraints GiST de sobreposição por médico **e paciente**. Testes aplicaram V1→V11 em PostgreSQL descartável e V7→V11 com usuários, médicos e consulta existentes, verificando preservação dos IDs/vínculos. Não há dados pessoais fictícios inseridos em registros existentes.

## 5. Arquitetura assíncrona

Consulta e evento Outbox são gravados na mesma transação. Entregas de notificação e Calendar são independentes. Worker Scheduled usa lotes, `FOR UPDATE SKIP LOCKED`, lease/dono, recuperação, backoff exponencial com jitter, até dez tentativas e falha terminal reprocessável. Não considera o evento integralmente concluído enquanto houver entrega pendente/falha.

HTTP não integra a transação principal. Identificador Google é persistido antes da criação; respostas desconhecidas são reconciliadas pelo ID e marca privada. O consumidor relê o estado atual e verifica a versão após o HTTP. Reagendamento/cancelamento prevalecem eventualmente sobre eventos antigos. Um evento pessoal sem a marca da aplicação não é alterado. Detalhes e monitoramento: [OUTBOX](../arquitetura/OUTBOX.md).

Notificações internas avisam paciente/médico, exceto ator. Lembrete ocorre uma vez por versão nas próximas 24h; versões obsoletas são descartadas. Motivo opcional do reagendamento fica criptografado na Outbox até compor o aviso interno; não é enviado ao Google. Não foram adicionados email, WhatsApp, SMS, RabbitMQ ou Kafka.

## 6. Segurança

Autorização por perfil e proprietário ocorre no backend. Médico não cria/reagenda consulta; só cancela a própria agenda antes do atendimento. Paciente só altera a própria consulta até 24h antes, inclusive o limite exato. ADMIN altera consultas antes do atendimento. Consulta de terceiro retorna 404; regras/prazo 422; conflito 409. Conclusão somente após o fim. Nenhum desses controles depende do frontend.

Calendar usa outro cliente OAuth, sem mudar o principal SSO. State de uso único/10min, nonce, PKCE S256, assinatura/emissor/audiência/validade do ID token e mesmo sub do login. Refresh tokens ficam em AES-256-GCM com chave própria versionada e AAD de finalidade/usuário; access tokens somente em memória. Falhas técnicas não expõem respostas brutas ou credenciais.

Desconexão e uso das credenciais são serializados por lock PostgreSQL entre instâncias. A desconexão remove credenciais e invalida a geração antes de tentar revogação remota; mantém consultas, sessão local e eventos existentes. Não há novas chamadas após desconexão efetiva. Consistência com Google é eventual; não há promessa de atomicidade distribuída ou exclusão instantânea de uma requisição já em voo.

## 7. Configuração Google Cloud

Calendar está desabilitado por padrão. Criar cliente OAuth Web dedicado no mesmo projeto Google, habilitar Calendar API, configurar consentimento/usuários de teste e registrar callback exato. Em produção usar HTTPS e avaliar verificação OAuth. A conta deve ser a mesma do SSO; não há backfill das consultas anteriores à conexão.

Novas variáveis: GOOGLE_AGENDA_ENABLED, GOOGLE_AGENDA_CLIENT_ID, GOOGLE_AGENDA_CLIENT_SECRET, GOOGLE_AGENDA_REDIRECT_URI, GOOGLE_AGENDA_RETURN_URI, GOOGLE_AGENDA_ENCRYPTION_KEY_BASE64, GOOGLE_AGENDA_KEY_VERSION, GOOGLE_AGENDA_PREVIOUS_KEYS_JSON e CONSULTORIO_LOCAL opcional. Credenciais/chaves já existentes permanecem necessárias. Não reutilizar AES/HMAC cadastrais no calendário.

Revogação entre clientes do mesmo projeto Google pode exigir novo consentimento em um login futuro. Não invalida a sessão HTTP atual. Procedimentos, escopos oficiais, backup/rotação de chaves e validação manual: [GOOGLE-AGENDA](GOOGLE-AGENDA.md).

## 8. Testes executados

Comando real final: `D:\apache-maven-3.9.16\bin\mvn.cmd -Dmaven.repo.local=D:/agenda-sa/.m2/repository package`.

Resultado: **BUILD SUCCESS — 148 testes encontrados; 145 passaram; zero falhas/erros; 3 ignorados pela condição opt-in já existente.** Artefato gerado: `agendamentos-sa-backend/target/agenda-sa-0.0.1-SNAPSHOT.jar`. Evidência local: `target/validacao-final.log` e relatórios Surefire.

| Grupo | Resultado final |
|---|---|
| Novos cenários REST/negócio/PostgreSQL | 43 passaram |
| Cliente HTTP Google simulado | 10 passaram |
| Chaveiro AES-GCM/rotação/integridade | 4 passaram |
| YAML OpenAPI e referências locais | 1 passou |
| Regressão autenticação/sessões/CSRF/convites/usuários/criptografia | 87 passaram |
| UsuarioPersistenceTest opt-in externo | 3 ignorados na execução padrão |

Incluem: todas as 18 rotas originais e operações adicionais, permissões/IDOR/CSRF, validação/paginação, criação completa e vínculo de médico, disponibilidade, conflitos por médico/paciente, reagendamentos simultâneos, cancelamento concorrente, bloqueio versus reserva, alteração da agenda com consulta existente, limite exato de 24h, conclusão manual, rollback da Outbox, consumidores independentes, workers concorrentes, lease/dono, limites/reprocessamento, lembretes, state de uso único, ID tokens RSA assinados, assinatura inválida, conta Google diferente, falta de refresh, consentimento cancelado, revogação, desconexão, eventos apagados e resultado desconhecido sem duplicação.

Os testes de negócio iniciaram PostgreSQL 14.15 temporário, sem acessar o banco de desenvolvimento. Validação no PostgreSQL da hospedagem permanece parte da publicação. Recuperação foi testada por persistência/reivindicação e lease; não foi realizado teste de queda/reinício real de processo em produção. A verificação OpenAPI cobre parsing/referências e contratos exercitados; não equivale a certificação por todas as ferramentas externas de OpenAPI.

`git diff --check` passou nos dois repositórios. Frontend permanece sem alterações. Migrações históricas permanecem sem diferenças. O Maven obteve plugins de empacotamento já definidos pelo projeto; nenhuma dependência de aplicação foi adicionada ao pom.xml.

## 9. Pendências reais

- Configurar cliente/segredos/chave do calendário e consentimento Google Cloud; executar validação manual ponta a ponta com conta real. Nenhum acesso real à Calendar API foi declarado validado.
- Publicar com HTTPS, cookies/origens corretos e backup seguro das chaves/banco; validar migrações em cópia isolada da base e versão PostgreSQL da hospedagem.
- Executar os testes antigos opt-in com banco externo **descartável**: a tentativa separada não foi iniciada porque a revisão automática de aprovação falhou por limite de uso. Não houve avaliação de insegurança nem execução da ação. Não foi contornada a aprovação. Os testes novos de negócio/banco e os testes existentes de aplicação executaram normalmente em suas instâncias descartáveis.

Não há pendência de implementação de frontend neste trabalho, pois ele foi expressamente excluído do escopo.


## Inventario de arquivos desta entrega

### Backend

| Arquivo | Responsabilidade |
|---|---|
| [.env.example](../../agendamentos-sa-backend/.env.example) | Configuracao adicional do calendario, somente exemplos ficticios |
| [README.md](../../agendamentos-sa-backend/README.md) | Execucao, build, testes e referencias aos contratos |
| [src/main/java/com/agendaSa/agendamentos/controller/AgendamentoController.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendamentos/controller/AgendamentoController.java) | Rotas REST, validacao e respostas HTTP |
| [src/main/java/com/agendaSa/agendamentos/dto/AgendamentoResponse.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendamentos/dto/AgendamentoResponse.java) | Contrato de entrada/saida validado e minimizado |
| [src/main/java/com/agendaSa/agendamentos/dto/CancelarAgendamentoRequest.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendamentos/dto/CancelarAgendamentoRequest.java) | Contrato de entrada/saida validado e minimizado |
| [src/main/java/com/agendaSa/agendamentos/dto/CriarAgendamentoRequest.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendamentos/dto/CriarAgendamentoRequest.java) | Contrato de entrada/saida validado e minimizado |
| [src/main/java/com/agendaSa/agendamentos/dto/ReagendarAgendamentoRequest.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendamentos/dto/ReagendarAgendamentoRequest.java) | Contrato de entrada/saida validado e minimizado |
| [src/main/java/com/agendaSa/agendamentos/model/Agendamento.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendamentos/model/Agendamento.java) | Entidade JPA/estado persistido |
| [src/main/java/com/agendaSa/agendamentos/model/StatusAgendamento.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendamentos/model/StatusAgendamento.java) | Entidade JPA/estado persistido |
| [src/main/java/com/agendaSa/agendamentos/repository/AgendamentoRepository.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendamentos/repository/AgendamentoRepository.java) | Persistencia e consultas/locks |
| [src/main/java/com/agendaSa/agendamentos/service/AgendamentoService.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendamentos/service/AgendamentoService.java) | Regras de negocio e transacoes |
| [src/main/java/com/agendaSa/agendas/config/AgendaConfig.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendas/config/AgendaConfig.java) | Clock/fuso de negocio injetavel em testes |
| [src/main/java/com/agendaSa/agendas/controller/v1/AgendaController.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendas/controller/v1/AgendaController.java) | Rotas REST, validacao e respostas HTTP |
| [src/main/java/com/agendaSa/agendas/dto/AgendaItemRequest.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendas/dto/AgendaItemRequest.java) | Contrato de entrada/saida validado e minimizado |
| [src/main/java/com/agendaSa/agendas/dto/AgendaItemResponse.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendas/dto/AgendaItemResponse.java) | Contrato de entrada/saida validado e minimizado |
| [src/main/java/com/agendaSa/agendas/dto/AgendaMedicoRequest.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendas/dto/AgendaMedicoRequest.java) | Contrato de entrada/saida validado e minimizado |
| [src/main/java/com/agendaSa/agendas/dto/AgendaMedicoResponse.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendas/dto/AgendaMedicoResponse.java) | Contrato de entrada/saida validado e minimizado |
| [src/main/java/com/agendaSa/agendas/dto/BloqueioAgendaRequest.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendas/dto/BloqueioAgendaRequest.java) | Contrato de entrada/saida validado e minimizado |
| [src/main/java/com/agendaSa/agendas/dto/BloqueioAgendaResponse.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendas/dto/BloqueioAgendaResponse.java) | Contrato de entrada/saida validado e minimizado |
| [src/main/java/com/agendaSa/agendas/dto/HorarioDisponivelResponse.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendas/dto/HorarioDisponivelResponse.java) | Contrato de entrada/saida validado e minimizado |
| [src/main/java/com/agendaSa/agendas/mapper/AgendaMapper.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendas/mapper/AgendaMapper.java) | Conversao para respostas sem exposicao de entidades |
| [src/main/java/com/agendaSa/agendas/model/AgendaMedico.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendas/model/AgendaMedico.java) | Entidade JPA/estado persistido |
| [src/main/java/com/agendaSa/agendas/model/BloqueioAgenda.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendas/model/BloqueioAgenda.java) | Entidade JPA/estado persistido |
| [src/main/java/com/agendaSa/agendas/repository/AgendaMedicoRepository.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendas/repository/AgendaMedicoRepository.java) | Persistencia e consultas/locks |
| [src/main/java/com/agendaSa/agendas/repository/BloqueioAgendaRepository.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendas/repository/BloqueioAgendaRepository.java) | Persistencia e consultas/locks |
| [src/main/java/com/agendaSa/agendas/repository/OcupacaoAgendaRepository.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendas/repository/OcupacaoAgendaRepository.java) | Persistencia e consultas/locks |
| [src/main/java/com/agendaSa/agendas/service/AgendaService.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/agendas/service/AgendaService.java) | Regras de negocio e transacoes |
| [src/main/java/com/agendaSa/auth/config/SecurityConfig.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/auth/config/SecurityConfig.java) | Permissoes das novas rotas; preserva SSO, CSRF, CORS e sessoes |
| [src/main/java/com/agendaSa/integracoes/googleagenda/CalendarCrypto.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/integracoes/googleagenda/CalendarCrypto.java) | Criptografia de refresh tokens e independencia de chaves/clientes |
| [src/main/java/com/agendaSa/integracoes/googleagenda/CalendarOAuthService.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/integracoes/googleagenda/CalendarOAuthService.java) | Consentimento separado, PKCE, state, nonce, identidade e desconexao |
| [src/main/java/com/agendaSa/integracoes/googleagenda/CalendarStore.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/integracoes/googleagenda/CalendarStore.java) | Persistencia das conexoes/vinculos e lock PostgreSQL entre instancias |
| [src/main/java/com/agendaSa/integracoes/googleagenda/CalendarSync.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/integracoes/googleagenda/CalendarSync.java) | Reconciliacao dos eventos com o estado atual e IDs estaveis |
| [src/main/java/com/agendaSa/integracoes/googleagenda/GoogleAgendaConfig.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/integracoes/googleagenda/GoogleAgendaConfig.java) | Configuracao opcional validada, sem imprimir segredos |
| [src/main/java/com/agendaSa/integracoes/googleagenda/GoogleAgendaController.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/integracoes/googleagenda/GoogleAgendaController.java) | Cinco rotas REST/navegacao da integracao propria |
| [src/main/java/com/agendaSa/integracoes/googleagenda/GoogleFalha.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/integracoes/googleagenda/GoogleFalha.java) | Codigos tecnicos sanitizados e classificacao de falhas |
| [src/main/java/com/agendaSa/integracoes/googleagenda/GoogleGateway.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/integracoes/googleagenda/GoogleGateway.java) | Interface simulavel para OAuth e Calendar API |
| [src/main/java/com/agendaSa/integracoes/googleagenda/GoogleHttpGateway.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/integracoes/googleagenda/GoogleHttpGateway.java) | HTTP com timeouts, endpoints fixos e tratamento de respostas |
| [src/main/java/com/agendaSa/medicos/controller/v1/MedicoController.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/medicos/controller/v1/MedicoController.java) | Rotas REST, validacao e respostas HTTP |
| [src/main/java/com/agendaSa/medicos/dto/AtualizarMedicoRequest.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/medicos/dto/AtualizarMedicoRequest.java) | Contrato de entrada/saida validado e minimizado |
| [src/main/java/com/agendaSa/medicos/dto/MedicoPageResponse.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/medicos/dto/MedicoPageResponse.java) | Contrato de entrada/saida validado e minimizado |
| [src/main/java/com/agendaSa/medicos/dto/MedicoRequest.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/medicos/dto/MedicoRequest.java) | Contrato de entrada/saida validado e minimizado |
| [src/main/java/com/agendaSa/medicos/dto/MedicoResponse.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/medicos/dto/MedicoResponse.java) | Contrato de entrada/saida validado e minimizado |
| [src/main/java/com/agendaSa/medicos/exception/MedicoExceptionHandler.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/medicos/exception/MedicoExceptionHandler.java) | Falha de dominio e Problem Details |
| [src/main/java/com/agendaSa/medicos/exception/MedicoNaoEncontradoException.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/medicos/exception/MedicoNaoEncontradoException.java) | Falha de dominio e Problem Details |
| [src/main/java/com/agendaSa/medicos/model/Medico.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/medicos/model/Medico.java) | Entidade JPA/estado persistido |
| [src/main/java/com/agendaSa/medicos/repository/MedicoRepository.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/medicos/repository/MedicoRepository.java) | Persistencia e consultas/locks |
| [src/main/java/com/agendaSa/medicos/service/MedicoService.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/medicos/service/MedicoService.java) | Regras de negocio e transacoes |
| [src/main/java/com/agendaSa/notificacoes/NotificacaoController.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/notificacoes/NotificacaoController.java) | Listagem propria e leitura idempotente |
| [src/main/java/com/agendaSa/notificacoes/NotificacaoService.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/notificacoes/NotificacaoService.java) | Persistencia/deduplicacao de avisos e lembretes internos |
| [src/main/java/com/agendaSa/outbox/Entrega.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/outbox/Entrega.java) | Identidade da entrega, versao, consumidor e dono do lease |
| [src/main/java/com/agendaSa/outbox/EntregaStore.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/outbox/EntregaStore.java) | Reivindicacao SKIP LOCKED, lease, backoff e reprocessamento |
| [src/main/java/com/agendaSa/outbox/OutboxController.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/outbox/OutboxController.java) | Reprocessamento administrativo restrito a falhas terminais |
| [src/main/java/com/agendaSa/outbox/OutboxService.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/outbox/OutboxService.java) | Gravacao atomica de eventos/entregas e motivo protegido |
| [src/main/java/com/agendaSa/outbox/OutboxWorker.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/outbox/OutboxWorker.java) | Processamento periodico de consumidores independentes |
| [src/main/java/com/agendaSa/shared/crypto/EncryptionKeyring.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/shared/crypto/EncryptionKeyring.java) | Envelope AES-256-GCM versionado com nonce e AAD |
| [src/main/java/com/agendaSa/shared/dto/Pagina.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/shared/dto/Pagina.java) | Formato comum de resposta paginada |
| [src/main/java/com/agendaSa/shared/exception/ValidacaoProfissionaisExceptionHandler.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/shared/exception/ValidacaoProfissionaisExceptionHandler.java) | Validacoes e JSON invalido sem ecoar dados enviados |
| [src/main/java/com/agendaSa/shared/security/UsuarioAtual.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/shared/security/UsuarioAtual.java) | Identifica usuario atual pelo sub OIDC e perfil no banco |
| [src/main/java/com/agendaSa/usuarios/exception/UsuarioExceptionHandler.java](../../agendamentos-sa-backend/src/main/java/com/agendaSa/usuarios/exception/UsuarioExceptionHandler.java) | Falhas Google, integridade e concorrencia sem detalhes internos |
| [src/main/resources/application.yaml](../../agendamentos-sa-backend/src/main/resources/application.yaml) | Variaveis opcionais Google Agenda com integracao desabilitada por padrao |
| [src/main/resources/db/migration/V10__outbox_entregas.sql](../../agendamentos-sa-backend/src/main/resources/db/migration/V10__outbox_entregas.sql) | Nova migracao aditiva; detalhes na secao 4 |
| [src/main/resources/db/migration/V11__google_agenda.sql](../../agendamentos-sa-backend/src/main/resources/db/migration/V11__google_agenda.sql) | Nova migracao aditiva; detalhes na secao 4 |
| [src/main/resources/db/migration/V8__medico_identidade_usuario.sql](../../agendamentos-sa-backend/src/main/resources/db/migration/V8__medico_identidade_usuario.sql) | Nova migracao aditiva; detalhes na secao 4 |
| [src/main/resources/db/migration/V9__auditoria_agendamento.sql](../../agendamentos-sa-backend/src/main/resources/db/migration/V9__auditoria_agendamento.sql) | Nova migracao aditiva; detalhes na secao 4 |
| [src/test/java/com/agendaSa/ApplicationTests.java](../../agendamentos-sa-backend/src/test/java/com/agendaSa/ApplicationTests.java) | Isola os testes existentes de autenticacao dos schedulers de negocio |
| [src/test/java/com/agendaSa/negocio/EncryptionKeyringTest.java](../../agendamentos-sa-backend/src/test/java/com/agendaSa/negocio/EncryptionKeyringTest.java) | Roundtrip, nonces, AAD, adulteracao, chaves e rotacao |
| [src/test/java/com/agendaSa/negocio/GoogleHttpGatewayTest.java](../../agendamentos-sa-backend/src/test/java/com/agendaSa/negocio/GoogleHttpGatewayTest.java) | Dez cenarios de protocolo HTTP e erros sem servico externo |
| [src/test/java/com/agendaSa/negocio/NegocioIntegrationTest.java](../../agendamentos-sa-backend/src/test/java/com/agendaSa/negocio/NegocioIntegrationTest.java) | 43 cenarios REST, PostgreSQL, migracoes, concorrencia, Outbox e OAuth |
| [src/test/java/com/agendaSa/negocio/OpenApiContractTest.java](../../agendamentos-sa-backend/src/test/java/com/agendaSa/negocio/OpenApiContractTest.java) | Parsing YAML e resolucao das referencias locais do OpenAPI |

### Documentacao

| Arquivo | Responsabilidade |
|---|---|
| [api/openapi.yaml](../api/openapi.yaml) | Contrato 1.6.0, 25 operacoes novas, DTOs, CSRF e respostas |
| [api/CONFORMIDADE.md](../api/CONFORMIDADE.md) | Matriz atual e divergencias justificadas |
| [api/GOOGLE-AGENDA.md](../api/GOOGLE-AGENDA.md) | Google Cloud, seguranca, variaveis, rotacao e validacao manual |
| [api/GUIA-CONSUMO-1.6.md](../api/GUIA-CONSUMO-1.6.md) | Guia para futuro frontend/mobile sem interpretar classes internas |
| [api/RELATORIO-BACKEND-1.6.md](../api/RELATORIO-BACKEND-1.6.md) | Relatorio, resultados reais, limitacoes e inventario |
| [arquitetura/OUTBOX.md](../arquitetura/OUTBOX.md) | Atomicidade, workers, retentativas, idempotencia e operacao |
| [arquitetura/ARQUITETURA.md](../arquitetura/ARQUITETURA.md) | Decisoes atuais e compatibilidade com o historico |
| [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md) | Modelo das novas tabelas/colunas e preservacao de dados |
| [organizacao/BACKLOG.md](../organizacao/BACKLOG.md) | Estado atual dos modulos e decisoes substituidas |
| [requisitos/REQUISITOS.md](../requisitos/REQUISITOS.md) | Regras vigentes e priorizacao sobre decisoes historicas |
