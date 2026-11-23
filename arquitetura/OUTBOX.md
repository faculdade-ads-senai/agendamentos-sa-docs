# Processamento persistente — API 1.6.0

Cada criação, reagendamento ou cancelamento confirma a alteração e `outbox_evento` na mesma transação PostgreSQL. O evento carrega tipo, referência à consulta, versão e ator, sem cópia dos dados pessoais. O motivo opcional do reagendamento é um envelope criptografado destinado somente à notificação interna; não entra no calendário ou em logs. Cada consumidor possui sua própria `outbox_entrega`, com unicidade evento/consumidor. Uma notificação entregue não oculta falha no calendário.

O worker Spring Scheduled reivindica até 20 entregas por passagem com `FOR UPDATE SKIP LOCKED`, dono UUID e lease de dois minutos. Reivindicação, confirmação e falha usam transações curtas; HTTP Google ocorre fora delas. A confirmação verifica o dono: um worker antigo não confirma o trabalho de quem recuperou o lease. Entregas anteriores pendentes/em execução impedem ultrapassagem para o mesmo agregado/consumidor. Falhas terminais deixam de bloquear novas versões: o consumidor Google reconcilia sempre o estado atual.

Processamento pelo menos uma vez. Notificações têm unicidade evento/destinatário; eventos Google possuem IDs previamente persistidos e marca privada verificada. Reconciliação usa a consulta atual e verifica nova versão após HTTP. Um lock advisory de sessão por usuário serializa operações externas entre nós sem manter transações SQL abertas. O lease é recuperado quando expira; operações remotas possuem timeouts de conexão/leitura. Entregas que aguardaram demais no lote são reclamadas em outra passagem, não executadas com lease vencido.

Falhas transitórias usam backoff exponencial a partir de 5 segundos, teto de 1 hora e jitter, respeitando Retry-After numérico maior quando fornecido. Limite de dez tentativas; falhas permanentes entram diretamente em FALHA. Códigos técnicos são sanitizados (`google_429`, `google_conexao` etc.), sem mensagens do provedor. 401/invalid_grant tornam necessária a reconexão e inutilizam o refresh token.

GET/PATCH notificações são restritos ao proprietário. Confirmação, alteração e cancelamento notificam paciente e médico vinculado, exceto o ator. Lembretes internos são gerados uma vez por versão de consulta nas próximas 24 horas, inclusive para criação com menos de 24h de antecedência. Lembrete pendente de versão cancelada/reagendada é descartado. Não há email, Brevo, .ics, SMS ou WhatsApp nesta entrega.

## Operação

- `app.outbox.enabled` padrão true. Desativar somente em testes controlados; se false nenhum scheduler da Outbox/lembretes é habilitado.
- `app.outbox.interval-ms` padrão 1000; `app.outbox.reminder-interval-ms` padrão 60000.
- ADMIN + CSRF: POST `/api/v1/admin/outbox/{entregaId}/reprocessamento`, somente FALHA. Não aceita payload e não repete entrega ativa.
- PACIENTE conectado + CSRF: POST `/api/v1/integracoes/google-agenda/reprocessamento`, somente falhas próprias do consumidor de calendário.
- Monitorar contagens por consumidor/status, idade da entrega pendente mais antiga, leases vencidos e conexões que exigem reconexão. Não selecionar envelopes ou dados pessoais em diagnósticos.

```sql
SELECT consumidor, status, count(*) FROM outbox_entrega GROUP BY consumidor,status;
SELECT min(e.criado_em) FROM outbox_entrega d JOIN outbox_evento e ON e.id=d.evento_id
 WHERE d.status IN ('PENDENTE','PROCESSANDO');
```

O estado agregado é derivado das entregas: somente todas CONCLUIDA significa evento processado; qualquer FALHA exige acompanhamento. Não existe flag única que masque o resultado de um consumidor. Reinicializações mantêm eventos/entregas; não há RabbitMQ/Kafka.

Backups incluem tabelas de negócio/Outbox e chaves independentes protegidas. Não apagar históricos para liberar horários: cancelamento é lógico. Retenção e descarte de histórico precisam seguir a política institucional aplicável; a criptografia não implica conformidade integral com a LGPD.
