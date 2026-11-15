# Backlog — Agendamentos SA

Fonte única do quadro do Trello. Cada cartão do Trello traz a descrição e as listas de verificação deste arquivo; quando os dois divergirem, atualize os dois no mesmo dia.

- Situação conferida em 15/11/2026 nos repositórios ([backend](https://github.com/yuriOdsz/agendamentos-sa), [painel web](https://github.com/VictorKLing/frontend-agendamento)) e no PR #2. O quadro do Trello em si não foi conferido nessa data; a coluna “Lista” diz onde cada cartão deve ficar.
- Prazos são **proposta** até o grupo aprovar.
- Entrega da SA (Desenvolvimento de Sistemas Web, AVA): vence em **08/12/2026 às 00:00**. Enviar até **07/12 às 23:59**. Só há **1 tentativa** de envio.
- Clientes: painel web do administrador (React + Vite) e app do paciente (React + Capacitor, Android), com o mesmo backend Spring Boot e o mesmo contrato.

## Listas

1. Decisões e pendências
2. Backlog
3. Pronto para iniciar
4. Em andamento
5. Em revisão
6. Bloqueado
7. Concluído

## Regra de fluxo

- Cada pessoa mantém no máximo **um** cartão em “Em andamento”.
- Cartão de código só vai para “Em revisão” com PR aberto e link no cartão.
- Cartão só entra em “Concluído” depois da revisão ou do teste de outra pessoa.
- Cartão parado por dependência vai para “Bloqueado”, com o motivo em comentário.
- Mudou rota, campo ou tabela: o contrato ou a modelagem muda no mesmo PR, ou num PR no repositório de docs aberto no mesmo dia.

## Definição de pronto (vale para todos os cartões)

1. Todos os critérios de aceite do cartão conferidos e marcados.
2. Código ou documento no repositório certo, por PR revisado por outra pessoa (cartões de código).
3. `openapi.yaml`, `MODELO_DADOS.md` ou `REQUISITOS.md` atualizados quando a mudança afeta o que eles descrevem.
4. Nenhum segredo (senha, string de conexão, chave do JWT) no Git, no Trello ou na documentação.
5. Link do PR, do commit ou do arquivo anexado ao cartão.

## Etiquetas

- Banco de dados
- Contrato API
- Backend
- Frontend (painel web)
- Mobile (nova: app React + Capacitor)
- Integração
- Testes
- Documentação
- Decisão da equipe
- Sistemas distribuídos (nova: conceito distribuído da SA)
- Apresentação (nova)
- Prioridade alta

## Cronograma proposto

| Período | Foco | Cartões com prazo no período |
|---|---|---|
| Antes de 16/11 | Decisão dos clientes. | DEC-01 (15/11) |
| Semana 1 (16–22/11) | Fechar decisões, requisitos, modelo e contrato; merge do PR #2; banco de produção; base do backend, do painel e do app; autenticação. | DOC-02 (16/11), DEC-02 (18/11), DEC-03 (18/11), REQ-01 (18/11), DB-01 (18/11), DB-04 (19/11), BE-04 (19/11), DB-02 (20/11), DB-03 (20/11), API-01 (20/11), BE-01 (20/11), FE-01W (20/11), BE-02 (22/11), FE-01M (22/11) |
| Semana 2 (23–29/11) | Médicos, agendamentos e publicação do backend; autenticação nos clientes. | BE-03 (25/11), FE-02 (25/11), BE-05 (28/11), BE-08 (29/11) |
| Semana 3 (30/11–06/12) | Notificações e conceito distribuído; telas do paciente e do administrador; testes, integração, aceite e documentação final. | BE-06 (02/12), DIST-01 (02/12), FE-03 (02/12), FE-04 (02/12), BE-07 (03/12), FE-05 (04/12), FE-06 (04/12), INT-01 (04/12), QA-01 (05/12), DOC-01 (06/12) |
| Entrega (07/12) | Ensaio, apresentação e envio no AVA até 23:59. | APR-01 (07/12) |

## Resumo

| ID | Título | Lista | Responsável | Prazo |
|---|---|---|---|---|
| [BE-05](#be-05) | Implementar agendamentos | Backlog | Pierre | 28/11 |
| [BE-06](#be-06) | Implementar notificações | Backlog | Yuri e Pierre | 02/12 |
| [DIST-01](#dist-01) | Aplicar o conceito distribuído: notificações assíncronas | Backlog | Backend a definir (Luís documenta) | 02/12 |
| [BE-07](#be-07) | Testar concorrência e regras críticas | Backlog | Yuri e Pierre (revisor: Luís) | 03/12 |
| [BE-08](#be-08) | Publicar o backend com HTTPS | Backlog | A definir | 29/11 |
| [FE-01M](#fe-01m) | Criar a base do app React + Capacitor | Backlog | A definir | 22/11 |
| [FE-03](#fe-03) | Implementar a área do paciente no app | Backlog | Responsável do app (a definir) | 02/12 |
| [FE-04](#fe-04) | Implementar a área administrativa no painel web | Backlog | Victor | 02/12 |
| [FE-05](#fe-05) | Tratar carregamento, lista vazia e erros no painel e no app | Backlog | Victor e responsável do app | 04/12 |
| [FE-06](#fe-06) | Validar responsividade e acessibilidade básica | Backlog | Victor e responsável do app (revisor: Luís) | 04/12 |
| [QA-01](#qa-01) | Executar o roteiro de aceite da versão 1 | Backlog | Todos | 05/12 |
| [DOC-01](#doc-01) | Atualizar a documentação final | Backlog | Luís (apoio: todos) | 06/12 |
| [APR-01](#apr-01) | Preparar a apresentação e as respostas técnicas individuais | Backlog | Todos (coordenação: Luís) | 07/12 |
| [BE-03](#be-03) | Implementar o cadastro de médicos | Pronto para iniciar | Yuri | 25/11 |
| [DOC-02](#doc-02) | Migrar a documentação do Drive para o repositório agendamentos-sa-docs | Em andamento | Luís | 16/11 |
| [DB-02](#db-02) | Validar as migrações V1 e V2 no PostgreSQL | Em andamento | Luís (apoio: Yuri ou Pierre) | 20/11 |
| [DB-04](#db-04) | Criar o banco de produção na nuvem | Em andamento | Luís | 19/11 |
| [BE-01](#be-01) | Completar a base do backend e o ambiente local | Em andamento | Yuri e Pierre | 20/11 |
| [BE-02](#be-02) | Implementar autenticação, cadastro e perfil do usuário | Em andamento | Yuri | 22/11 |
| [FE-01W](#fe-01w) | Estruturar a base do painel web administrativo | Em andamento | Victor | 20/11 |
| [FE-02](#fe-02) | Implementar autenticação no painel e no app | Em andamento | Victor (painel) e responsável do app | 25/11 |
| [INT-01](#int-01) | Integrar painel e app com o backend pelo contrato v1 | Em andamento | Victor, Yuri e Pierre (coordenação: Luís) | 04/12 |
| [DEC-02](#dec-02) | Aprovar as decisões técnicas da versão 1 | Em revisão | Todos (Luís registra) | 18/11 |
| [DEC-03](#dec-03) | Definir as regras de cancelamento e reagendamento | Em revisão | Todos (Luís registra) | 18/11 |
| [REQ-01](#req-01) | Confirmar os ajustes do documento de requisitos | Em revisão | Luís | 18/11 |
| [DB-01](#db-01) | Revisar e aprovar o modelo de dados | Em revisão | Luís (revisores: Yuri e Pierre) | 18/11 |
| [DB-03](#db-03) | Carregar dados de demonstração no perfil dev | Em revisão | Luís | 20/11 |
| [API-01](#api-01) | Revisar e congelar o contrato OpenAPI v1 | Em revisão | Luís (revisores: Yuri, Pierre e Victor) | 20/11 |
| [BE-04](#be-04) | Concluir agenda e bloqueios (PR #2) | Em revisão | Pierre | 19/11 |
| [DEC-01](#dec-01) | Definir os clientes: painel web + app React + Capacitor | Concluído | Luís | 15/11 |

## Rastreabilidade: requisito → cartões

| Requisito | Cartões |
|---|---|
| RN-001 | DB-01, BE-02 |
| RN-002 | BE-02, BE-05 |
| RN-003 | REQ-01, BE-03, FE-04 |
| RN-004 | DB-01, DB-02, BE-05, BE-07 |
| RN-005 | DEC-02, BE-04, BE-05 |
| RN-006 | BE-05 |
| RN-007 | DEC-03, BE-05, BE-07 |
| RN-008 | DEC-03, BE-05 |
| RN-009 | BE-02, BE-05, FE-03 |
| RN-010 | DB-01, BE-05 |
| RN-011 | BE-03, BE-07 |
| RN-012 | DEC-03, DB-01, BE-05 |
| RN-013 | DB-01, BE-05 |
| RN-014 | BE-05 |
| RF-001 | BE-02, FE-02 |
| RF-002 | BE-02, FE-02 |
| RF-003 | BE-02, FE-03 |
| RF-004 | REQ-01 |
| RF-005 | BE-02, FE-02 |
| RF-006 | BE-02, FE-02 |
| RF-007 | BE-03, FE-04 |
| RF-008 | BE-02, FE-04 |
| RF-009 | BE-04, FE-04 |
| RF-010 | BE-04, FE-04 |
| RF-011 | BE-04, FE-03 |
| RF-012 | BE-04 |
| RF-013 | BE-05, FE-03 |
| RF-014 | BE-05, FE-03 |
| RF-015 | DEC-03, BE-05, FE-03 |
| RF-016 | DEC-03, BE-05, FE-03 |
| RF-017 | BE-05, FE-04 |
| RF-018 | DEC-03, BE-05, FE-04 |
| RF-019 | BE-05, FE-03 |
| RF-020 | BE-05, FE-03 |
| RF-021 | BE-05, FE-03 |
| RF-022 | BE-05, FE-04 |
| RF-023 | BE-05, FE-04 |
| RF-024 | DEC-02, BE-06, DIST-01 |
| RF-025 | DEC-02, BE-06, DIST-01 |
| RF-026 | DEC-02, BE-06, DIST-01 |
| RF-027 | DEC-02, BE-06, DIST-01 |
| RF-028 | DEC-02, DB-01, BE-06, DIST-01 |
| RNF-001 | REQ-01, DB-04, BE-08, INT-01 |
| RNF-002 | BE-02 |
| RNF-003 | BE-02, FE-02 |
| RNF-004 | BE-02 |
| RNF-005 | BE-04, QA-01 |
| RNF-006 | QA-01 |
| RNF-007 | DEC-01, REQ-01, FE-01M, FE-06 |
| RNF-008 | DEC-01, FE-01W, FE-04, FE-06 |
| RNF-009 | API-01, BE-01, BE-08, FE-01W, INT-01 |
| RNF-010 | API-01, BE-01 |
| RNF-011 | DEC-02, DB-01, DB-02, DB-04, BE-01 |
| RNF-012 | DB-01, DB-02, BE-04, BE-05, BE-07 |
| RNF-013 | DIST-01, FE-01M, FE-05 |
| RNF-014 | DOC-02, BE-01, FE-01W, DOC-01 |
| RNF-015 | DB-01, DB-03, DB-04 |
| RNF-016 | DEC-01, REQ-01, FE-01M |
| RNF-017 | API-01, INT-01 |
| RNF-018 | DB-02, DB-03, BE-02, BE-07, QA-01 |
| RNF-019 | REQ-01, DIST-01 |

## Cartões

### Backlog

<a id="be-05"></a>

#### BE-05 — Implementar agendamentos

**Lista:** Backlog · **Responsável:** Pierre · **Etiquetas:** Backend, Prioridade alta · **Prazo (proposta):** 28/11

**Objetivo.** Paciente agenda, consulta, cancela e reagenda; administrador lista, filtra, cancela e reagenda.

**Contexto.** Rotas planejadas: POST e GET /agendamentos, GET /agendamentos/me, GET /agendamentos/{id}, PATCH .../reagendamento e PATCH .../cancelamento. O banco já recusa sobreposição por médico e por paciente; o serviço traduz isso em 409. As regras de contexto estão na seção “Regras que ficam na aplicação” do MODELO_DADOS.md.

**Escopo.** Inclui: criação com lock no médico; listas do paciente e do administrador com filtros; cancelamento e reagendamento; notificação PENDENTE na mesma transação. Não inclui: pagamento, convênio ou prontuário.

**Requisitos atendidos:** RN-002, RN-004 a RN-010, RN-012 a RN-014, RF-013 a RF-023, RNF-012  
**Dependências:** BE-02, BE-03, BE-04, DEC-03

**Tarefas**

- [ ] Entidade Agendamento e repositório
- [ ] POST /agendamentos: lock no médico, janela ativa, sem bloqueio, início futuro e duração da janela
- [ ] Traduzir exclusion_violation em 409
- [ ] GET /agendamentos/me com filtro de status (próximos e histórico)
- [ ] GET /agendamentos para ADMINISTRADOR com filtros de período, médico, paciente e status
- [ ] GET /agendamentos/{id} só para o dono ou ADMINISTRADOR
- [ ] PATCH cancelamento: status CANCELADA, cancelado_em, cancelado_por_id e motivo conforme DEC-03
- [ ] PATCH reagendamento: novo intervalo validado na mesma transação
- [ ] Gravar a notificação PENDENTE na mesma transação (base do DIST-01)
- [ ] Testes de serviço para cada regra
- [ ] Atualizar x-status no openapi.yaml

**Critérios de aceite**

- [ ] Horário fora da agenda, bloqueado ou passado é recusado
- [ ] Dois pedidos para o mesmo horário: um 201 e um 409
- [ ] Paciente não vê nem altera consulta de outro paciente
- [ ] Consulta cancelada continua no histórico e libera o horário

**Links:** [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md) · [api/openapi.yaml](../api/openapi.yaml)

<a id="be-06"></a>

#### BE-06 — Implementar notificações

**Lista:** Backlog · **Responsável:** Yuri e Pierre · **Etiquetas:** Backend · **Prazo (proposta):** 02/12

**Objetivo.** Paciente recebe e lista confirmações, lembretes, cancelamentos e alterações.

**Contexto.** A tabela notificacao tem tipo (CONFIRMACAO, LEMBRETE, CANCELAMENTO, ALTERACAO), canal (SISTEMA, EMAIL), status e tentativas. Rotas planejadas: GET /notificacoes/me e PATCH /notificacoes/{id}/leitura.

**Escopo.** Inclui: geração das notificações; lembrete agendado; listagem e marcação de lida. Não inclui: push no celular; SMS ou WhatsApp.

**Requisitos atendidos:** RF-024 a RF-028  
**Dependências:** BE-05, DEC-02

**Tarefas**

- [ ] Entidade Notificacao e repositório
- [ ] Gerar CONFIRMACAO, CANCELAMENTO e ALTERACAO a partir do BE-05
- [ ] Tarefa agendada que cria o LEMBRETE 24 horas antes (se aprovado no DEC-02)
- [ ] GET /notificacoes/me paginado com filtro somenteNaoLidas
- [ ] PATCH /notificacoes/{id}/leitura
- [ ] Envio por e-mail só se o DEC-02 aprovar
- [ ] Testes
- [ ] Atualizar x-status no openapi.yaml

**Critérios de aceite**

- [ ] Cada agendamento, cancelamento e reagendamento gera exatamente uma notificação
- [ ] O lembrete não é criado duas vezes para a mesma consulta
- [ ] Paciente só vê as próprias notificações

**Links:** [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md) · [api/openapi.yaml](../api/openapi.yaml)

<a id="dist-01"></a>

#### DIST-01 — Aplicar o conceito distribuído: notificações assíncronas

**Lista:** Backlog · **Responsável:** Backend a definir (Luís documenta) · **Etiquetas:** Backend, Banco de dados, Sistemas distribuídos, Prioridade alta · **Prazo (proposta):** 02/12

**Objetivo.** Aplicar e justificar pelo menos um conceito de sistemas distribuídos, como a SA pede.

**Contexto.** O item 6 da SA pede um conceito distribuído aplicado e justificado. A proposta é a caixa de saída transacional: a operação grava a notificação junto com o agendamento e um processo separado entrega depois. Isso conversa com o conteúdo de Mensageria de Sistemas Distribuídos, e a tabela notificacao já tem status, tentativas e enviada_em.

**Escopo.** Inclui: processo de envio separado; reenvio com contagem de tentativas; duas instâncias sem envio duplicado; justificativa escrita. Não inclui: broker de mensagens obrigatório (opcional, ver tarefas).

**Requisitos atendidos:** RF-024 a RF-028, RNF-013, RNF-019  
**Dependências:** BE-05, BE-06

**Tarefas**

- [ ] Definir o responsável no backend
- [ ] Processo separado (@Scheduled ou consumidor) que lê PENDENTE com FOR UPDATE SKIP LOCKED
- [ ] Marcar ENVIADA com enviada_em, ou FALHA somando tentativas
- [ ] Limite de tentativas e reenvio das que falharam
- [ ] Simular canal fora do ar e mostrar que o agendamento continua confirmado
- [ ] Rodar duas instâncias e mostrar que nenhuma notificação sai duas vezes
- [ ] Avaliar trocar o processo por uma fila (RabbitMQ), se o professor de Distribuídos pedir mensageria explícita — a confirmar
- [ ] Escrever a justificativa em arquitetura/ARQUITETURA.md
- [ ] Preparar a demonstração do conceito para a apresentação

**Critérios de aceite**

- [ ] Agendar, cancelar e reagendar gravam a notificação PENDENTE na mesma transação
- [ ] Falha no envio não desfaz nem atrasa o agendamento
- [ ] Duas instâncias não enviam a mesma notificação
- [ ] Justificativa na documentação e na apresentação

**Links:** [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md) · [arquitetura/ARQUITETURA.md](../arquitetura/ARQUITETURA.md) · [requisitos/REQUISITOS.md](../requisitos/REQUISITOS.md)

<a id="be-07"></a>

#### BE-07 — Testar concorrência e regras críticas

**Lista:** Backlog · **Responsável:** Yuri e Pierre (revisor: Luís) · **Etiquetas:** Backend, Banco de dados, Testes, Prioridade alta · **Prazo (proposta):** 03/12

**Objetivo.** Ter testes automatizados que provem as regras de que a SA mais cobra: autenticação e agendamento.

**Contexto.** O RNF-018 pede testes automatizados nas funcionalidades críticas, e o RNF-012 pede consistência em operações simultâneas. O banco segura a sobreposição; o teste precisa mostrar isso pela API.

**Escopo.** Inclui: testes de integração com PostgreSQL real (Testcontainers ou banco de teste); teste de pedidos simultâneos. Não inclui: teste de carga (QA-01).

**Requisitos atendidos:** RN-004, RN-007, RN-011, RNF-012, RNF-018  
**Dependências:** BE-02, BE-05

**Tarefas**

- [ ] Escolher como subir o PostgreSQL nos testes (Testcontainers ou banco dedicado)
- [ ] Dois pedidos simultâneos para o mesmo médico e horário: um sucesso e um 409
- [ ] Paciente não ocupa duas consultas sobrepostas
- [ ] Cancelamento libera o horário
- [ ] Bloqueio retira o horário da disponibilidade
- [ ] Médico inativo não recebe agendamento
- [ ] Testes de autenticação: 401 sem token e 403 por perfil
- [ ] Rodar todos com ./mvnw test e anexar o resultado

**Critérios de aceite**

- [ ] ./mvnw test passa num clone limpo
- [ ] O teste de concorrência falha se a restrição do banco for removida

**Links:** [banco-de-dados/validacao_restricoes.sql](../banco-de-dados/validacao_restricoes.sql)

<a id="be-08"></a>

#### BE-08 — Publicar o backend com HTTPS

**Lista:** Backlog · **Responsável:** A definir · **Etiquetas:** Backend, Integração · **Prazo (proposta):** 29/11

**Objetivo.** O app no celular e o painel publicado acessam a API pela internet, ligada ao banco de produção.

**Contexto.** O banco de produção fica no Neon (DB-04). Sem o backend publicado, o app só funciona na mesma rede do computador que roda a API. O RNF-001 exige HTTPS no ambiente publicado. Onde publicar ainda não foi decidido.

**Escopo.** Inclui: Dockerfile do backend; variáveis de produção no provedor; HTTPS e CORS. Não inclui: publicação do painel web (pode ir junto, se o grupo quiser).

**Requisitos atendidos:** RNF-001, RNF-009  
**Dependências:** BE-01, DB-04

**Tarefas**

- [ ] Decidir onde publicar — a confirmar (o grupo já usa AWS no FileMind; há opções gratuitas mais simples)
- [ ] Criar o Dockerfile do backend
- [ ] Configurar DB_* e o segredo do JWT no provedor, fora do Git
- [ ] Ativar HTTPS e liberar no CORS o painel e o app
- [ ] Confirmar que o perfil dev não está ativo em produção
- [ ] Registrar a URL publicada em banco-de-dados/AMBIENTES.md

**Critérios de aceite**

- [ ] GET de uma rota pública responde por HTTPS
- [ ] O app instalado no celular faz login pela internet

**Links:** [banco-de-dados/AMBIENTES.md](../banco-de-dados/AMBIENTES.md)

<a id="fe-01m"></a>

#### FE-01M — Criar a base do app React + Capacitor

**Lista:** Backlog · **Responsável:** A definir · **Etiquetas:** Mobile, Frontend, Prioridade alta · **Prazo (proposta):** 22/11

**Objetivo.** Ter o app do paciente gerando APK, com a estrutura de telas e o cliente da API.

**Contexto.** A arquitetura do app (pastas pages, services, contexts, hooks, routes e capacitor.config) está em arquitetura/ARQUITETURA.md, em duas versões: JSX e TSX. Ainda não há repositório nem responsável.

**Escopo.** Inclui: projeto React + Vite + Capacitor com Android; rotas das telas do paciente; cliente HTTP com JWT; tratamento de falha de rede. Não inclui: iOS; publicação na Play Store.

**Requisitos atendidos:** RNF-007, RNF-013, RNF-016  
**Dependências:** DEC-01, API-01

**Tarefas**

- [ ] Definir o responsável
- [ ] Criar o repositório do app — nome a confirmar (ex.: agendamentos-sa-app)
- [ ] Projeto Vite + React + Capacitor com a plataforma Android
- [ ] Gerar e instalar um APK de teste num Android 8.0 ou superior
- [ ] Rotas: login, cadastro, início, médicos, horários, agendar, minhas consultas, histórico e perfil
- [ ] Cliente HTTP central com URL da API configurável e token JWT
- [ ] Aviso de falha de rede com botão de tentar de novo
- [ ] Navegação inferior e layout para celular

**Critérios de aceite**

- [ ] APK instala e abre num Android 8.0+
- [ ] O app chama a API publicada (BE-08) ou a local pela rede

**Links:** [arquitetura/ARQUITETURA.md](../arquitetura/ARQUITETURA.md)

<a id="fe-03"></a>

#### FE-03 — Implementar a área do paciente no app

**Lista:** Backlog · **Responsável:** Responsável do app (a definir) · **Etiquetas:** Mobile, Frontend · **Prazo (proposta):** 02/12

**Objetivo.** Paciente faz pelo celular tudo o que os requisitos pedem: agendar, acompanhar, cancelar e reagendar.

**Contexto.** As telas seguem a arquitetura do app e as rotas do contrato: /medicos, /medicos/{id}/horarios-disponiveis, /agendamentos, /agendamentos/me e /notificacoes/me.

**Escopo.** Inclui: dados pessoais; escolha de médico e horário; consultas futuras e histórico; cancelar e reagendar; notificações. Não inclui: pagamento; teleconsulta.

**Requisitos atendidos:** RN-009, RF-003, RF-011, RF-013 a RF-016, RF-019 a RF-021  
**Dependências:** FE-01M, FE-02, BE-03, BE-05

**Tarefas**

- [ ] Editar dados pessoais (GET e PATCH /usuarios/me)
- [ ] Listar médicos com filtro de especialidade
- [ ] Ver horários disponíveis por data
- [ ] Confirmar agendamento
- [ ] Listar próximas consultas e histórico
- [ ] Cancelar e reagendar
- [ ] Ver notificações e marcar como lidas
- [ ] Em 409, atualizar os horários e avisar que o horário foi ocupado

**Critérios de aceite**

- [ ] Fluxo completo de agendar, cancelar e reagendar no celular
- [ ] Datas e horas exibidas no fuso de São Paulo

**Links:** [api/openapi.yaml](../api/openapi.yaml) · [arquitetura/ARQUITETURA.md](../arquitetura/ARQUITETURA.md)

<a id="fe-04"></a>

#### FE-04 — Implementar a área administrativa no painel web

**Lista:** Backlog · **Responsável:** Victor · **Etiquetas:** Frontend · **Prazo (proposta):** 02/12

**Objetivo.** Administrador gerencia médicos, agendas, bloqueios, pacientes e consultas pelo painel.

**Contexto.** As rotas de agenda e bloqueios já existem no PR #2; médicos e agendamentos estão planejados no contrato.

**Escopo.** Inclui: painel inicial; médicos; agenda semanal; bloqueios; pacientes; agendamentos com filtros. Não inclui: relatórios e gráficos avançados.

**Requisitos atendidos:** RN-003, RF-007 a RF-010, RF-017, RF-018, RF-022, RF-023, RNF-008  
**Dependências:** FE-01W, FE-02, BE-03, BE-04, BE-05

**Tarefas**

- [ ] Painel inicial com as consultas do dia e as próximas
- [ ] Médicos: listar, cadastrar, editar e desativar
- [ ] Agenda semanal por médico (janelas por dia da semana)
- [ ] Bloqueios: cadastrar e desativar
- [ ] Pacientes: listar e ver histórico de consultas
- [ ] Agendamentos: listar com filtros de período, médico e status
- [ ] Cancelar e reagendar como administrador

**Critérios de aceite**

- [ ] Todas as ações do administrador nos requisitos têm tela
- [ ] Tabelas se adaptam ao tablet

**Links:** [api/openapi.yaml](../api/openapi.yaml) · [frontend-agendamento](https://github.com/VictorKLing/frontend-agendamento)

<a id="fe-05"></a>

#### FE-05 — Tratar carregamento, lista vazia e erros no painel e no app

**Lista:** Backlog · **Responsável:** Victor e responsável do app · **Etiquetas:** Frontend, Mobile, Testes · **Prazo (proposta):** 04/12

**Objetivo.** Nenhuma tela fica travada ou em branco quando a API demora, devolve erro ou cai.

**Contexto.** O RNF-013 pede tratamento de falhas de comunicação com o backend. Os erros da API vêm em application/problem+json com a lista erros[campo, mensagem].

**Escopo.** Inclui: carregando; lista vazia; 401, 403, 409 e erros de validação; falha de rede. Não inclui: modo offline completo.

**Requisitos atendidos:** RNF-013  
**Dependências:** FE-02, FE-03, FE-04

**Tarefas**

- [ ] Indicador de carregamento e botões desabilitados durante o envio
- [ ] Mensagem de lista vazia
- [ ] 401 leva ao login
- [ ] 403 informa falta de permissão
- [ ] 409 atualiza a disponibilidade e avisa o conflito
- [ ] Erros de validação aparecem ao lado do campo (erros[campo])
- [ ] Falha de rede permite tentar de novo

**Critérios de aceite**

- [ ] Com o backend desligado, painel e app mostram aviso e não quebram

**Links:** [api/openapi.yaml](../api/openapi.yaml)

<a id="fe-06"></a>

#### FE-06 — Validar responsividade e acessibilidade básica

**Lista:** Backlog · **Responsável:** Victor e responsável do app (revisor: Luís) · **Etiquetas:** Frontend, Mobile, Testes · **Prazo (proposta):** 04/12

**Objetivo.** Painel e app usáveis nos tamanhos de tela previstos e com o básico de acessibilidade.

**Contexto.** RNF-007 (app em diferentes tamanhos de celular) e RNF-008 (painel em computador e tablet).

**Escopo.** Inclui: tamanhos de tela; teclado; rótulos; contraste e foco. Não inclui: auditoria completa de acessibilidade.

**Requisitos atendidos:** RNF-007, RNF-008  
**Dependências:** FE-03, FE-04

**Tarefas**

- [ ] App sem rolagem horizontal em 360 px
- [ ] Painel em 1280 px e em tablet
- [ ] Navegação por teclado nas ações principais do painel
- [ ] Campos com rótulo e mensagem de erro associada
- [ ] Contraste e foco visível conferidos
- [ ] Tabelas do painel viram cartões em tela estreita

**Critérios de aceite**

- [ ] Prints de celular, tablet e computador anexados ao cartão

<a id="qa-01"></a>

#### QA-01 — Executar o roteiro de aceite da versão 1

**Lista:** Backlog · **Responsável:** Todos · **Etiquetas:** Testes · **Prazo (proposta):** 05/12

**Objetivo.** Conferir, com evidência, que cada requisito da versão 1 funciona no ambiente publicado.

**Contexto.** A tabela de rastreabilidade deste backlog liga cada requisito aos cartões. O roteiro roda no ambiente de produção (DB-04 e BE-08), com dados criados pela própria aplicação.

**Escopo.** Inclui: roteiro por requisito; medição de tempo de resposta; evidências. Não inclui: teste de segurança aprofundado.

**Requisitos atendidos:** RNF-005, RNF-006, RNF-018  
**Dependências:** INT-01

**Tarefas**

- [ ] Cadastro e login de paciente
- [ ] Cadastro de médico, agenda e bloqueio pelo administrador
- [ ] Agendamento, cancelamento e reagendamento
- [ ] Histórico e filtros administrativos
- [ ] Notificações, incluindo falha simulada de envio
- [ ] Autorização e isolamento de dados entre pacientes
- [ ] Tempo de horarios-disponiveis abaixo de 3 segundos
- [ ] Teste simples com 50 usuários simultâneos — opcional
- [ ] Salvar as evidências (prints e saídas) no repositório de docs

**Critérios de aceite**

- [ ] Todo requisito da v1 tem resultado registrado: passou, falhou ou fora do escopo
- [ ] Falhas viraram cartão com responsável

**Links:** [organizacao/BACKLOG.md](../organizacao/BACKLOG.md) · [requisitos/REQUISITOS.md](../requisitos/REQUISITOS.md)

<a id="doc-01"></a>

#### DOC-01 — Atualizar a documentação final

**Lista:** Backlog · **Responsável:** Luís (apoio: todos) · **Etiquetas:** Documentação · **Prazo (proposta):** 06/12

**Objetivo.** A documentação entregue descreve o sistema que foi entregue, não o planejado.

**Contexto.** Tudo fica no repositório agendamentos-sa-docs. O contrato marca com x-status o que está implementado; no fim, nada pode ficar como planejado sem estar fora do escopo.

**Escopo.** Inclui: requisitos; arquitetura; banco; contrato; ambientes; READMEs dos repositórios. Não inclui: manual do usuário final.

**Requisitos atendidos:** RNF-014  
**Dependências:** QA-01

**Tarefas**

- [ ] Requisitos finais sem marcas de proposta
- [ ] Diagrama e dicionário conferidos com o banco de produção
- [ ] openapi.yaml: tudo implementado ou explicitamente fora do escopo
- [ ] Arquitetura com as pastas reais do backend, do painel e do app
- [ ] Justificativa do conceito distribuído (DIST-01)
- [ ] AMBIENTES.md com as URLs publicadas e sem segredos
- [ ] READMEs do backend, do painel e do app com instalação e usuários de demonstração
- [ ] README do repositório de docs com o índice final

**Critérios de aceite**

- [ ] Outra pessoa do grupo consegue subir o sistema só lendo os READMEs
- [ ] Nenhum documento cita o Drive como fonte atual

**Links:** [README.md](../README.md)

<a id="apr-01"></a>

#### APR-01 — Preparar a apresentação e as respostas técnicas individuais

**Lista:** Backlog · **Responsável:** Todos (coordenação: Luís) · **Etiquetas:** Apresentação, Documentação, Prioridade alta · **Prazo (proposta):** 07/12

**Objetivo.** Entregar a SA no AVA no prazo e apresentar com cada integrante respondendo pela própria parte.

**Contexto.** A tarefa “Desenvolvimento SA agenda de consulta” (Web) vence em 08/12/2026 às 00:00, então o envio precisa sair até 07/12 às 23:59, e só existe 1 tentativa. Em Distribuídos, a apresentação de 03/11 teve perguntas técnicas individuais; o mesmo deve acontecer na final.

**Escopo.** Inclui: roteiro da demonstração; slides; preparação individual; plano B; envio no AVA. Não inclui: novas funcionalidades depois de 05/12.

**Requisitos atendidos:** —  
**Dependências:** QA-01, DOC-01

**Tarefas**

- [ ] Roteiro da demonstração: cadastro → agenda → agendar → cancelar → notificação
- [ ] Dados da apresentação criados pela própria aplicação em produção (não usar o perfil dev)
- [ ] Slides: problema, requisitos, arquitetura, banco, contrato e conceito distribuído
- [ ] Luís prepara: modelo de dados, restrições, concorrência, Flyway, banco na nuvem e notificações assíncronas
- [ ] Yuri prepara: autenticação, JWT, usuários e médicos
- [ ] Pierre prepara: agenda, horários disponíveis, agendamentos e lock
- [ ] Victor prepara: painel, integração e tratamento de erros
- [ ] Responsável do app prepara: Capacitor, APK e consumo da API
- [ ] Ensaio com cronômetro
- [ ] Plano B: vídeo da demonstração e backend local com dados de demonstração
- [ ] Conferir o que o envio no AVA pede e enviar uma única vez até 07/12 às 23:59

**Critérios de aceite**

- [ ] Envio feito no AVA antes do prazo
- [ ] Cada integrante explica a própria parte e o fluxo completo sem ler

**Links:** [README.md](../README.md)

### Pronto para iniciar

<a id="be-03"></a>

#### BE-03 — Implementar o cadastro de médicos

**Lista:** Pronto para iniciar · **Responsável:** Yuri · **Etiquetas:** Backend · **Prazo (proposta):** 25/11

**Objetivo.** Administrador cadastra, edita, lista e desativa médicos; paciente lista para escolher.

**Contexto.** A entidade Medico e o MedicoRepository (com lock pessimista) chegaram no PR #2; o CRUD ainda não existe. Rotas planejadas: GET e POST /medicos, GET e PATCH /medicos/{id}.

**Escopo.** Inclui: listagem paginada com os filtros do contrato; cadastro; edição; desativação lógica. Não inclui: login de médico (perfil MEDICO reservado).

**Requisitos atendidos:** RN-003, RN-011, RF-007  
**Dependências:** BE-04 (merge do PR #2), BE-02

**Tarefas**

- [ ] Reaproveitar Medico e MedicoRepository do PR #2
- [ ] DTOs e validações: CRM, UF com duas letras maiúsculas, especialidade
- [ ] GET /medicos paginado com filtros
- [ ] POST /medicos e GET /medicos/{id}
- [ ] PATCH /medicos/{id}, incluindo ativar e desativar
- [ ] Traduzir CRM/UF repetido (uk_medico_crm_uf) em 409
- [ ] Restringir escrita a ADMINISTRADOR
- [ ] Testes de duplicidade, validação e permissão
- [ ] Atualizar x-status no openapi.yaml

**Critérios de aceite**

- [ ] Mesmo CRM em outra UF é aceito; mesmo CRM e UF devolve 409
- [ ] Médico desativado continua no histórico e some da escolha do paciente
- [ ] Paciente lista, mas não altera

**Links:** [api/openapi.yaml](../api/openapi.yaml) · [PR #2](https://github.com/yuriOdsz/agendamentos-sa/pull/2)

### Em andamento

<a id="doc-02"></a>

#### DOC-02 — Migrar a documentação do Drive para o repositório agendamentos-sa-docs

**Lista:** Em andamento · **Responsável:** Luís · **Etiquetas:** Documentação · **Prazo (proposta):** 16/11

**Objetivo.** Ter um lugar só, versionado, para requisitos, arquitetura, banco, contrato e backlog.

**Contexto.** No Drive havia o documento de requisitos (Word) e quatro arquivos de arquitetura em texto; modelagem e contrato estavam em arquivos soltos. Como no FileMind (backend, frontend e documentação), o projeto passa a ter backend, frontend e agendamentos-sa-docs.

**Escopo.** Inclui: requisitos; arquitetura (backend v1 e v2, painel, app); modelagem e validação do banco; ambientes (local e produção); contrato OpenAPI; backlog. Não inclui: código, que fica nos repositórios de implementação; conversas do grupo.

**Requisitos atendidos:** RNF-014  
**Dependências:** —

**Tarefas**

- [ ] Criar o repositório luisctorrens/agendamentos-sa-docs
- [ ] Converter “Trabalho SA - Desenvolvimento WEB” para requisitos/REQUISITOS.md
- [ ] Juntar os quatro arquivos de arquitetura em arquitetura/ARQUITETURA.md
- [ ] Copiar modelagem, script de validação, contrato e backlog
- [ ] Escrever o README com índice e links dos repositórios
- [ ] Dar acesso de escrita a Yuri, Pierre e Victor
- [ ] Avisar no grupo que o Drive deixa de ser atualizado e deixar lá o link do repositório
- [ ] Renomear o quadro do Trello para “Agenda SA” (era “Agenda SA — Web Responsivo”)

**Critérios de aceite**

- [ ] Tudo o que estava no Drive tem equivalente no repositório
- [ ] Os quatro integrantes abrem e editam o repositório
- [ ] Cartões do Trello apontam para o repositório, não para o Drive

**Links:** [README.md](../README.md) · [frontend-agendamento](https://github.com/VictorKLing/frontend-agendamento) · [agendamentos-sa (backend)](https://github.com/yuriOdsz/agendamentos-sa)

<a id="db-02"></a>

#### DB-02 — Validar as migrações V1 e V2 no PostgreSQL

**Lista:** Em andamento · **Responsável:** Luís (apoio: Yuri ou Pierre) · **Etiquetas:** Banco de dados, Backend, Testes, Prioridade alta · **Prazo (proposta):** 20/11

**Objetivo.** Provar no banco real que as restrições seguram as regras críticas.

**Contexto.** Segundo o Luís, a V1 rodou no PostgreSQL do Yuri. O script validacao_restricoes.sql testa as restrições numa transação e desfaz tudo no fim; ainda não foi executado. Concorrência real precisa de duas conexões, com roteiro manual no fim do script.

**Escopo.** Inclui: banco vazio local; banco de produção depois do DB-04; roteiro manual de concorrência. Não inclui: teste de carga (QA-01).

**Requisitos atendidos:** RN-004, RNF-011, RNF-012, RNF-018  
**Dependências:** —

**Tarefas**

- [x] V1 aplicada no PostgreSQL do Yuri (relatado pelo Luís)
- [ ] Confirmar se a V2 também foi aplicada (tabela flyway_schema_history) — a confirmar
- [ ] Aplicar V1 + V2 num banco vazio e subir o backend com ddl-auto=validate
- [ ] Rodar validacao_restricoes.sql e guardar a saída
- [ ] Rodar o roteiro de concorrência: duas conexões, mesmo médico e horário
- [ ] Reiniciar o backend e confirmar que o Flyway não reaplica nada
- [ ] Repetir o script no banco de produção depois do DB-04
- [ ] Anexar as evidências no cartão

**Critérios de aceite**

- [ ] Script termina sem nenhuma linha FALHOU
- [ ] E-mail repetido (com maiúsculas diferentes), CRM/UF repetido e consultas sobrepostas são rejeitados pelo banco
- [ ] Na concorrência, uma conexão grava e a outra recebe exclusion_violation

**Links:** [banco-de-dados/validacao_restricoes.sql](../banco-de-dados/validacao_restricoes.sql) · [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md)

<a id="db-04"></a>

#### DB-04 — Criar o banco de produção na nuvem

**Lista:** Em andamento · **Responsável:** Luís · **Etiquetas:** Banco de dados, Prioridade alta · **Prazo (proposta):** 19/11

**Objetivo.** Ter um PostgreSQL gerenciado que será o banco oficial do sistema publicado e da apresentação.

**Contexto.** Cada integrante testa no PostgreSQL local dele; produção é uma só, criada pelo Luís no Neon (PostgreSQL gerenciado, plano gratuito). As tabelas são criadas pelo Flyway do backend no primeiro start, nunca à mão. O application.yaml lê DB_HOST, DB_PORT, DB_NAME, DB_USERNAME e DB_PASSWORD.

**Escopo.** Inclui: projeto no Neon; banco agenda_sa com a extensão btree_gist (criada pela V1); conexão com SSL; guia em banco-de-dados/AMBIENTES.md. Não inclui: dados de demonstração (o perfil dev nunca roda em produção); plano pago, réplica ou backup extra.

**Requisitos atendidos:** RNF-001, RNF-011, RNF-015  
**Dependências:** DB-02

**Tarefas**

- [ ] Criar o projeto no Neon, na região mais próxima de onde o backend for publicado (São Paulo, se houver — a confirmar)
- [ ] Criar o banco agenda_sa e guardar host, usuário e senha fora do repositório
- [x] Definir a conexão com SSL: spring.datasource.url com sslmode=require no .env de produção (AMBIENTES.md)
- [ ] Subir o backend uma vez apontando para a nuvem, sem o perfil dev, para o Flyway aplicar V1 e V2
- [ ] Conferir flyway_schema_history (duas versões com sucesso) e a extensão btree_gist
- [ ] Rodar validacao_restricoes.sql na nuvem (ele desfaz tudo no fim)
- [ ] Criar o administrador inicial pela API (POST /api/v1/usuarios) enquanto a rota estiver aberta
- [ ] Combinar quem recebe as credenciais e por qual canal (nunca no Git nem no Trello)
- [x] Escrever banco-de-dados/AMBIENTES.md: local x produção, variáveis e cuidados

**Critérios de aceite**

- [ ] O backend sobe contra a nuvem com ddl-auto=validate sem erro
- [ ] Nenhuma senha ou string de conexão no Git, no Trello ou na documentação
- [ ] Produção sem dados de demonstração
- [ ] A conexão usa SSL

**Links:** [banco-de-dados/AMBIENTES.md](../banco-de-dados/AMBIENTES.md) · [banco-de-dados/validacao_restricoes.sql](../banco-de-dados/validacao_restricoes.sql)

<a id="be-01"></a>

#### BE-01 — Completar a base do backend e o ambiente local

**Lista:** Em andamento · **Responsável:** Yuri e Pierre · **Etiquetas:** Backend, Banco de dados · **Prazo (proposta):** 20/11

**Objetivo.** Qualquer integrante clona, preenche o .env e sobe o backend em poucos minutos.

**Contexto.** Na master já existem Spring Boot 4.1.2 (Java 21), Flyway com V1 e V2, ddl-auto=validate, leitura do .env e .env no .gitignore. Faltam PostgreSQL em container, .env.example, README de execução e CORS.

**Escopo.** Inclui: docker-compose com PostgreSQL 16 ou superior; .env.example; README de execução; CORS para painel e app; perfis dev e padrão. Não inclui: publicação do backend (BE-08).

**Requisitos atendidos:** RNF-009 a RNF-011, RNF-014  
**Dependências:** —

**Tarefas**

- [x] Projeto Spring Boot com JPA, Flyway, Validation e Security
- [x] V1 e V2 em db/migration e ddl-auto=validate
- [x] Variáveis lidas do .env, que está no .gitignore
- [ ] Criar docker-compose.yml com PostgreSQL 16+ e volume
- [ ] Criar .env.example com DB_HOST, DB_PORT, DB_NAME, DB_USERNAME, DB_PASSWORD e SERVER_PORT
- [ ] Configurar CORS para o painel (Vite) e para o app Capacitor (conferir a origem usada no Android)
- [ ] Escrever o README: requisitos, .env, docker compose up, ./mvnw spring-boot:run, perfil dev
- [ ] Incluir Swagger UI (springdoc) para testar as rotas — opcional

**Critérios de aceite**

- [ ] Clone limpo + .env + docker compose up + ./mvnw spring-boot:run sobe sem erro
- [ ] Flyway aplica V1 e V2 num banco vazio
- [ ] O painel rodando local não é barrado por CORS

**Links:** [backend](https://github.com/yuriOdsz/agendamentos-sa) · [banco-de-dados/AMBIENTES.md](../banco-de-dados/AMBIENTES.md) · [arquitetura/ARQUITETURA.md](../arquitetura/ARQUITETURA.md)

<a id="be-02"></a>

#### BE-02 — Implementar autenticação, cadastro e perfil do usuário

**Lista:** Em andamento · **Responsável:** Yuri · **Etiquetas:** Backend, Prioridade alta · **Prazo (proposta):** 22/11

**Objetivo.** Login com token e autorização por perfil, para os clientes deixarem de usar o login padrão do Spring Security.

**Contexto.** Na master já existem o CRUD /api/v1/usuarios (criar, listar paginado, buscar, atualizar e desativar), senha com BCrypt e validação de senha. O painel hoje autentica pelo formulário padrão /login do Spring Security, com CSRF.

**Escopo.** Inclui: POST /auth/cadastro (sempre PACIENTE); POST /auth/login com JWT; GET e PATCH /usuarios/me; autorização por perfil; logout no cliente. Não inclui: recuperação de senha (RF-004, depende do REQ-01).

**Requisitos atendidos:** RN-001, RN-002, RN-009, RF-001 a RF-003, RF-005, RF-006, RF-008, RNF-002 a RNF-004, RNF-018  
**Dependências:** BE-01, API-01

**Tarefas**

- [x] CRUD de usuários em /api/v1/usuarios
- [x] Hash BCrypt e validação de senha
- [ ] POST /auth/cadastro criando sempre PACIENTE
- [ ] POST /auth/login devolvendo JWT com id e perfil e expiração definida
- [ ] Filtro JWT e SecurityConfig sem estado (sem formulário e sem CSRF na API)
- [ ] Restringir listar, buscar e desativar usuários a ADMINISTRADOR
- [ ] GET e PATCH /usuarios/me para o próprio usuário
- [ ] Usar só ADMINISTRADOR nas checagens (a V2 converteu ADMIN; o PR #2 ainda aceita ADMIN)
- [ ] Testes: login certo, senha errada, sem token, perfil sem permissão
- [ ] Atualizar x-status no openapi.yaml

**Critérios de aceite**

- [ ] Sem token: 401; token de paciente em rota de administrador: 403
- [ ] Senha nunca aparece em resposta nem em log
- [ ] Usuário desativado não consegue logar
- [ ] Paciente só lê e altera os próprios dados

**Links:** [api/openapi.yaml](../api/openapi.yaml) · [API-USUARIOS.md](https://github.com/yuriOdsz/agendamentos-sa/blob/master/API-USUARIOS.md)

<a id="fe-01w"></a>

#### FE-01W — Estruturar a base do painel web administrativo

**Lista:** Em andamento · **Responsável:** Victor · **Etiquetas:** Frontend, Prioridade alta · **Prazo (proposta):** 20/11

**Objetivo.** Ter a estrutura do painel pronta para receber as telas do administrador.

**Contexto.** Repositório VictorKLing/frontend-agendamento: Vite 7, React 19 e Tailwind 4 em JavaScript, com uma tela de login e criação de conta (main.jsx) e um cliente (api.jsx) que cria conta em POST /api/v1/usuarios e autentica pelo /login do Spring Security.

**Escopo.** Inclui: rotas; layout do painel; cliente HTTP central; componentes reaproveitáveis. Não inclui: telas do paciente (vão para o app).

**Requisitos atendidos:** RNF-008, RNF-009, RNF-014  
**Dependências:** API-01

**Tarefas**

- [x] Projeto Vite + React + Tailwind
- [x] Tela de login e criação de conta integrada ao backend
- [ ] Decidir JavaScript ou TypeScript (a arquitetura do Drive tem as duas versões) — a confirmar
- [ ] React Router com rotas públicas e de administrador
- [ ] Layout do painel: menu lateral, cabeçalho e área de conteúdo
- [ ] Cliente HTTP central com a URL da API em VITE_API_URL e o token JWT
- [ ] Guardar a sessão e voltar ao login em 401
- [ ] Componentes de UI: botão, campo, tabela, modal, carregando, lista vazia

**Critérios de aceite**

- [ ] Painel usável em computador e tablet
- [ ] Trocar a URL da API não exige mudar código

**Links:** [frontend-agendamento](https://github.com/VictorKLing/frontend-agendamento) · [arquitetura/ARQUITETURA.md](../arquitetura/ARQUITETURA.md)

<a id="fe-02"></a>

#### FE-02 — Implementar autenticação no painel e no app

**Lista:** Em andamento · **Responsável:** Victor (painel) e responsável do app · **Etiquetas:** Frontend, Mobile · **Prazo (proposta):** 25/11

**Objetivo.** Login, cadastro e logout funcionando com JWT nos dois clientes, cada um só para o seu perfil.

**Contexto.** O painel já tem tela de login e criação de conta usando o login padrão do Spring Security. Quando o BE-02 entregar o JWT, os dois clientes passam a usar POST /auth/login.

**Escopo.** Inclui: login e logout; cadastro de paciente no app; proteção de rotas por perfil; mensagens de erro. Não inclui: recuperação de senha, salvo se RF-004 continuar na v1.

**Requisitos atendidos:** RF-001, RF-002, RF-005, RF-006, RNF-003  
**Dependências:** BE-02, FE-01W, FE-01M

**Tarefas**

- [x] Tela de login e criação de conta no painel (login padrão do Spring)
- [ ] Trocar o painel para POST /auth/login com JWT
- [ ] Login no app com JWT
- [ ] Cadastro de paciente no app via POST /auth/cadastro
- [ ] Logout limpando o token nos dois clientes
- [ ] Painel aceita só ADMINISTRADOR; app aceita só PACIENTE
- [ ] Mensagens de erro sem detalhes internos
- [ ] Recuperação de senha só se RF-004 ficar na v1

**Critérios de aceite**

- [ ] Paciente não entra no painel; administrador não entra no app
- [ ] Depois do logout, voltar no navegador não mostra dados

**Links:** [frontend-agendamento](https://github.com/VictorKLing/frontend-agendamento) · [api/openapi.yaml](../api/openapi.yaml)

<a id="int-01"></a>

#### INT-01 — Integrar painel e app com o backend pelo contrato v1

**Lista:** Em andamento · **Responsável:** Victor, Yuri e Pierre (coordenação: Luís) · **Etiquetas:** Integração, Prioridade alta · **Prazo (proposta):** 04/12

**Objetivo.** Os dois clientes funcionam de ponta a ponta com o backend, sem divergência do contrato.

**Contexto.** A primeira integração (criar conta e login no painel) já foi feita pelo Victor. Uma coleção do Postman ou Insomnia serve para testar e para a apresentação, que em Distribuídos foi feita assim em 03/11.

**Escopo.** Inclui: coleção de requisições; conferência tela x contrato; fuso horário; CORS e autenticação local e publicada. Não inclui: novas funcionalidades.

**Requisitos atendidos:** RNF-001, RNF-009, RNF-017  
**Dependências:** BE-02 a BE-06, FE-02 a FE-05

**Tarefas**

- [x] Primeira integração: criar conta e login no painel
- [ ] Coleção do Postman ou Insomnia com todas as rotas e exemplos
- [ ] Conferir cada tela contra o openapi.yaml
- [ ] Datas enviadas com fuso e exibidas em America/Sao_Paulo
- [ ] CORS e JWT funcionando local e publicado
- [ ] Fluxo ponta a ponta do paciente no app
- [ ] Fluxo ponta a ponta do administrador no painel
- [ ] Registrar cada divergência como cartão ou issue

**Critérios de aceite**

- [ ] Nenhum endpoint depende de interpretação diferente do contrato
- [ ] Fluxos de paciente e administrador funcionam com o backend publicado

**Links:** [api/openapi.yaml](../api/openapi.yaml)

### Em revisão

<a id="dec-02"></a>

#### DEC-02 — Aprovar as decisões técnicas da versão 1

**Lista:** Em revisão · **Responsável:** Todos (Luís registra) · **Etiquetas:** Decisão da equipe, Prioridade alta · **Prazo (proposta):** 18/11

**Objetivo.** Fechar as decisões técnicas que ainda são proposta, para backend e clientes pararem de depender delas.

**Contexto.** Quatro itens já estão decididos (PostgreSQL, clínica única, médico sem login, especialidade como atributo). Duração da consulta, canal de notificação e lembrete têm proposta na modelagem. Sem eles, BE-04, BE-05 e BE-06 não fecham regra.

**Escopo.** Inclui: duração da consulta; canal e momento das notificações; perfis MEDICO e RECEPCIONISTA (criados pela V2) como reservados. Não inclui: regras de cancelamento e reagendamento (DEC-03).

**Requisitos atendidos:** RN-005, RF-024 a RF-028, RNF-011  
**Dependências:** —

**Tarefas**

- [x] Confirmar PostgreSQL como banco
- [x] Confirmar clínica única, sem tabela de unidade
- [x] Confirmar médico sem login na v1
- [x] Confirmar especialidade como atributo do médico
- [ ] Aprovar duração de 30 minutos, configurável por janela (proposta)
- [ ] Aprovar canal SISTEMA na v1; EMAIL só se sobrar tempo (proposta)
- [ ] Aprovar lembrete 24 horas antes da consulta (proposta)
- [ ] Aprovar MEDICO e RECEPCIONISTA como perfis reservados, sem funcionalidade na v1 (proposta)
- [ ] Registrar o resultado na seção “Decisões da versão 1” do MODELO_DADOS.md

**Critérios de aceite**

- [ ] Nenhum item da tabela “Decisões da versão 1” continua como proposta
- [ ] Backend (Yuri e Pierre) e clientes (Victor e responsável do app) deram OK no grupo
- [ ] BE-04, BE-05 e BE-06 citam a duração e o canal decididos

**Links:** [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md)

<a id="dec-03"></a>

#### DEC-03 — Definir as regras de cancelamento e reagendamento

**Lista:** Em revisão · **Responsável:** Todos (Luís registra) · **Etiquetas:** Decisão da equipe, Contrato API · **Prazo (proposta):** 18/11

**Objetivo.** Definir quem pode cancelar ou reagendar, até quando e com quais dados.

**Contexto.** As rotas PATCH /agendamentos/{id}/cancelamento e /reagendamento estão planejadas no contrato e dependem dessas regras. O modelo já define que o reagendamento altera o intervalo da mesma consulta e que o cancelamento guarda quando e quem cancelou. As demais regras estão como proposta no MODELO_DADOS.md.

**Escopo.** Inclui: antecedência mínima; motivo do cancelamento; permissões do administrador e do paciente; liberação do horário. Não inclui: multa por falta; lista de espera; remarcação automática.

**Requisitos atendidos:** RN-007, RN-008, RN-012, RF-015, RF-016, RF-018  
**Dependências:** —

**Tarefas**

- [x] Reagendar altera o intervalo da mesma consulta (modelo 1.1)
- [x] Cancelar grava cancelado_em e cancelado_por_id e mantém a consulta no histórico (modelo 1.1)
- [ ] Aprovar: sem antecedência mínima; só consultas futuras com status AGENDADA (proposta)
- [ ] Aprovar: motivo do cancelamento opcional (proposta)
- [ ] Aprovar: ADMINISTRADOR cancela ou reagenda qualquer consulta (proposta)
- [ ] Aprovar: paciente altera só as próprias consultas futuras (proposta)
- [ ] Escrever as regras na descrição das duas rotas no openapi.yaml

**Critérios de aceite**

- [ ] Regras registradas no MODELO_DADOS.md e no openapi.yaml
- [ ] Códigos de erro definidos: 404 para consulta de outro paciente, 409 para horário ocupado, 422 para consulta passada ou já cancelada

**Links:** [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md) · [api/openapi.yaml](../api/openapi.yaml)

<a id="req-01"></a>

#### REQ-01 — Confirmar os ajustes do documento de requisitos

**Lista:** Em revisão · **Responsável:** Luís · **Etiquetas:** Documentação, Prioridade alta · **Prazo (proposta):** 18/11

**Objetivo.** Deixar os requisitos coerentes com a decisão web + app e com o banco entregue.

**Contexto.** O documento saiu do Google Drive e agora fica em requisitos/REQUISITOS.md. Os ajustes já estão aplicados lá; os itens marcados como proposta precisam do OK do grupo.

**Escopo.** Inclui: RN-003 sem “unidades de saúde”; RNF-007 citando React + Capacitor; RNF-016 com Android 8.0 ou superior (proposta); RF-004 fora da v1 (proposta); RNF-019 novo, notificações assíncronas (proposta); notas: perfis reservados, canal SISTEMA, HTTPS só no ambiente publicado. Não inclui: novos requisitos funcionais.

**Requisitos atendidos:** RN-003, RF-004, RNF-001, RNF-007, RNF-016, RNF-019  
**Dependências:** DEC-01, DEC-02

**Tarefas**

- [x] Migrar o documento do Drive para requisitos/REQUISITOS.md
- [x] Aplicar RN-003, RNF-007, RNF-016, RF-004 e RNF-019, marcando o que é proposta
- [ ] Confirmar RNF-016 (Android 8.0+) e conferir o mínimo aceito pela versão do Capacitor usada no app
- [ ] Confirmar RF-004 fora da v1, ou abrir cartão para a migração de tokens de recuperação
- [ ] Confirmar RNF-019 junto com DIST-01
- [ ] Tirar a marca de proposta do que for aprovado

**Critérios de aceite**

- [ ] Nenhum requisito cita unidades de saúde
- [ ] Todo requisito tem pelo menos um cartão (tabela de rastreabilidade do BACKLOG.md)
- [ ] Itens aprovados sem marca de proposta

**Links:** [requisitos/REQUISITOS.md](../requisitos/REQUISITOS.md) · [organizacao/BACKLOG.md](../organizacao/BACKLOG.md)

<a id="db-01"></a>

#### DB-01 — Revisar e aprovar o modelo de dados

**Lista:** Em revisão · **Responsável:** Luís (revisores: Yuri e Pierre) · **Etiquetas:** Banco de dados, Prioridade alta · **Prazo (proposta):** 18/11

**Objetivo.** Congelar tabelas, colunas, perfis e status da versão 1.

**Contexto.** A V1 (estrutura) e a V2 (perfis) estão na master do backend. A modelagem 1.1 documenta as duas: diagrama, dicionário, restrições, gatilhos e o conceito distribuído.

**Escopo.** Inclui: usuario, medico, agenda_medico, bloqueio_agenda, agendamento e notificacao; perfis e status; restrições de exclusão e gatilhos de atualizado_em. Não inclui: prontuário e dados clínicos; unidades de saúde.

**Requisitos atendidos:** RN-001, RN-004, RN-010, RN-012, RN-013, RF-028, RNF-011, RNF-012, RNF-015  
**Dependências:** DEC-02

**Tarefas**

- [x] Atualizar MODELO_DADOS.md para a versão 1.1 (V2, perfis, decisões, notificações assíncronas)
- [ ] Yuri confere usuario e perfis contra as classes Usuario e Perfil
- [ ] Pierre confere medico, agenda_medico e bloqueio_agenda contra o PR #2
- [ ] Conferir agendamento e notificacao contra as rotas planejadas do contrato
- [ ] Decidir se entra a V3 opcional (índice único parcial em agenda_medico)
- [ ] Registrar no documento a data de congelamento

**Critérios de aceite**

- [ ] Diagrama e dicionário batem com V1 + V2
- [ ] O backend sobe com ddl-auto=validate sem divergência de colunas
- [ ] Depois do congelamento, mudança só por nova migração (V3, V4...) revisada

**Links:** [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md) · [migrações no backend](https://github.com/yuriOdsz/agendamentos-sa/tree/master/src/main/resources/db/migration)

<a id="db-03"></a>

#### DB-03 — Carregar dados de demonstração no perfil dev

**Lista:** Em revisão · **Responsável:** Luís · **Etiquetas:** Banco de dados · **Prazo (proposta):** 20/11

**Objetivo.** Qualquer integrante sobe o backend local já com usuários, médicos, agendas e consultas para testar.

**Contexto.** O script repetível R__dados_demonstracao.sql só roda com SPRING_PROFILES_ACTIVE=dev (application-dev.yaml inclui classpath:db/dev). Está na branch local feature/banco-dados-demonstracao, ainda não publicada.

**Escopo.** Inclui: 1 administrador e 2 pacientes (senha Demo@1234); 3 médicos fictícios (CRM DEMO-1001 a 1003/SC); 11 janelas de agenda e 1 bloqueio; 4 consultas: 2 futuras, 1 concluída, 1 cancelada; notificações de confirmação, lembrete e cancelamento. Não inclui: dados reais; banco de produção.

**Requisitos atendidos:** RNF-015, RNF-018  
**Dependências:** DB-02

**Tarefas**

- [x] Escrever R__dados_demonstracao.sql com ON CONFLICT e NOT EXISTS (repetível)
- [x] Criar application-dev.yaml com a pasta db/dev no Flyway
- [ ] Rodar com o perfil dev num banco vazio
- [ ] Rodar de novo e confirmar que nada duplica
- [ ] Subir sem o perfil dev e confirmar que nada é inserido
- [ ] Publicar a branch e abrir PR no backend
- [ ] Listar os usuários de demonstração no README do backend

**Critérios de aceite**

- [ ] Com o perfil dev, os dados aparecem nas rotas de usuários e agenda
- [ ] Rodar duas vezes não duplica nada
- [ ] Sem o perfil dev, nenhum dado de demonstração é criado

**Links:** [banco-de-dados/AMBIENTES.md](../banco-de-dados/AMBIENTES.md)

<a id="api-01"></a>

#### API-01 — Revisar e congelar o contrato OpenAPI v1

**Lista:** Em revisão · **Responsável:** Luís (revisores: Yuri, Pierre e Victor) · **Etiquetas:** Contrato API, Prioridade alta · **Prazo (proposta):** 20/11

**Objetivo.** Backend, painel e app trabalham pelo mesmo contrato.

**Contexto.** openapi.yaml 1.1.0: 11 operações marcadas como implementadas (usuários e agenda) e 17 planejadas. Paginação e erros seguem o que o código devolve hoje (ProblemDetail com a lista erros[campo, mensagem]). Validado com Redocly sem erros.

**Escopo.** Inclui: todas as rotas /api/v1; schemas e exemplos; códigos de erro; marcação x-status. Não inclui: o processo interno de envio de notificações (DIST-01).

**Requisitos atendidos:** RNF-009, RNF-010, RNF-017  
**Dependências:** DEC-02, DEC-03

**Tarefas**

- [x] Alinhar /usuarios e a agenda ao código (master e PR #2)
- [x] Validar o arquivo com Redocly
- [ ] Yuri confere autenticação, usuários e médicos
- [ ] Pierre confere agenda, agendamentos e notificações
- [ ] Victor confere se as telas têm todos os campos de que precisam
- [ ] Decidir se POST /usuarios continua aberto ou passa a exigir ADMINISTRADOR quando /auth/cadastro existir
- [ ] Decidir se GET /usuarios ganha filtro por perfil (RF-008 lista pacientes)
- [ ] Decidir o formato de hora: HH:mm ou HH:mm:ss
- [ ] Congelar a versão e registrar a data no arquivo

**Critérios de aceite**

- [ ] Cada rota planejada tem um cartão de backend que a implementa
- [ ] Depois de congelado, mudança só por PR no repositório de docs, com aviso no grupo
- [ ] Erros em application/problem+json

**Links:** [api/openapi.yaml](../api/openapi.yaml)

<a id="be-04"></a>

#### BE-04 — Concluir agenda e bloqueios (PR #2)

**Lista:** Em revisão · **Responsável:** Pierre · **Etiquetas:** Backend · **Prazo (proposta):** 19/11

**Objetivo.** Administrador define a agenda semanal e os bloqueios; qualquer usuário consulta os horários livres.

**Contexto.** PR #2 aberto desde 02/11 com GET e PUT /medicos/{id}/agenda, GET, POST e DELETE de bloqueios e GET horarios-disponiveis, usando lock no médico. A revisão de banco não achou problema de mapeamento; há três ajustes pequenos antes do merge.

**Escopo.** Inclui: rotas de agenda, bloqueios e horários disponíveis; geração de horários pela duração da janela; exclusão de horários ocupados e bloqueados. Não inclui: criação de agendamentos (BE-05).

**Requisitos atendidos:** RN-005, RF-009 a RF-012, RNF-005, RNF-012  
**Dependências:** API-01

**Tarefas**

- [x] Entidades AgendaMedico e BloqueioAgenda e consulta de ocupação
- [x] Rotas de agenda, bloqueios e horários disponíveis
- [ ] Postar no PR o comentário da revisão de banco
- [ ] Tirar o comentário //sale do Application.java
- [ ] Padronizar o pacote das entidades (usuarios usa model; agendas e medicos usam entity)
- [ ] Testar as rotas no Postman ou Insomnia com os dados de demonstração (DB-03)
- [ ] Fechar o PR #1 (teste), que só altera uma linha
- [ ] Fazer o merge na master

**Critérios de aceite**

- [ ] Janela inválida ou sobreposta é recusada com o código do contrato
- [ ] Horário bloqueado ou ocupado não aparece em horarios-disponiveis
- [ ] horarios-disponiveis responde em até 3 segundos com os dados de demonstração

**Links:** [PR #2](https://github.com/yuriOdsz/agendamentos-sa/pull/2) · [PR #1](https://github.com/yuriOdsz/agendamentos-sa/pull/1) · [api/openapi.yaml](../api/openapi.yaml)

### Concluído

<a id="dec-01"></a>

#### DEC-01 — Definir os clientes: painel web + app React + Capacitor

**Lista:** Concluído · **Responsável:** Luís · **Etiquetas:** Decisão da equipe, Documentação · **Prazo (proposta):** 15/11

**Objetivo.** Registrar quais aplicações o grupo entrega na SA.

**Contexto.** Em 27/10 o escopo era só web responsivo. Em 15/11 o grupo decidiu: painel web para o administrador e app React + Capacitor (Android) para o paciente, com o mesmo backend e o mesmo contrato. A SA é compartilhada entre Web, Mobile e Distribuídos, e o app cobre a parte de Mobile.

**Escopo.** Inclui: painel web administrativo (React + Vite); app do paciente (React + Capacitor, Android); um backend e um contrato para os dois. Não inclui: app iOS; app nativo em Kotlin, Flutter ou React Native.

**Requisitos atendidos:** RNF-007, RNF-008, RNF-016  
**Dependências:** —

**Tarefas**

- [x] Decidir entre só web responsivo e web + app
- [x] Registrar a decisão com data no backlog e na modelagem
- [x] Dividir o antigo FE-01 em FE-01W (painel) e FE-01M (app)
- [x] Passar a área do paciente (FE-03) para o app

**Critérios de aceite**

- [x] Decisão registrada com data (15/11/2026)
- [x] Cartões de frontend refletem os dois clientes

**Links:** [requisitos/REQUISITOS.md](../requisitos/REQUISITOS.md) · [arquitetura/ARQUITETURA.md](../arquitetura/ARQUITETURA.md)
