-- Agenda SA - validação das restrições do banco (V1 + V2)
--
-- Rode num banco onde o Flyway já aplicou V1 e V2 (psql, DBeaver ou pgAdmin).
-- Tudo acontece numa transação desfeita no fim: nenhum dado fica gravado.
-- Cada verificação imprime "OK: ..."; a primeira que falhar interrompe com "FALHOU: ...".
-- No DBeaver, as mensagens aparecem na aba "Output" (habilite "Show server output").

BEGIN;

-- Dados de apoio, com e-mails e CRMs que não colidem com dados reais.
INSERT INTO usuario (nome, email, senha_hash, perfil)
VALUES ('Validação Paciente A', 'validacao.a@example.com', 'hash', 'PACIENTE'),
       ('Validação Paciente B', 'validacao.b@example.com', 'hash', 'PACIENTE'),
       ('Validação Admin', 'validacao.admin@example.com', 'hash', 'ADMINISTRADOR');

INSERT INTO medico (nome, crm, uf_crm, especialidade)
VALUES ('Validação Médico 1', 'VAL-0001', 'SC', 'Clínica geral'),
       ('Validação Médico 2', 'VAL-0002', 'SC', 'Cardiologia');

DO $$
DECLARE
    pa BIGINT := (SELECT id FROM usuario WHERE email = 'validacao.a@example.com');
    pb BIGINT := (SELECT id FROM usuario WHERE email = 'validacao.b@example.com');
    adm BIGINT := (SELECT id FROM usuario WHERE email = 'validacao.admin@example.com');
    m1 BIGINT := (SELECT id FROM medico WHERE crm = 'VAL-0001');
    m2 BIGINT := (SELECT id FROM medico WHERE crm = 'VAL-0002');
    base TIMESTAMPTZ := date_trunc('day', now()) + INTERVAL '30 days 10 hours';
    cancelada BIGINT;
BEGIN
    -- usuario ---------------------------------------------------------------
    BEGIN
        INSERT INTO usuario (nome, email, senha_hash, perfil)
        VALUES ('Duplicado', 'VALIDACAO.A@example.com', 'hash', 'PACIENTE');
        RAISE EXCEPTION 'FALHOU: e-mail repetido com outra caixa foi aceito';
    EXCEPTION WHEN unique_violation THEN
        RAISE NOTICE 'OK: e-mail repetido é rejeitado, sem diferenciar maiúsculas';
    END;

    BEGIN
        INSERT INTO usuario (nome, email, senha_hash, perfil)
        VALUES ('Perfil antigo', 'validacao.antigo@example.com', 'hash', 'ADMIN');
        RAISE EXCEPTION 'FALHOU: perfil ADMIN (anterior à V2) foi aceito';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'OK: perfil ADMIN é rejeitado depois da V2';
    END;

    INSERT INTO usuario (nome, email, senha_hash, perfil)
    VALUES ('Validação Médico', 'validacao.medico@example.com', 'hash', 'MEDICO'),
           ('Validação Recepção', 'validacao.recepcao@example.com', 'hash', 'RECEPCIONISTA');
    RAISE NOTICE 'OK: perfis MEDICO e RECEPCIONISTA são aceitos (V2)';

    BEGIN
        INSERT INTO usuario (nome, email, senha_hash, perfil)
        VALUES ('   ', 'validacao.vazio@example.com', 'hash', 'PACIENTE');
        RAISE EXCEPTION 'FALHOU: nome em branco foi aceito';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'OK: nome em branco é rejeitado';
    END;

    -- medico ----------------------------------------------------------------
    BEGIN
        INSERT INTO medico (nome, crm, uf_crm, especialidade)
        VALUES ('Duplicado', 'VAL-0001', 'SC', 'Pediatria');
        RAISE EXCEPTION 'FALHOU: CRM/UF repetido foi aceito';
    EXCEPTION WHEN unique_violation THEN
        RAISE NOTICE 'OK: CRM repetido na mesma UF é rejeitado';
    END;

    INSERT INTO medico (nome, crm, uf_crm, especialidade)
    VALUES ('Mesmo CRM, outra UF', 'VAL-0001', 'PR', 'Pediatria');
    RAISE NOTICE 'OK: o mesmo número de CRM em outra UF é aceito';

    BEGIN
        INSERT INTO medico (nome, crm, uf_crm, especialidade)
        VALUES ('UF minúscula', 'VAL-0003', 'sc', 'Pediatria');
        RAISE EXCEPTION 'FALHOU: UF minúscula foi aceita';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'OK: UF fora do padrão é rejeitada';
    END;

    -- agenda_medico -----------------------------------------------------------
    INSERT INTO agenda_medico (medico_id, dia_semana, hora_inicio, hora_fim, duracao_minutos)
    VALUES (m1, 1, '08:00', '12:00', 30),
           (m1, 1, '13:30', '17:30', 30);
    RAISE NOTICE 'OK: duas janelas no mesmo dia são aceitas';

    BEGIN
        INSERT INTO agenda_medico (medico_id, dia_semana, hora_inicio, hora_fim, duracao_minutos)
        VALUES (m1, 1, '08:00', '12:00', 30);
        RAISE EXCEPTION 'FALHOU: janela repetida foi aceita';
    EXCEPTION WHEN unique_violation THEN
        RAISE NOTICE 'OK: janela repetida é rejeitada';
    END;

    BEGIN
        INSERT INTO agenda_medico (medico_id, dia_semana, hora_inicio, hora_fim, duracao_minutos)
        VALUES (m1, 8, '08:00', '12:00', 30);
        RAISE EXCEPTION 'FALHOU: dia da semana 8 foi aceito';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'OK: dia da semana fora de 1 a 7 é rejeitado';
    END;

    BEGIN
        INSERT INTO agenda_medico (medico_id, dia_semana, hora_inicio, hora_fim, duracao_minutos)
        VALUES (m1, 2, '12:00', '08:00', 30);
        RAISE EXCEPTION 'FALHOU: janela com fim antes do início foi aceita';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'OK: janela invertida é rejeitada';
    END;

    BEGIN
        INSERT INTO agenda_medico (medico_id, dia_semana, hora_inicio, hora_fim, duracao_minutos)
        VALUES (m1, 2, '08:00', '12:00', 0);
        RAISE EXCEPTION 'FALHOU: duração zero foi aceita';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'OK: duração fora de 5 a 480 minutos é rejeitada';
    END;

    -- bloqueio_agenda ---------------------------------------------------------
    BEGIN
        INSERT INTO bloqueio_agenda (medico_id, inicio, fim, motivo)
        VALUES (m1, base, base - INTERVAL '1 hour', 'Invertido');
        RAISE EXCEPTION 'FALHOU: bloqueio com fim antes do início foi aceito';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'OK: bloqueio invertido é rejeitado';
    END;

    -- agendamento -------------------------------------------------------------
    INSERT INTO agendamento (paciente_id, medico_id, criado_por_id, inicio, fim)
    VALUES (pa, m1, pa, base, base + INTERVAL '30 minutes');

    BEGIN
        INSERT INTO agendamento (paciente_id, medico_id, criado_por_id, inicio, fim)
        VALUES (pb, m1, pb, base + INTERVAL '15 minutes', base + INTERVAL '45 minutes');
        RAISE EXCEPTION 'FALHOU: duas consultas sobrepostas para o mesmo médico';
    EXCEPTION WHEN exclusion_violation THEN
        RAISE NOTICE 'OK: médico não recebe consultas sobrepostas';
    END;

    BEGIN
        INSERT INTO agendamento (paciente_id, medico_id, criado_por_id, inicio, fim)
        VALUES (pa, m2, pa, base + INTERVAL '10 minutes', base + INTERVAL '40 minutes');
        RAISE EXCEPTION 'FALHOU: paciente com duas consultas sobrepostas';
    EXCEPTION WHEN exclusion_violation THEN
        RAISE NOTICE 'OK: paciente não ocupa duas consultas ao mesmo tempo';
    END;

    INSERT INTO agendamento (paciente_id, medico_id, criado_por_id, inicio, fim)
    VALUES (pb, m1, adm, base + INTERVAL '30 minutes', base + INTERVAL '60 minutes');
    RAISE NOTICE 'OK: consulta que começa quando a anterior termina é aceita';

    BEGIN
        INSERT INTO agendamento (paciente_id, medico_id, criado_por_id, inicio, fim)
        VALUES (pb, m2, pb, base + INTERVAL '2 hours', base + INTERVAL '2 hours');
        RAISE EXCEPTION 'FALHOU: consulta com duração zero foi aceita';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'OK: consulta com fim igual ao início é rejeitada';
    END;

    BEGIN
        INSERT INTO agendamento (paciente_id, medico_id, criado_por_id, inicio, fim, status)
        VALUES (pb, m2, pb, base + INTERVAL '3 hours', base + INTERVAL '210 minutes', 'CANCELADA');
        RAISE EXCEPTION 'FALHOU: cancelamento sem data e autor foi aceito';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'OK: consulta cancelada exige data e autor do cancelamento';
    END;

    BEGIN
        INSERT INTO agendamento (paciente_id, medico_id, criado_por_id, inicio, fim, status)
        VALUES (pb, m2, pb, base + INTERVAL '4 hours', base + INTERVAL '270 minutes', 'REMARCADA');
        RAISE EXCEPTION 'FALHOU: status fora da lista foi aceito';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'OK: status fora de AGENDADA/CANCELADA/CONCLUIDA é rejeitado';
    END;

    UPDATE agendamento
       SET status = 'CANCELADA', cancelado_em = now(), cancelado_por_id = pa,
           motivo_cancelamento = 'Validação'
     WHERE paciente_id = pa AND medico_id = m1 AND inicio = base
    RETURNING id INTO cancelada;

    INSERT INTO agendamento (paciente_id, medico_id, criado_por_id, inicio, fim)
    VALUES (pb, m1, pb, base, base + INTERVAL '30 minutes');
    RAISE NOTICE 'OK: cancelar libera o horário para outra consulta';

    BEGIN
        UPDATE agendamento SET status = 'AGENDADA', cancelado_em = NULL, cancelado_por_id = NULL
         WHERE id = cancelada;
        RAISE EXCEPTION 'FALHOU: reativar a consulta cancelada criou sobreposição';
    EXCEPTION WHEN exclusion_violation THEN
        RAISE NOTICE 'OK: reativar consulta cancelada respeita a ocupação do horário';
    END;

    -- notificacao -------------------------------------------------------------
    INSERT INTO notificacao (usuario_id, agendamento_id, tipo, canal, mensagem)
    VALUES (pa, cancelada, 'CANCELAMENTO', 'SISTEMA', 'Sua consulta foi cancelada.');
    RAISE NOTICE 'OK: notificação válida é aceita (status inicial PENDENTE)';

    BEGIN
        INSERT INTO notificacao (usuario_id, agendamento_id, tipo, canal, mensagem)
        VALUES (pa, cancelada, 'PROMOCAO', 'SISTEMA', 'Mensagem');
        RAISE EXCEPTION 'FALHOU: tipo de notificação fora da lista foi aceito';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'OK: tipo de notificação fora da lista é rejeitado';
    END;

    BEGIN
        INSERT INTO notificacao (usuario_id, agendamento_id, tipo, canal, mensagem)
        VALUES (pa, cancelada, 'LEMBRETE', 'SMS', 'Mensagem');
        RAISE EXCEPTION 'FALHOU: canal SMS foi aceito';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'OK: canal fora de SISTEMA/EMAIL é rejeitado';
    END;

    -- gatilhos de atualizado_em ------------------------------------------------
    IF (SELECT count(*) FROM pg_trigger
         WHERE NOT tgisinternal AND tgname LIKE 'tg\_%\_atualizado\_em') <> 5 THEN
        RAISE EXCEPTION 'FALHOU: esperados 5 gatilhos de atualizado_em';
    END IF;
    RAISE NOTICE 'OK: os 5 gatilhos de atualizado_em existem';

    RAISE NOTICE 'Validação concluída: todas as verificações passaram.';
END $$;

ROLLBACK;

-- Roteiro manual de concorrência (duas conexões abertas ao mesmo tempo)
--
-- Conexão 1:
--   BEGIN;
--   INSERT INTO agendamento (paciente_id, medico_id, criado_por_id, inicio, fim)
--   VALUES (<paciente A>, <médico>, <paciente A>, '2026-12-01 10:00-03', '2026-12-01 10:30-03');
--   -- não confirme ainda
-- Conexão 2:
--   BEGIN;
--   INSERT INTO agendamento (paciente_id, medico_id, criado_por_id, inicio, fim)
--   VALUES (<paciente B>, <mesmo médico>, <paciente B>, '2026-12-01 10:15-03', '2026-12-01 10:45-03');
--   -- fica esperando a conexão 1
-- Conexão 1:
--   COMMIT;
-- Resultado esperado na conexão 2: erro "conflicting key value violates exclusion
-- constraint ex_agendamento_medico_sem_sobreposicao". A API deve devolver 409.
-- Depois: ROLLBACK na conexão 2 e apague a consulta de teste da conexão 1.
