# Backlog — Agendamentos SA

Fonte única do quadro do Trello. Cada cartão do Trello traz a descrição e as listas de verificação deste arquivo; quando os dois divergirem, atualize os dois no mesmo dia.

- Situação conferida em 18/11/2026: decisões do DEC-02 e do DEC-03 (fechadas em sala em 17/11), V4 do banco na master do backend (PR #1, merge em 18/11) e contrato 1.4.0, com as decisões do API-01. A coluna “Lista” diz onde cada cartão deve ficar.
- Prazos são **proposta** até o grupo aprovar.
- Entrega da SA (Desenvolvimento de Sistemas Web, AVA): vence em **08/12/2026 às 00:00**. Enviar até **07/12 às 23:59**. Só há **1 tentativa** de envio.
- Clientes: painel web do administrador (React + Vite) e app do paciente (React + Capacitor, Android), com o mesmo backend Spring Boot e o mesmo contrato. Login só pela conta Google.

## Como usar o quadro

O mesmo texto está no cartão “LEIA-ME — Como usar este quadro”, no topo da primeira lista do Trello. O quadro foi simplificado em 18/11: “Pronto para iniciar” juntou com o Backlog em “A fazer”, e a lista “Bloqueado” saiu.

**As listas**

- **Para o grupo decidir:** perguntas que o grupo responde junto (cartões DEC).
- **A fazer:** ainda não começou. Pegue o de prazo mais perto que não depende de nada em aberto.
- **Em andamento:** alguém está fazendo. No máximo um cartão por pessoa.
- **Em revisão (PR aberto):** o código ou o documento está num PR esperando outra pessoa revisar. Só entra com o link do PR no cartão.
- **Concluído:** PR aceito ou decisão registrada.

Não existe lista de “bloqueado”: se um cartão travar esperando algo, ele fica onde está e quem pegou escreve num comentário o que falta.

**Dentro de cada cartão**

- No topo: **Pra quê**, **Quem**, **Prazo** e **Depende de**.
- **O que já se sabe:** o contexto e o histórico, em tópicos.
- Checklist **Passos:** o que fazer. Checklist **Pronto quando:** como saber que acabou.
- No fim: **Requisitos deste cartão**, com o código e o texto de cada RN, RF e RNF.

**Cartões de decisão (DEC)**

1. Cada pergunta é um item da checklist **Perguntas**.
2. A discussão vai nos comentários.
3. Quando o grupo fechar, o Luís escreve a resposta na descrição, em **Decidido**, marca os itens e move o cartão para Concluído.

Marcar o item sem escrever a resposta não vale como decisão. Foi o que confundiu o DEC-02 em 17/11: as caixas diziam “aprovar a proposta”, e os comentários mudavam a proposta.

**Contrato da API**

Rotas, campos e códigos de erro ficam só no api/openapi.yaml; quando usar cada código está na tabela “Códigos de erro”, no topo. Os cartões não repetem códigos: descrevem o caso e apontam para a tabela. Se um cartão e o contrato discordarem, vale o contrato, e quem achou avisa o Luís para corrigir o cartão.

Regras que continuam valendo:

- Mudou rota, campo ou tabela: o contrato ou a modelagem muda no mesmo PR, ou num PR no repositório de docs aberto no mesmo dia.
- Cartão só entra em “Concluído” depois da revisão ou do teste de outra pessoa.

## Definição de pronto (vale para todos os cartões)

1. Todos os itens de “Pronto quando” do cartão conferidos e marcados.
2. Código ou documento no repositório certo, por PR revisado por outra pessoa (cartões de código).
3. `openapi.yaml`, `MODELO_DADOS.md` ou `REQUISITOS.md` atualizados quando a mudança afeta o que eles descrevem.
4. Nenhum segredo (senha, string de conexão, chave do JWT ou da Brevo) no Git, no Trello ou na documentação.
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

## Módulos do enunciado

O enunciado divide o sistema em 6 módulos. O professor descartou a ideia de uma equipe por módulo: cada equipe faz o sistema inteiro. No grupo, o front de todos os módulos é do Victor e o banco de todos é do Luís. A divisão do backend abaixo foi confirmada pelo grupo em 17/11 (DEC-02).

| Módulo | Backend | Cartões |
|---|---|---|
| 1 — Cadastro e autenticação | Yuri | [BE-02](#be-02), [FE-02](#fe-02), [INF-01](#inf-01) |
| 2 — Agenda de profissionais | Pierre (agenda e cadastro de médicos; o Yuri passou o BE-03 em 16/11) | [BE-03](#be-03), [BE-04](#be-04), [FE-07](#fe-07) |
| 3 — Agendamento de consultas | Yuri | [BE-05](#be-05), [DEC-03](#dec-03) |
| 4 — Histórico e consultas do paciente | Pierre | [BE-09](#be-09) |
| 5 — Notificações | Yuri | [BE-06](#be-06), [DIST-01](#dist-01) |
| 6 — Aplicativo mobile | — (front: Victor) | [FE-01M](#fe-01m), [FE-03](#fe-03) |

Os demais cartões (base, banco, contrato, painel, integração, testes, documentação e apresentação) atendem todos os módulos.

## Cronograma proposto

| Período | Foco | Cartões com prazo no período |
|---|---|---|
| Antes de 16/11 | Decisão dos clientes. | DEC-01 (15/11) |
| Semana 1 (16–22/11) | Fechar decisões (feito em 17/11), V4, Google Cloud e Brevo, requisitos, modelo e contrato; banco de produção; base do backend, do painel e do app; login com Google. | DOC-02 (16/11), DEC-02 (18/11), DEC-03 (18/11), REQ-01 (18/11), BE-04 (19/11), DB-01 (20/11), DB-02 (20/11), DB-03 (20/11), API-01 (20/11), BE-01 (20/11), FE-01W (20/11), DEC-04 (21/11), INF-01 (21/11), BE-02 (22/11), FE-01M (22/11) |
| Semana 2 (23–29/11) | Médicos, agendamentos e publicação do backend; login com Google nos clientes. | BE-03 (25/11), FE-02 (25/11), DB-04 (28/11), BE-05 (28/11), BE-08 (29/11) |
| Semana 3 (30/11–06/12) | Notificações e conceito distribuído; telas do paciente, do médico e do administrador; testes, integração, aceite e documentação final. | BE-09 (01/12), BE-06 (02/12), DIST-01 (02/12), FE-03 (02/12), FE-04 (02/12), FE-07 (02/12), BE-07 (03/12), FE-05 (04/12), FE-06 (04/12), INT-01 (04/12), QA-01 (05/12), DOC-01 (06/12) |
| Entrega (07/12) | Ensaio, apresentação e envio no AVA até 23:59. | APR-01 (07/12) |

## Resumo

| ID | Título | Lista | Responsável | Prazo |
|---|---|---|---|---|
| [DEC-04](#dec-04) | Decidir a tela do médico e como a consulta vira concluída | Para o grupo decidir | Todos (Luís registra) | 21/11 |
| [INF-01](#inf-01) | Criar o projeto no Google Cloud e a conta da Brevo | A fazer | Luís | 21/11 |
| [BE-03](#be-03) | Implementar o cadastro de médicos | A fazer | Pierre (o Yuri passou o cartão para ele no Trello em 16/11) | 25/11 |
| [BE-05](#be-05) | Implementar agendamentos | A fazer | Yuri (módulo 3) | 28/11 |
| [BE-09](#be-09) | Implementar o histórico e as listas de consultas | A fazer | Pierre (módulo 4) | 01/12 |
| [BE-06](#be-06) | Implementar notificações: caixa de entrada, e-mail e lembrete | A fazer | Yuri (módulo 5) | 02/12 |
| [DIST-01](#dist-01) | Aplicar o conceito distribuído: notificações assíncronas | A fazer | Yuri, junto com as notificações (Luís documenta) | 02/12 |
| [BE-07](#be-07) | Testar concorrência e regras críticas | A fazer | Yuri e Pierre (revisor: Luís) | 03/12 |
| [BE-08](#be-08) | Publicar o backend com HTTPS | A fazer | Luís | 29/11 |
| [FE-01M](#fe-01m) | Criar a base do app React + Capacitor | A fazer | Victor | 22/11 |
| [FE-03](#fe-03) | Implementar a área do paciente no app | A fazer | Victor | 02/12 |
| [FE-04](#fe-04) | Implementar a área administrativa no painel web | A fazer | Victor | 02/12 |
| [FE-05](#fe-05) | Tratar carregamento, lista vazia e erros no painel e no app | A fazer | Victor | 04/12 |
| [FE-06](#fe-06) | Validar responsividade e acessibilidade básica | A fazer | Victor (revisor: Luís) | 04/12 |
| [FE-07](#fe-07) | Implementar a área do médico | A fazer | Victor | 02/12 |
| [QA-01](#qa-01) | Executar o roteiro de aceite da versão 1 | A fazer | Todos | 05/12 |
| [DOC-01](#doc-01) | Atualizar a documentação final | A fazer | Luís (apoio: todos) | 06/12 |
| [APR-01](#apr-01) | Preparar a apresentação e as respostas técnicas individuais | A fazer | Todos (coordenação: Luís) | 07/12 |
| [DB-02](#db-02) | Validar as migrações no PostgreSQL | Em andamento | Luís (apoio: Yuri ou Pierre) | 20/11 |
| [DB-04](#db-04) | Criar o banco de produção na nuvem | Em andamento | Luís | 28/11 |
| [API-01](#api-01) | Revisar e congelar o contrato OpenAPI v1 | Em andamento | Luís (revisores: Yuri, Pierre e Victor) | 20/11 |
| [BE-01](#be-01) | Completar a base do backend e o ambiente local | Em andamento | Yuri e Pierre | 20/11 |
| [BE-02](#be-02) | Implementar o login com Google e o perfil do usuário | Em andamento | Yuri | 22/11 |
| [BE-04](#be-04) | Concluir agenda e bloqueios (branch feature/api-agendas) | Em andamento | Pierre | 19/11 |
| [FE-01W](#fe-01w) | Estruturar a base do painel web administrativo | Em andamento | Victor | 20/11 |
| [FE-02](#fe-02) | Implementar o login com Google no painel e no app | Em andamento | Victor | 25/11 |
| [INT-01](#int-01) | Integrar painel e app com o backend pelo contrato v1 | Em andamento | Victor, Yuri e Pierre (coordenação: Luís) | 04/12 |
| [DB-01](#db-01) | Revisar e aprovar o modelo de dados (V1 a V4) | Em revisão (PR aberto) | Luís (revisores: Yuri e Pierre) | 20/11 |
| [DEC-01](#dec-01) | Definir os clientes: painel web + app React + Capacitor | Concluído | Luís | 15/11 |
| [DEC-02](#dec-02) | Decisões técnicas da versão 1 | Concluído | Todos (Luís registra) | 18/11 |
| [DEC-03](#dec-03) | Regras de cancelamento e reagendamento | Concluído | Todos (Luís registra) | 18/11 |
| [REQ-01](#req-01) | Confirmar os ajustes do documento de requisitos | Concluído | Luís | 18/11 |
| [DOC-02](#doc-02) | Migrar a documentação do Drive para o repositório agendamentos-sa-docs | Concluído | Luís | 16/11 |
| [DB-03](#db-03) | Carregar dados de demonstração no perfil dev | Concluído | Luís | 20/11 |

## Rastreabilidade: requisito → cartões

O texto de cada requisito está em [REQUISITOS.md](../requisitos/REQUISITOS.md) e também no fim de cada cartão.

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
| RN-012 | DEC-03, DB-01, BE-05, BE-09 |
| RN-013 | DEC-04, DB-01, BE-05, BE-09 |
| RN-014 | BE-05 |
| RN-015 | DEC-03, BE-05, BE-07, FE-03 |
| RN-016 | DEC-03, DB-01, BE-05, BE-07, FE-03, FE-04, FE-07 |
| RN-017 | DEC-02, DB-01, BE-04 |
| RF-001 | BE-02, FE-02 |
| RF-002 | DEC-02, BE-02, INF-01, FE-02 |
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
| RF-017 | BE-09, FE-04 |
| RF-018 | DEC-03, BE-05, FE-04 |
| RF-019 | BE-05, BE-09, FE-03 |
| RF-020 | BE-09, FE-03 |
| RF-021 | BE-09, FE-03 |
| RF-022 | BE-09, FE-04 |
| RF-023 | BE-09, FE-04 |
| RF-024 | DEC-02, INF-01, BE-06, DIST-01 |
| RF-025 | DEC-02, BE-06, DIST-01 |
| RF-026 | DEC-02, BE-06, DIST-01 |
| RF-027 | DEC-02, BE-06, DIST-01 |
| RF-028 | DEC-02, DB-01, BE-06, DIST-01 |
| RF-029 | DEC-04, BE-09, FE-07 |
| RF-030 | DEC-03, DEC-04, BE-05, FE-07 |
| RNF-001 | REQ-01, DB-04, BE-08, INT-01 |
| RNF-002 | DEC-02, BE-02, INF-01 |
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

### Para o grupo decidir

<a id="dec-04"></a>

#### DEC-04 — Decidir a tela do médico e como a consulta vira concluída

**Lista:** Para o grupo decidir · **Responsável:** Todos (Luís registra) · **Prazo (proposta):** 21/11 · **Depende de:** — · **Etiquetas:** Decisão da equipe, Prioridade alta

**Pra quê.** Fechar o que sobrou do DEC-02 com a entrada do médico na versão 1.

**O que já se sabe**

- Com o médico entrando na v1 (17/11), faltam duas respostas. Sem elas, o Victor não sabe onde fazer a tela do médico (FE-07) e o Pierre não sabe como fechar o histórico (BE-09).
- Proposta para a tela: no painel web. O médico usa no computador do consultório, o painel já tem login e layout, e o app fica só do paciente.
- Proposta para a consulta concluída: vira CONCLUIDA sozinha depois do horário de fim, por uma tarefa agendada no backend, sem botão. Se o grupo preferir que o médico marque, entram uma rota (PATCH /agendamentos/{id}/conclusao) e um botão na tela dele.
- Como fechar: discutam nos comentários; quando decidirem, o Luís escreve a resposta na descrição, em “Decidido”, marca os itens e move o cartão para Concluído.

**Entra:** onde fica a tela do médico; como a consulta vira CONCLUIDA; painel e app no mesmo projeto React. **Fica de fora:** prontuário; falta do paciente (não existe status de falta na v1).

**Perguntas**

- [ ] Onde fica a tela do médico: no painel web (proposta) ou no app?
- [ ] Como a consulta vira CONCLUIDA: sozinha depois do horário (proposta) ou o médico marca?
- [ ] Painel e app ficam no mesmo projeto React (frontend-agendamento)? O Victor responde
- [ ] Registrar as respostas aqui, em “Decidido”, e no MODELO_DADOS.md

**Pronto quando**

- [ ] Cada pergunta tem a resposta escrita na descrição, em “Decidido”
- [ ] BE-09 e FE-07 citam a resposta

**Requisitos deste cartão**

- **RN-013** — O sistema deve controlar os estados dos agendamentos conforme o fluxo definido, conforme: AGENDADA, CANCELADA e CONCLUIDA
- **RF-029** — O sistema deve permitir que médicos consultem a própria agenda e as consultas marcadas com eles.
- **RF-030** — O sistema deve permitir que médicos cancelem consultas da própria agenda, informando o motivo.

**Links:** [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md) · [requisitos/REQUISITOS.md](../requisitos/REQUISITOS.md)

### A fazer

<a id="inf-01"></a>

#### INF-01 — Criar o projeto no Google Cloud e a conta da Brevo

**Lista:** A fazer · **Responsável:** Luís · **Prazo (proposta):** 21/11 · **Depende de:** — · **Etiquetas:** Backend, Integração, Prioridade alta

**Módulo do enunciado:** 1 — Cadastro e autenticação

**Pra quê.** Ter os IDs de cliente do login com Google e a chave de envio de e-mail, para o Yuri e o Victor programarem.

**O que já se sabe**

- O login com Google (DEC-02) precisa de um projeto no Google Cloud com a tela de consentimento e um ID de cliente para cada tipo de cliente: web (painel) e Android (app).
- Como o login só pede nome, e-mail e foto (openid, email, profile), não há permissão sensível: dá para publicar o app no Google sem a verificação deles, e qualquer conta Google entra.
- O plano gratuito do Render bloqueia SMTP. O e-mail sai pela API HTTP da Brevo (gratuita, 300 por dia). Sem domínio próprio, o e-mail pode cair no spam no começo: antes da apresentação, marquem “não é spam”.
- Os IDs de cliente do Google não são segredo; a chave da Brevo é.

**Entra:** projeto no Google Cloud; tela de consentimento; IDs de cliente web e Android; conta e chave da Brevo. **Fica de fora:** permissões da Google Agenda (decidido: só convite .ics no e-mail); domínio próprio para o e-mail.

**Passos**

- [ ] Criar o projeto no Google Cloud com a conta do Luís
- [ ] Tela de consentimento externa, só com openid, email e profile, e publicar
- [ ] ID de cliente web, com as origens do painel (http://localhost:5173 e a URL publicada)
- [ ] ID de cliente Android, com o nome do pacote do app e a impressão SHA-1 da chave do Victor
- [ ] Dar acesso de editor ao Yuri e ao Victor
- [ ] Criar a conta gratuita na Brevo e verificar o e-mail remetente
- [ ] Gerar a chave da API da Brevo e guardar só no Render (BREVO_API_KEY) e no .env de quem programa o e-mail
- [ ] Passar os IDs de cliente ao Yuri e ao Victor

**Pronto quando**

- [ ] O botão “Entrar com Google” funciona no painel local
- [ ] Nenhuma chave no Git, no Trello ou na documentação

**Requisitos deste cartão**

- **RF-002** — O sistema deve permitir a autenticação por meio da conta Google.
- **RF-024** — O sistema deve enviar notificações de confirmação de agendamento.
- **RNF-002** — O sistema não deve armazenar senhas: a autenticação é feita pela conta Google, e o backend confere o token do Google antes de emitir o próprio token de acesso. As senhas dos usuários de demonstração do ambiente de desenvolvimento usam hash BCrypt.

**Links:** [banco-de-dados/AMBIENTES.md](../banco-de-dados/AMBIENTES.md) · [arquitetura/ARQUITETURA.md](../arquitetura/ARQUITETURA.md)

<a id="be-03"></a>

#### BE-03 — Implementar o cadastro de médicos

**Lista:** A fazer · **Responsável:** Pierre (o Yuri passou o cartão para ele no Trello em 16/11) · **Prazo (proposta):** 25/11 · **Depende de:** BE-04 (merge da branch), BE-02, V4 (DB-01) · **Etiquetas:** Backend

**Módulo do enunciado:** 2 — Agenda de profissionais

**Pra quê.** Administrador cadastra, edita, lista e desativa médicos; paciente lista para escolher; o médico entra com o Google.

**O que já se sabe**

- A entidade Medico e o MedicoRepository (com lock pessimista) estão na branch feature/api-agendas; o CRUD ainda não existe. Rotas planejadas: GET e POST /medicos, GET e PATCH /medicos/{id}.
- Desde a V4 (decisão de 17/11) o médico entra no sistema: o cadastro recebe o e-mail Google dele, cria o usuário MEDICO e liga em medico.usuario_id, na mesma transação. No primeiro login com o Google o sistema reconhece o médico pelo e-mail.

**Entra:** listagem paginada com os filtros do contrato; cadastro com e-mail Google; edição; desativação lógica. **Fica de fora:** o login em si (BE-02); a tela do médico (FE-07).

**Passos**

- [x] Reaproveitar Medico e MedicoRepository da branch feature/api-agendas
- [ ] Ligar a entidade Medico ao usuário (usuario_id, V4)
- [ ] DTOs e validações: e-mail, CRM, UF com duas letras maiúsculas, especialidade
- [ ] GET /medicos paginado com filtros
- [ ] POST /medicos criando o usuário MEDICO com o e-mail Google, na mesma transação; GET /medicos/{id}
- [ ] PATCH /medicos/{id}, incluindo ativar e desativar
- [ ] Erros pela tabela de erros do contrato: CRM/UF ou e-mail repetido é conflito (no PR #2, IllegalArgumentException ainda vira erro 500)
- [ ] Restringir escrita a ADMIN
- [ ] Testes de duplicidade, validação e permissão
- [ ] Atualizar x-status no openapi.yaml

**Pronto quando**

- [ ] Mesmo CRM em outra UF é aceito; mesmo CRM e UF é recusado como conflito
- [ ] Médico desativado continua no histórico e some da escolha do paciente
- [ ] Paciente lista, mas não altera
- [ ] O médico cadastrado entra com o Google e cai no perfil MEDICO

**Requisitos deste cartão**

- **RN-003** — Apenas administradores podem cadastrar, editar ou desativar médicos.
- **RN-011** — A desativação de um médico deve impedir a criação de novos agendamentos para esse profissional.
- **RF-007** — O sistema deve permitir que administradores cadastrem, editem, consultem e desativem médicos.

**Links:** [openapi.yaml (contrato; tabela de erros no topo)](../api/openapi.yaml) · [branch feature/api-agendas](https://github.com/faculdade-ads-senai/agendamentos-sa-backend/tree/feature/api-agendas)

<a id="be-05"></a>

#### BE-05 — Implementar agendamentos

**Lista:** A fazer · **Responsável:** Yuri (módulo 3) · **Prazo (proposta):** 28/11 · **Depende de:** BE-02, BE-03, BE-04 · **Etiquetas:** Backend, Prioridade alta

**Módulo do enunciado:** 3 — Agendamento de consultas

**Pra quê.** Paciente agenda, cancela e reagenda; médico cancela as consultas dele; administrador cancela e reagenda qualquer consulta.

**O que já se sabe**

- Rotas planejadas: POST /agendamentos, GET /agendamentos/{id}, PATCH .../reagendamento e PATCH .../cancelamento. As listas e o histórico ficam no BE-09.
- O banco já recusa sobreposição por médico e por paciente; o serviço devolve isso como horário ocupado. A V4 recusa cancelamento sem motivo. O código de cada erro está na tabela de erros do contrato.
- Regras do DEC-03 (17/11): paciente só nas próprias consultas e até 24 horas antes; médico só cancela, nas consultas da própria agenda; administrador faz tudo, sem prazo. Toda mudança avisa o paciente e o médico, menos quem fez. As regras de contexto estão em “Regras que ficam na aplicação” do MODELO_DADOS.md e nas rotas do openapi.yaml.

**Entra:** criação com lock no médico; cancelamento e reagendamento com as regras do DEC-03; notificações PENDENTE na mesma transação. **Fica de fora:** listas e histórico (BE-09); envio das notificações (BE-06); pagamento, convênio ou prontuário.

**Passos**

- [ ] Entidade Agendamento e repositório (o BE-09 usa a mesma)
- [ ] POST /agendamentos: lock no médico, janela ativa, sem bloqueio, início futuro e duração da janela
- [ ] Traduzir exclusion_violation em horário ocupado
- [ ] GET /agendamentos/{id}: paciente dono, médico da consulta ou ADMIN; os outros recebem “não encontrado”
- [ ] PATCH cancelamento: motivo obrigatório; paciente até 24 horas antes e só as próprias; médico só da própria agenda; ADMIN qualquer
- [ ] PATCH reagendamento: paciente até 24 horas antes; ADMIN qualquer; médico não; novo horário validado na mesma transação
- [ ] Erros pela tabela de erros do contrato e pela descrição de cada rota
- [ ] Gravar as notificações PENDENTE (SISTEMA e EMAIL) do paciente e do médico, menos de quem fez, na mesma transação (base do DIST-01)
- [ ] Testes de serviço para cada regra
- [ ] Atualizar x-status no openapi.yaml

**Pronto quando**

- [ ] Horário fora da agenda, bloqueado ou passado é recusado
- [ ] Dois pedidos para o mesmo horário: um grava e o outro é recusado como horário ocupado
- [ ] Paciente não vê nem altera consulta de outro paciente
- [ ] Paciente a menos de 24 horas é recusado com “fale com a clínica”; médico e administrador conseguem cancelar
- [ ] Cancelamento sem motivo é recusado
- [ ] Cada erro volta com o código da tabela de erros do contrato
- [ ] Consulta cancelada continua no histórico e libera o horário

**Requisitos deste cartão**

- **RN-002** — Apenas usuários autenticados podem realizar agendamentos.
- **RN-004** — Um médico não pode possuir dois agendamentos ativos que ocupem o mesmo intervalo de atendimento.
- **RN-005** — Consultas devem ser agendadas somente em horários definidos como disponíveis.
- **RN-006** — Agendamentos não podem ser realizados para datas ou horários anteriores ao momento atual.
- **RN-007** — O cancelamento de uma consulta deve liberar o horário para novos agendamentos, desde que não exista outro bloqueio.
- **RN-008** — O reagendamento deve validar a disponibilidade do novo horário antes da confirmação.
- **RN-009** — Pacientes devem visualizar apenas seus próprios agendamentos e informações pessoais.
- **RN-010** — Toda consulta deve estar vinculada a um paciente, médico, data e horário.
- **RN-012** — Agendamentos cancelados devem permanecer registrados no histórico.
- **RN-013** — O sistema deve controlar os estados dos agendamentos conforme o fluxo definido, conforme: AGENDADA, CANCELADA e CONCLUIDA
- **RN-014** — Uma solicitação de agendamento deve ser confirmada somente após a verificação da disponibilidade do horário.
- **RN-015** — O paciente só pode cancelar ou reagendar a própria consulta até 24 horas antes do início. O médico (só cancelamento, nas consultas da própria agenda) e o administrador podem fazê-lo a qualquer momento antes da consulta.
- **RN-016** — Todo cancelamento deve registrar o motivo.
- **RF-013** — O sistema deve permitir a seleção de médico e horário para agendamento.
- **RF-014** — O sistema deve permitir a confirmação de um agendamento quando houver disponibilidade.
- **RF-015** — O sistema deve permitir o cancelamento de consultas agendadas.
- **RF-016** — O sistema deve permitir o reagendamento de consultas.
- **RF-018** — O sistema deve permitir que administradores cancelem ou reagendem consultas.
- **RF-019** — O sistema deve permitir a consulta do status de cada agendamento.
- **RF-030** — O sistema deve permitir que médicos cancelem consultas da própria agenda, informando o motivo.
- **RNF-012** — O sistema deve preservar a consistência dos agendamentos em operações simultâneas.

**Links:** [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md) · [openapi.yaml (contrato; tabela de erros no topo)](../api/openapi.yaml)

<a id="be-09"></a>

#### BE-09 — Implementar o histórico e as listas de consultas

**Lista:** A fazer · **Responsável:** Pierre (módulo 4) · **Prazo (proposta):** 01/12 · **Depende de:** BE-05 (entidade Agendamento), DEC-04 · **Etiquetas:** Backend

**Módulo do enunciado:** 4 — Histórico e consultas do paciente

**Pra quê.** Paciente vê as próximas consultas e o histórico; médico vê as consultas da agenda dele; administrador consulta e filtra as consultas de todos.

**O que já se sabe**

- Módulo 4 do enunciado (Histórico e consultas do paciente). Não precisa de tabela nova: tudo sai da tabela agendamento, que guarda o status (AGENDADA, CANCELADA, CONCLUIDA) e nunca apaga consulta. O índice ix_agendamento_paciente_inicio já atende a lista do paciente.
- Desde 17/11 o médico entra no sistema: GET /agendamentos/me devolve, para o médico, as consultas da própria agenda (RF-029).
- Hoje nenhuma rota marca a consulta como CONCLUIDA. Como isso acontece está no DEC-04 (proposta: sozinha, depois do horário de fim).

**Entra:** GET /agendamentos/me para paciente e médico, com próximas e histórico; GET /agendamentos do administrador com filtros; histórico de um paciente para o administrador; paginação; consulta CONCLUIDA conforme o DEC-04. **Fica de fora:** criar, cancelar ou reagendar (BE-05); prontuário ou dados clínicos.

**Passos**

- [ ] Usar a entidade Agendamento do BE-05 (combinar com o Yuri)
- [ ] GET /agendamentos/me: paciente vê as próprias; médico vê as da própria agenda; próximas e histórico, paginado
- [ ] GET /agendamentos para ADMIN com filtros de período, médico, paciente e status
- [ ] Histórico de um paciente para o ADMIN (filtro por paciente)
- [ ] Implementar como a consulta vira CONCLUIDA, conforme a resposta do DEC-04
- [ ] Testes: paciente e médico só veem o que é deles; filtros combinados
- [ ] Atualizar x-status no openapi.yaml

**Pronto quando**

- [ ] Consulta cancelada aparece no histórico com o status CANCELADA
- [ ] Paciente não vê consulta de outro paciente; médico não vê consulta de outro médico
- [ ] Filtros de período, médico e status funcionam juntos

**Requisitos deste cartão**

- **RN-012** — Agendamentos cancelados devem permanecer registrados no histórico.
- **RN-013** — O sistema deve controlar os estados dos agendamentos conforme o fluxo definido, conforme: AGENDADA, CANCELADA e CONCLUIDA
- **RF-017** — O sistema deve permitir que administradores consultem os agendamentos realizados.
- **RF-019** — O sistema deve permitir a consulta do status de cada agendamento.
- **RF-020** — O sistema deve permitir que pacientes consultem seus próximos agendamentos.
- **RF-021** — O sistema deve permitir que pacientes visualizem o histórico de agendamentos anteriores.
- **RF-022** — O sistema deve permitir que administradores consultem o histórico de agendamentos dos pacientes.
- **RF-023** — O sistema deve permitir a filtragem de agendamentos por período, médico ou status no painel administrativo.
- **RF-029** — O sistema deve permitir que médicos consultem a própria agenda e as consultas marcadas com eles.

**Links:** [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md) · [openapi.yaml (contrato; tabela de erros no topo)](../api/openapi.yaml)

<a id="be-06"></a>

#### BE-06 — Implementar notificações: caixa de entrada, e-mail e lembrete

**Lista:** A fazer · **Responsável:** Yuri (módulo 5) · **Prazo (proposta):** 02/12 · **Depende de:** BE-05, INF-01 · **Etiquetas:** Backend

**Módulo do enunciado:** 5 — Notificações

**Pra quê.** Paciente e médico recebem confirmações, lembretes, cancelamentos e alterações na caixa de entrada e por e-mail.

**O que já se sabe**

- Decisão de 17/11 (DEC-02): cada aviso aparece na caixa de entrada do app e do painel (canal SISTEMA) e vai por e-mail (canal EMAIL), em segundo plano. Sem push no celular.
- O e-mail sai pela API HTTP da Brevo, porque o plano gratuito do Render bloqueia SMTP. A chave fica em BREVO_API_KEY (INF-01).
- O e-mail de confirmação e o de reagendamento levam um convite de agenda (.ics) que a pessoa adiciona à Google Agenda; o de cancelamento leva o convite de cancelamento. O sistema não grava nada na agenda de ninguém.
- A tabela notificacao já tem tipo (CONFIRMACAO, LEMBRETE, CANCELAMENTO, ALTERACAO), canal (SISTEMA, EMAIL), status e tentativas. Rotas planejadas: GET /notificacoes/me e PATCH /notificacoes/{id}/leitura.

**Entra:** geração dos avisos; lembrete 24 horas antes; caixa de entrada e marcação de lida; envio de e-mail com convite .ics. **Fica de fora:** push no celular; SMS ou WhatsApp; gravar direto na Google Agenda (exige permissão sensível do Google).

**Passos**

- [ ] Entidade Notificacao e repositório
- [ ] Gerar CONFIRMACAO, CANCELAMENTO e ALTERACAO, nos canais SISTEMA e EMAIL, a partir do BE-05
- [ ] Tarefa agendada que cria o LEMBRETE 24 horas antes, sem repetir
- [ ] GET /notificacoes/me (caixa de entrada) paginado com o filtro somenteNaoLidas
- [ ] PATCH /notificacoes/{id}/leitura
- [ ] Enviar o e-mail pela API HTTP da Brevo
- [ ] Anexar o convite .ics: REQUEST na confirmação e no reagendamento, CANCEL no cancelamento, mesmo UID por consulta
- [ ] Testes
- [ ] Atualizar x-status no openapi.yaml

**Pronto quando**

- [ ] Cada agendamento, cancelamento e reagendamento gera um aviso para cada pessoa avisada, nos dois canais
- [ ] O lembrete não é criado duas vezes para a mesma consulta
- [ ] Cada um só vê as próprias notificações
- [ ] O convite do e-mail entra na Google Agenda de quem recebe

**Requisitos deste cartão**

- **RF-024** — O sistema deve enviar notificações de confirmação de agendamento.
- **RF-025** — O sistema deve enviar lembretes sobre consultas futuras.
- **RF-026** — O sistema deve notificar pacientes sobre cancelamentos de consultas.
- **RF-027** — O sistema deve notificar pacientes sobre alterações nos agendamentos.
- **RF-028** — O sistema deve manter registros das notificações enviadas.

**Links:** [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md) · [openapi.yaml (contrato; tabela de erros no topo)](../api/openapi.yaml)

<a id="dist-01"></a>

#### DIST-01 — Aplicar o conceito distribuído: notificações assíncronas

**Lista:** A fazer · **Responsável:** Yuri, junto com as notificações (Luís documenta) · **Prazo (proposta):** 02/12 · **Depende de:** BE-05, BE-06 · **Etiquetas:** Backend, Banco de dados, Sistemas distribuídos, Prioridade alta

**Módulo do enunciado:** 5 — Notificações

**Pra quê.** Aplicar e justificar pelo menos um conceito de sistemas distribuídos, como a SA pede.

**O que já se sabe**

- O item 6 da SA pede um conceito distribuído aplicado e justificado.
- A proposta é a caixa de saída transacional: a operação grava a notificação junto com o agendamento e um processo separado entrega depois.
- Isso conversa com o conteúdo de Mensageria de Sistemas Distribuídos, e a tabela notificacao já tem status, tentativas e enviada_em.
- Desde 17/11 o envio é real: o e-mail vai pela API da Brevo, um serviço externo que pode falhar, o que deixa a demonstração mais concreta.

**Entra:** processo de envio separado; reenvio com contagem de tentativas; duas instâncias sem envio duplicado; justificativa escrita. **Fica de fora:** broker de mensagens obrigatório (opcional, ver tarefas).

**Passos**

- [x] Dono: Yuri, junto com as notificações (DEC-02, 17/11)
- [ ] Processo separado (tarefa agendada do Spring, ou consumidor) que lê PENDENTE com FOR UPDATE SKIP LOCKED
- [ ] Marcar ENVIADA com enviada_em, ou FALHA somando tentativas
- [ ] Limite de tentativas e reenvio das que falharam
- [ ] Simular a Brevo fora do ar (chave errada) e mostrar que o agendamento continua confirmado
- [ ] Rodar duas instâncias e mostrar que nenhuma notificação sai duas vezes
- [ ] Avaliar trocar o processo por uma fila (RabbitMQ), se o professor de Distribuídos pedir mensageria explícita — a confirmar
- [ ] Escrever a justificativa em arquitetura/ARQUITETURA.md
- [ ] Preparar a demonstração do conceito para a apresentação

**Pronto quando**

- [ ] Agendar, cancelar e reagendar gravam a notificação PENDENTE na mesma transação
- [ ] Falha no envio não desfaz nem atrasa o agendamento
- [ ] Duas instâncias não enviam a mesma notificação
- [ ] Justificativa na documentação e na apresentação

**Requisitos deste cartão**

- **RF-024** — O sistema deve enviar notificações de confirmação de agendamento.
- **RF-025** — O sistema deve enviar lembretes sobre consultas futuras.
- **RF-026** — O sistema deve notificar pacientes sobre cancelamentos de consultas.
- **RF-027** — O sistema deve notificar pacientes sobre alterações nos agendamentos.
- **RF-028** — O sistema deve manter registros das notificações enviadas.
- **RNF-013** — O sistema deve possuir mecanismos de tratamento de falhas de comunicação com o backend.
- **RNF-019** — As notificações devem ser registradas na mesma transação da operação que as origina e enviadas por um processo assíncrono, sem bloquear o agendamento, com registro de tentativas e reenvio em caso de falha.

**Links:** [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md) · [arquitetura/ARQUITETURA.md](../arquitetura/ARQUITETURA.md) · [requisitos/REQUISITOS.md](../requisitos/REQUISITOS.md)

<a id="be-07"></a>

#### BE-07 — Testar concorrência e regras críticas

**Lista:** A fazer · **Responsável:** Yuri e Pierre (revisor: Luís) · **Prazo (proposta):** 03/12 · **Depende de:** BE-02, BE-05 · **Etiquetas:** Backend, Banco de dados, Testes, Prioridade alta

**Pra quê.** Ter testes automatizados que provem as regras de que a SA mais cobra: autenticação e agendamento.

**O que já se sabe**

- O RNF-018 pede testes automatizados nas funcionalidades críticas, e o RNF-012 pede consistência em operações simultâneas.
- O banco segura a sobreposição; o teste precisa mostrar isso pela API.

**Entra:** testes de integração com PostgreSQL real (Testcontainers ou banco de teste); teste de pedidos simultâneos. **Fica de fora:** teste de carga (QA-01).

**Passos**

- [ ] Escolher como subir o PostgreSQL nos testes (Testcontainers ou banco dedicado)
- [ ] Dois pedidos simultâneos para o mesmo médico e horário: um grava e o outro é recusado como horário ocupado
- [ ] Paciente não ocupa duas consultas sobrepostas
- [ ] Cancelamento libera o horário
- [ ] Bloqueio retira o horário da disponibilidade
- [ ] Médico inativo não recebe agendamento
- [ ] Paciente a menos de 24 horas não cancela; cancelamento sem motivo é recusado
- [ ] Testes de autenticação: sem token e perfil sem permissão, conferindo os códigos da tabela de erros do contrato
- [ ] Rodar todos com ./mvnw test e anexar o resultado

**Pronto quando**

- [ ] ./mvnw test passa num clone limpo
- [ ] O teste de concorrência falha se a restrição do banco for removida

**Requisitos deste cartão**

- **RN-004** — Um médico não pode possuir dois agendamentos ativos que ocupem o mesmo intervalo de atendimento.
- **RN-007** — O cancelamento de uma consulta deve liberar o horário para novos agendamentos, desde que não exista outro bloqueio.
- **RN-011** — A desativação de um médico deve impedir a criação de novos agendamentos para esse profissional.
- **RN-015** — O paciente só pode cancelar ou reagendar a própria consulta até 24 horas antes do início. O médico (só cancelamento, nas consultas da própria agenda) e o administrador podem fazê-lo a qualquer momento antes da consulta.
- **RN-016** — Todo cancelamento deve registrar o motivo.
- **RNF-012** — O sistema deve preservar a consistência dos agendamentos em operações simultâneas.
- **RNF-018** — As funcionalidades críticas de autenticação e agendamento devem possuir testes automatizados.

**Links:** [banco-de-dados/validacao_restricoes.sql](../banco-de-dados/validacao_restricoes.sql)

<a id="be-08"></a>

#### BE-08 — Publicar o backend com HTTPS

**Lista:** A fazer · **Responsável:** Luís · **Prazo (proposta):** 29/11 · **Depende de:** BE-01, DB-04, INF-01 · **Etiquetas:** Backend, Integração

**Pra quê.** O app no celular e o painel publicado acessam a API pela internet, ligada ao banco de produção.

**O que já se sabe**

- O Luís assumiu a publicação em 16/11.
- O banco de produção fica no Neon (DB-04).
- Sem o backend publicado, o app só funciona na mesma rede do computador que roda a API.
- O RNF-001 exige HTTPS no ambiente publicado.
- Não precisa mexer no Java: o application.yaml já lê banco, porta, JWT_SECRET e CORS de variáveis de ambiente.
- Decidido no DEC-02 (17/11): Render, cujo plano gratuito roda Docker e dá HTTPS, mas bloqueia SMTP (por isso o e-mail vai pela Brevo); o serviço dorme após 15 minutos sem acesso e leva cerca de 1 minuto para acordar.
- Desde 16/11 o repositório do backend está na organização faculdade-ads-senai, onde o Luís é dono: ele mesmo libera o Render.

**Entra:** Dockerfile do backend (PR no repositório agendamentos-sa-backend); variáveis de produção no Render; HTTPS e CORS. **Fica de fora:** mudanças no código Java; publicação do painel web (pode ir junto, se o grupo quiser).

**Passos**

- [x] Avisar o grupo que o Luís publica a API no Render (aprovado no DEC-02, 17/11)
- [x] Ter acesso de dono ao repositório para liberar o Render (organização faculdade-ads-senai, 16/11)
- [ ] Criar o Dockerfile do backend: build com o mvnw sem rodar os testes, imagem final só com o Java 21
- [ ] Abrir o PR do Dockerfile e explicar ao grupo
- [ ] Criar o serviço no Render a partir do master, sem ativar o perfil dev
- [ ] Configurar no Render, fora do Git: SPRING_DATASOURCE_URL com o endereço direto do Neon (sem -pooler) e sslmode=require, DB_USERNAME, DB_PASSWORD, um JWT_SECRET novo, o ID de cliente do Google e a BREVO_API_KEY (INF-01)
- [ ] Liberar em CORS_ALLOWED_ORIGINS o painel publicado e o app (https://localhost)
- [ ] Registrar a URL publicada em banco-de-dados/AMBIENTES.md
- [ ] No dia da apresentação, abrir a URL alguns minutos antes para o serviço acordar

**Pronto quando**

- [ ] O login (POST /api/v1/auth/google) responde por HTTPS
- [ ] O app instalado no celular faz login pela internet

**Requisitos deste cartão**

- **RNF-001** — Toda comunicação entre as interfaces e o backend publicado deve utilizar HTTPS. No desenvolvimento local, HTTP é aceito.
- **RNF-009** — O sistema deve utilizar APIs REST para comunicação entre os componentes.

**Links:** [banco-de-dados/AMBIENTES.md](../banco-de-dados/AMBIENTES.md)

<a id="fe-01m"></a>

#### FE-01M — Criar a base do app React + Capacitor

**Lista:** A fazer · **Responsável:** Victor · **Prazo (proposta):** 22/11 · **Depende de:** DEC-01, API-01 · **Etiquetas:** Mobile, Frontend, Prioridade alta

**Módulo do enunciado:** 6 — Aplicativo mobile

**Pra quê.** Ter o app do paciente gerando APK, com a estrutura de telas e o cliente da API.

**O que já se sabe**

- A arquitetura do app (pastas pages, services, contexts, hooks, routes e capacitor.config) está em arquitetura/ARQUITETURA.md, em duas versões: JSX e TSX.
- O Victor faz o front de todos os módulos (16/11).
- A separação em dois repositórios veio do ChatGPT do projeto do Yuri, não do professor; o provável é um projeto só (frontend-agendamento), com o Capacitor gerando o APK do mesmo código React (a confirmar com o Victor).

**Entra:** projeto React + Vite + Capacitor com Android; rotas das telas do paciente; cliente HTTP com JWT; tratamento de falha de rede. **Fica de fora:** iOS; publicação na Play Store.

**Passos**

- [x] Definir o responsável: Victor, que faz o front de todos os módulos (16/11)
- [ ] Confirmar painel e app no mesmo projeto (frontend-agendamento) — pergunta do DEC-04
- [ ] Adicionar o Capacitor com a plataforma Android ao projeto React
- [ ] Separar as telas por perfil: paciente no app, administrador no painel
- [ ] Gerar e instalar um APK de teste num Android 8.0 ou superior
- [ ] Conferir se a versão do Capacitor usada aceita Android 8.0 (RNF-016)
- [ ] Rotas: login, cadastro, início, médicos, horários, agendar, minhas consultas, histórico e perfil
- [ ] Cliente HTTP central com URL da API configurável e token JWT
- [ ] Aviso de falha de rede com botão de tentar de novo
- [ ] Navegação inferior e layout para celular

**Pronto quando**

- [ ] APK instala e abre num Android 8.0+
- [ ] O app chama a API publicada (BE-08) ou a local pela rede

**Requisitos deste cartão**

- **RNF-007** — O aplicativo mobile (React + Capacitor) deve oferecer interface adequada a diferentes tamanhos de tela de celulares.
- **RNF-013** — O sistema deve possuir mecanismos de tratamento de falhas de comunicação com o backend.
- **RNF-016** — O aplicativo mobile deve funcionar em Android 8.0 (API 26) ou superior.

**Links:** [arquitetura/ARQUITETURA.md](../arquitetura/ARQUITETURA.md)

<a id="fe-03"></a>

#### FE-03 — Implementar a área do paciente no app

**Lista:** A fazer · **Responsável:** Victor · **Prazo (proposta):** 02/12 · **Depende de:** FE-01M, FE-02, BE-03, BE-05 · **Etiquetas:** Mobile, Frontend

**Módulo do enunciado:** 6 — Aplicativo mobile

**Pra quê.** Paciente faz pelo celular tudo o que os requisitos pedem: agendar, acompanhar, cancelar e reagendar.

**O que já se sabe**

- As telas seguem a arquitetura do app e as rotas do contrato: /medicos, /medicos/{id}/horarios-disponiveis, /agendamentos, /agendamentos/me e /notificacoes/me.
- Regras do DEC-03 (17/11): o paciente cancela ou reagenda só até 24 horas antes, e o cancelamento pede motivo.
- As notificações aparecem numa caixa de entrada; também chegam por e-mail, com convite para a Google Agenda.

**Entra:** dados pessoais; escolha de médico e horário; consultas futuras e histórico; cancelar e reagendar; notificações. **Fica de fora:** pagamento; teleconsulta.

**Passos**

- [ ] Editar o nome (lê em GET /auth/me e salva em PATCH /usuarios/me; o e-mail é o da conta Google)
- [ ] Listar médicos com filtro de especialidade
- [ ] Ver horários disponíveis por data
- [ ] Confirmar agendamento
- [ ] Listar próximas consultas e histórico
- [ ] Cancelar (com motivo) e reagendar; a menos de 24 horas, mostrar “fale com a clínica”
- [ ] Caixa de entrada de notificações, com as não lidas em destaque e marcar como lida
- [ ] Se o horário foi ocupado por outra pessoa, atualizar os horários e avisar

**Pronto quando**

- [ ] Fluxo completo de agendar, cancelar e reagendar no celular
- [ ] Datas e horas exibidas no fuso de São Paulo

**Requisitos deste cartão**

- **RN-009** — Pacientes devem visualizar apenas seus próprios agendamentos e informações pessoais.
- **RN-015** — O paciente só pode cancelar ou reagendar a própria consulta até 24 horas antes do início. O médico (só cancelamento, nas consultas da própria agenda) e o administrador podem fazê-lo a qualquer momento antes da consulta.
- **RN-016** — Todo cancelamento deve registrar o motivo.
- **RF-003** — O sistema deve permitir que pacientes consultem e atualizem seus dados cadastrais.
- **RF-011** — O sistema deve permitir a consulta dos horários disponíveis de cada médico.
- **RF-013** — O sistema deve permitir a seleção de médico e horário para agendamento.
- **RF-014** — O sistema deve permitir a confirmação de um agendamento quando houver disponibilidade.
- **RF-015** — O sistema deve permitir o cancelamento de consultas agendadas.
- **RF-016** — O sistema deve permitir o reagendamento de consultas.
- **RF-019** — O sistema deve permitir a consulta do status de cada agendamento.
- **RF-020** — O sistema deve permitir que pacientes consultem seus próximos agendamentos.
- **RF-021** — O sistema deve permitir que pacientes visualizem o histórico de agendamentos anteriores.

**Links:** [openapi.yaml (contrato; tabela de erros no topo)](../api/openapi.yaml) · [arquitetura/ARQUITETURA.md](../arquitetura/ARQUITETURA.md)

<a id="fe-04"></a>

#### FE-04 — Implementar a área administrativa no painel web

**Lista:** A fazer · **Responsável:** Victor · **Prazo (proposta):** 02/12 · **Depende de:** FE-01W, FE-02, BE-03, BE-04, BE-05 · **Etiquetas:** Frontend

**Pra quê.** Administrador gerencia médicos, agendas, bloqueios, pacientes e consultas pelo painel, fazendo também o papel da recepcionista.

**O que já se sabe**

- As rotas de agenda e bloqueios já existem na branch feature/api-agendas; médicos e agendamentos estão planejados no contrato.
- Decisões de 17/11: o administrador faz o papel da recepcionista (agenda, cancela e reagenda pelo paciente, sem prazo); o médico é cadastrado com o e-mail Google dele; todo cancelamento pede motivo.

**Entra:** painel inicial; médicos; agenda semanal; bloqueios; pacientes; agendamentos com filtros. **Fica de fora:** relatórios e gráficos avançados.

**Passos**

- [ ] Painel inicial com as consultas do dia e as próximas
- [ ] Médicos: listar, cadastrar (com o e-mail Google do médico), editar e desativar
- [ ] Agenda semanal por médico (janelas por dia da semana)
- [ ] Bloqueios: cadastrar e desativar
- [ ] Pacientes: listar e ver histórico de consultas
- [ ] Agendamentos: listar com filtros de período, médico e status
- [ ] Agendar por um paciente (papel da recepcionista)
- [ ] Cancelar (com motivo) e reagendar como administrador, sem prazo
- [ ] Caixa de entrada de notificações do administrador

**Pronto quando**

- [ ] Todas as ações do administrador nos requisitos têm tela
- [ ] Tabelas se adaptam ao tablet

**Requisitos deste cartão**

- **RN-003** — Apenas administradores podem cadastrar, editar ou desativar médicos.
- **RN-016** — Todo cancelamento deve registrar o motivo.
- **RF-007** — O sistema deve permitir que administradores cadastrem, editem, consultem e desativem médicos.
- **RF-008** — O sistema deve permitir que administradores consultem os pacientes cadastrados.
- **RF-009** — O sistema deve permitir que administradores definam os dias e horários de atendimento dos médicos.
- **RF-010** — O sistema deve permitir o bloqueio de horários indisponíveis para atendimento.
- **RF-017** — O sistema deve permitir que administradores consultem os agendamentos realizados.
- **RF-018** — O sistema deve permitir que administradores cancelem ou reagendem consultas.
- **RF-022** — O sistema deve permitir que administradores consultem o histórico de agendamentos dos pacientes.
- **RF-023** — O sistema deve permitir a filtragem de agendamentos por período, médico ou status no painel administrativo.
- **RNF-008** — O painel administrativo deve apresentar interface responsiva para computadores e tablets.

**Links:** [openapi.yaml (contrato; tabela de erros no topo)](../api/openapi.yaml) · [frontend-agendamento](https://github.com/VictorKLing/frontend-agendamento)

<a id="fe-05"></a>

#### FE-05 — Tratar carregamento, lista vazia e erros no painel e no app

**Lista:** A fazer · **Responsável:** Victor · **Prazo (proposta):** 04/12 · **Depende de:** FE-02, FE-03, FE-04 · **Etiquetas:** Frontend, Mobile, Testes

**Pra quê.** Nenhuma tela fica travada ou em branco quando a API demora, devolve erro ou cai.

**O que já se sabe**

- O RNF-013 pede tratamento de falhas de comunicação com o backend.
- Os erros da API vêm em application/problem+json com a lista erros[campo, mensagem].
- O que cada código quer dizer está na tabela de erros do contrato.

**Entra:** carregando; lista vazia; sessão vencida, sem permissão, horário ocupado e erros de validação; falha de rede. **Fica de fora:** modo offline completo.

**Passos**

- [ ] Indicador de carregamento e botões desabilitados durante o envio
- [ ] Mensagem de lista vazia
- [ ] Sessão vencida leva ao login
- [ ] Sem permissão mostra um aviso
- [ ] Horário ocupado atualiza a disponibilidade e avisa
- [ ] Erros de validação aparecem ao lado do campo (erros[campo])
- [ ] Falha de rede permite tentar de novo

**Pronto quando**

- [ ] Com o backend desligado, painel e app mostram aviso e não quebram

**Requisitos deste cartão**

- **RNF-013** — O sistema deve possuir mecanismos de tratamento de falhas de comunicação com o backend.

**Links:** [openapi.yaml (contrato; tabela de erros no topo)](../api/openapi.yaml)

<a id="fe-06"></a>

#### FE-06 — Validar responsividade e acessibilidade básica

**Lista:** A fazer · **Responsável:** Victor (revisor: Luís) · **Prazo (proposta):** 04/12 · **Depende de:** FE-03, FE-04 · **Etiquetas:** Frontend, Mobile, Testes

**Pra quê.** Painel e app usáveis nos tamanhos de tela previstos e com o básico de acessibilidade.

**O que já se sabe**

- RNF-007 (app em diferentes tamanhos de celular) e RNF-008 (painel em computador e tablet).

**Entra:** tamanhos de tela; teclado; rótulos; contraste e foco. **Fica de fora:** auditoria completa de acessibilidade.

**Passos**

- [ ] App sem rolagem horizontal em 360 px
- [ ] Painel em 1280 px e em tablet
- [ ] Navegação por teclado nas ações principais do painel
- [ ] Campos com rótulo e mensagem de erro associada
- [ ] Contraste e foco visível conferidos
- [ ] Tabelas do painel viram cartões em tela estreita

**Pronto quando**

- [ ] Prints de celular, tablet e computador anexados ao cartão

**Requisitos deste cartão**

- **RNF-007** — O aplicativo mobile (React + Capacitor) deve oferecer interface adequada a diferentes tamanhos de tela de celulares.
- **RNF-008** — O painel administrativo deve apresentar interface responsiva para computadores e tablets.

<a id="fe-07"></a>

#### FE-07 — Implementar a área do médico

**Lista:** A fazer · **Responsável:** Victor · **Prazo (proposta):** 02/12 · **Depende de:** DEC-04, FE-02, BE-05, BE-09 · **Etiquetas:** Frontend

**Módulo do enunciado:** 2 — Agenda de profissionais

**Pra quê.** O médico entra com o Google, vê as consultas da agenda dele e cancela quando precisa, com motivo.

**O que já se sabe**

- O médico entra na v1 (DEC-02, 17/11). Onde fica a tela, no painel web ou no app, está no DEC-04 (proposta: painel).
- Rotas: GET /agendamentos/me (para o médico, devolve as consultas da própria agenda), GET /medicos/{id}/agenda, PATCH /agendamentos/{id}/cancelamento e GET /notificacoes/me. O medicoId vem do GET /auth/me.
- O médico não reagenda (DEC-03): quem remarca é o paciente ou o administrador.

**Entra:** consultas do dia e próximas; agenda semanal do médico; cancelar com motivo; caixa de entrada. **Fica de fora:** reagendar; editar a própria agenda (quem define é o administrador, RF-009); prontuário.

**Passos**

- [ ] Fazer a tela onde o DEC-04 decidir (painel ou app)
- [ ] Consultas do dia e próximas (GET /agendamentos/me)
- [ ] Agenda semanal do médico (GET /medicos/{id}/agenda)
- [ ] Cancelar consulta com motivo obrigatório
- [ ] Caixa de entrada de notificações

**Pronto quando**

- [ ] O médico vê só as consultas da agenda dele
- [ ] Sem motivo, o cancelamento não é enviado

**Requisitos deste cartão**

- **RN-016** — Todo cancelamento deve registrar o motivo.
- **RF-029** — O sistema deve permitir que médicos consultem a própria agenda e as consultas marcadas com eles.
- **RF-030** — O sistema deve permitir que médicos cancelem consultas da própria agenda, informando o motivo.

**Links:** [openapi.yaml (contrato; tabela de erros no topo)](../api/openapi.yaml) · [requisitos/REQUISITOS.md](../requisitos/REQUISITOS.md)

<a id="qa-01"></a>

#### QA-01 — Executar o roteiro de aceite da versão 1

**Lista:** A fazer · **Responsável:** Todos · **Prazo (proposta):** 05/12 · **Depende de:** INT-01 · **Etiquetas:** Testes

**Pra quê.** Conferir, com evidência, que cada requisito da versão 1 funciona no ambiente publicado.

**O que já se sabe**

- A tabela de rastreabilidade deste backlog liga cada requisito aos cartões.
- O roteiro roda no ambiente de produção (DB-04 e BE-08), com dados criados pela própria aplicação.

**Entra:** roteiro por requisito; medição de tempo de resposta; evidências. **Fica de fora:** teste de segurança aprofundado.

**Passos**

- [ ] Login com Google de paciente, médico e administrador
- [ ] Cadastro de médico, agenda e bloqueio pelo administrador
- [ ] Agendamento, cancelamento e reagendamento, com o prazo de 24 horas e o motivo
- [ ] Área do médico
- [ ] Histórico e filtros administrativos
- [ ] Notificações: caixa de entrada, e-mail com convite e falha simulada de envio
- [ ] Autorização e isolamento de dados entre pacientes
- [ ] Tempo de horarios-disponiveis abaixo de 3 segundos
- [ ] Teste simples com 50 usuários simultâneos — opcional
- [ ] Salvar as evidências (prints e saídas) no repositório de docs

**Pronto quando**

- [ ] Todo requisito da v1 tem resultado registrado: passou, falhou ou fora do escopo
- [ ] Falhas viraram cartão com responsável

**Requisitos deste cartão**

- **RNF-005** — As consultas de disponibilidade devem apresentar respostas em até 3 segundos em condições normais de utilização.
- **RNF-006** — O sistema deve suportar, inicialmente, pelo menos 50 usuários simultâneos sem perda de funcionalidades.
- **RNF-018** — As funcionalidades críticas de autenticação e agendamento devem possuir testes automatizados.

**Links:** [organizacao/BACKLOG.md](../organizacao/BACKLOG.md) · [requisitos/REQUISITOS.md](../requisitos/REQUISITOS.md)

<a id="doc-01"></a>

#### DOC-01 — Atualizar a documentação final

**Lista:** A fazer · **Responsável:** Luís (apoio: todos) · **Prazo (proposta):** 06/12 · **Depende de:** QA-01 · **Etiquetas:** Documentação

**Pra quê.** A documentação entregue descreve o sistema que foi entregue, não o planejado.

**O que já se sabe**

- Tudo fica no repositório agendamentos-sa-docs.
- O contrato marca com x-status o que está implementado; no fim, nada pode ficar como planejado sem estar fora do escopo.

**Entra:** requisitos; arquitetura; banco; contrato; ambientes; READMEs dos repositórios. **Fica de fora:** manual do usuário final.

**Passos**

- [ ] Requisitos finais sem marcas de proposta
- [ ] Diagrama e dicionário conferidos com o banco de produção
- [ ] openapi.yaml: tudo implementado ou explicitamente fora do escopo
- [ ] Arquitetura com as pastas reais do backend, do painel e do app
- [ ] Justificativa do conceito distribuído (DIST-01)
- [ ] AMBIENTES.md com as URLs publicadas e sem segredos
- [ ] READMEs do backend, do painel e do app com instalação e usuários de demonstração
- [ ] README do repositório de docs com o índice final

**Pronto quando**

- [ ] Outra pessoa do grupo consegue subir o sistema só lendo os READMEs
- [ ] Nenhum documento cita o Drive como fonte atual

**Requisitos deste cartão**

- **RNF-014** — O código-fonte deve seguir uma organização modular e padrões de desenvolvimento definidos pela equipe.

**Links:** [README.md](../README.md)

<a id="apr-01"></a>

#### APR-01 — Preparar a apresentação e as respostas técnicas individuais

**Lista:** A fazer · **Responsável:** Todos (coordenação: Luís) · **Prazo (proposta):** 07/12 · **Depende de:** QA-01, DOC-01 · **Etiquetas:** Apresentação, Documentação, Prioridade alta

**Pra quê.** Entregar a SA no AVA no prazo e apresentar com cada integrante respondendo pela própria parte.

**O que já se sabe**

- A tarefa “Desenvolvimento SA agenda de consulta” (Web) vence em 08/12/2026 às 00:00, então o envio precisa sair até 07/12 às 23:59, e só existe 1 tentativa.
- Em Distribuídos, a apresentação de 03/11 teve perguntas técnicas individuais; o mesmo deve acontecer na final.

**Entra:** roteiro da demonstração; slides; preparação individual; plano B; envio no AVA. **Fica de fora:** novas funcionalidades depois de 05/12.

**Passos**

- [ ] Roteiro da demonstração: entrar com Google → agenda → agendar → e-mail com convite → cancelar com motivo → notificação
- [ ] Dados da apresentação criados pela própria aplicação em produção (não usar o perfil dev)
- [ ] Slides: problema, requisitos, arquitetura, banco, contrato e conceito distribuído
- [ ] Luís prepara: modelo de dados, restrições, concorrência, Flyway, banco na nuvem, publicação e notificações assíncronas
- [ ] Yuri prepara: login com Google, JWT, agendamentos e notificações por e-mail
- [ ] Pierre prepara: médicos, agenda, horários disponíveis, histórico e lock
- [ ] Victor prepara: painel, integração e tratamento de erros
- [ ] Victor prepara: Capacitor, APK e consumo da API
- [ ] Ensaio com cronômetro
- [ ] Plano B: vídeo da demonstração e backend local com dados de demonstração
- [ ] Conferir o que o envio no AVA pede e enviar uma única vez até 07/12 às 23:59

**Pronto quando**

- [ ] Envio feito no AVA antes do prazo
- [ ] Cada integrante explica a própria parte e o fluxo completo sem ler

**Links:** [README.md](../README.md)

### Em andamento

<a id="db-02"></a>

#### DB-02 — Validar as migrações no PostgreSQL

**Lista:** Em andamento · **Responsável:** Luís (apoio: Yuri ou Pierre) · **Prazo (proposta):** 20/11 · **Depende de:** — · **Etiquetas:** Banco de dados, Backend, Testes, Prioridade alta

**Pra quê.** Provar no banco real que as restrições seguram as regras críticas.

**O que já se sabe**

- Segundo o Luís, a V1 rodou no PostgreSQL do Yuri.
- O script validacao_restricoes.sql testa as restrições numa transação e desfaz tudo no fim.
- Em 18/11 ele foi ajustado à V4 e passou inteiro num PostgreSQL 18.7 local (o portátil do scripts/demo-local.ps1), com V1 a V4 e os dados de demonstração.
- A V4 também foi aplicada sobre um banco com os dados antigos (janelas de 20 minutos e um usuário RECEPCIONISTA) e ajustou as linhas sem erro.
- Concorrência real precisa de duas conexões, com roteiro manual no fim do script.

**Entra:** banco vazio local; banco de produção depois do DB-04; roteiro manual de concorrência. **Fica de fora:** teste de carga (QA-01).

**Passos**

- [x] V1 aplicada no PostgreSQL do Yuri (relatado pelo Luís)
- [ ] Confirmar se V2 e V3 também foram aplicadas (tabela flyway_schema_history) — a confirmar
- [x] Ajustar validacao_restricoes.sql à V4 (18/11)
- [x] Aplicar V1 a V4 num banco vazio e rodar validacao_restricoes.sql: tudo OK (18/11)
- [x] Subir o backend com ddl-auto=validate depois da V4 (perfil dev, 18/11)
- [ ] Rodar o roteiro de concorrência: duas conexões, mesmo médico e horário
- [ ] Reiniciar o backend e confirmar que o Flyway não reaplica nada
- [ ] Repetir o script no banco de produção depois do DB-04
- [ ] Anexar as evidências no cartão

**Pronto quando**

- [ ] Script termina sem nenhuma linha FALHOU
- [ ] E-mail repetido (com maiúsculas diferentes), CRM/UF repetido e consultas sobrepostas são rejeitados pelo banco
- [ ] Na concorrência, uma conexão grava e a outra recebe exclusion_violation

**Requisitos deste cartão**

- **RN-004** — Um médico não pode possuir dois agendamentos ativos que ocupem o mesmo intervalo de atendimento.
- **RNF-011** — As informações devem ser armazenadas em banco de dados persistente.
- **RNF-012** — O sistema deve preservar a consistência dos agendamentos em operações simultâneas.
- **RNF-018** — As funcionalidades críticas de autenticação e agendamento devem possuir testes automatizados.

**Links:** [banco-de-dados/validacao_restricoes.sql](../banco-de-dados/validacao_restricoes.sql) · [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md)

<a id="db-04"></a>

#### DB-04 — Criar o banco de produção na nuvem

**Lista:** Em andamento · **Responsável:** Luís · **Prazo (proposta):** 28/11 · **Depende de:** DB-02 · **Etiquetas:** Banco de dados, Prioridade alta

**Pra quê.** Ter um PostgreSQL gerenciado que será o banco oficial do sistema publicado e da apresentação.

**O que já se sabe**

- Cada integrante testa no PostgreSQL local dele; produção é uma só, criada pelo Luís no Neon (PostgreSQL gerenciado, plano gratuito).
- As tabelas são criadas pelo Flyway do backend no primeiro start, nunca à mão.
- O application.yaml lê DB_HOST, DB_PORT, DB_NAME, DB_USERNAME e DB_PASSWORD.

**Entra:** projeto no Neon; banco agenda_sa com a extensão btree_gist (criada pela V1); conexão com SSL; guia em banco-de-dados/AMBIENTES.md. **Fica de fora:** dados de demonstração (o perfil dev nunca roda em produção); plano pago, réplica ou backup extra.

**Passos**

- [ ] Criar o projeto no Neon na mesma região do backend no Render (proposta: AWS US East, Virginia; o Render não tem São Paulo)
- [ ] Criar o banco agenda_sa e guardar host, usuário e senha fora do repositório
- [x] Definir a conexão com SSL: spring.datasource.url com sslmode=require no .env de produção (AMBIENTES.md)
- [ ] Subir o backend uma vez apontando para a nuvem, sem o perfil dev, para o Flyway aplicar V1 a V4
- [ ] Conferir flyway_schema_history (quatro versões com sucesso) e a extensão btree_gist
- [ ] Rodar validacao_restricoes.sql na nuvem (ele desfaz tudo no fim)
- [ ] Criar o administrador inicial no SQL Editor do Neon só com nome e o e-mail Google dele, sem senha (V4): no primeiro login com o Google o sistema o reconhece
- [ ] Combinar quem recebe as credenciais e por qual canal (nunca no Git nem no Trello)
- [x] Escrever banco-de-dados/AMBIENTES.md: local x produção, variáveis e cuidados

**Pronto quando**

- [ ] O backend sobe contra a nuvem com ddl-auto=validate sem erro
- [ ] Nenhuma senha ou string de conexão no Git, no Trello ou na documentação
- [ ] Produção sem dados de demonstração
- [ ] A conexão usa SSL

**Requisitos deste cartão**

- **RNF-001** — Toda comunicação entre as interfaces e o backend publicado deve utilizar HTTPS. No desenvolvimento local, HTTP é aceito.
- **RNF-011** — As informações devem ser armazenadas em banco de dados persistente.
- **RNF-015** — O tratamento dos dados pessoais deve observar os requisitos aplicáveis da LGPD.

**Links:** [banco-de-dados/AMBIENTES.md](../banco-de-dados/AMBIENTES.md) · [banco-de-dados/validacao_restricoes.sql](../banco-de-dados/validacao_restricoes.sql)

<a id="api-01"></a>

#### API-01 — Revisar e congelar o contrato OpenAPI v1

**Lista:** Em andamento · **Responsável:** Luís (revisores: Yuri, Pierre e Victor) · **Prazo (proposta):** 20/11 · **Depende de:** DEC-02, DEC-03 · **Etiquetas:** Contrato API, Prioridade alta

**Pra quê.** Backend, painel e app trabalham pelo mesmo contrato.

**O que já se sabe**

- openapi.yaml 1.4.0 (18 e 21/11): fica o GET /auth/me para o próprio cadastro (sai o GET /usuarios/me) e o PATCH /usuarios/me muda só o nome; a lista de pacientes é GET /usuarios?perfil=PACIENTE; a hora volta sempre como HH:mm:ss; e no topo entrou a tabela única de códigos de erro, depois que o Pierre achou o Trello diferente do contrato (21/11).
- Validada com Redocly sem erros.
- A 1.3.0 (18/11) trouxe as decisões do DEC-02 e do DEC-03: novo POST /auth/google; POST /auth/login só no perfil dev; saem /auth/cadastro e /auth/recuperacao-senha; perfil RECEPCIONISTA fora; médico com e-mail; janelas de 30 a 60 minutos; regras de cancelamento e reagendamento escritas nas rotas.
- A 1.2.0 (16/11) acompanhou o master com JWT.
- Paginação e erros seguem o que o código devolve hoje (ProblemDetail com a lista erros[campo, mensagem]).
- A 1.3.0 foi validada com Redocly sem erros.

**Entra:** todas as rotas /api/v1; schemas e exemplos; códigos de erro; marcação x-status. **Fica de fora:** o processo interno de envio de notificações (DIST-01).

**Passos**

- [x] Alinhar /usuarios e a agenda ao código (master e PR #2) e validar com Redocly (1.1.0)
- [x] Alinhar ao login JWT e à V3 do master (1.2.0, 16/11)
- [x] Aplicar as decisões do DEC-02 e do DEC-03 e validar com Redocly (1.3.0, 18/11)
- [ ] Yuri confere autenticação, usuários e médicos
- [ ] Pierre confere agenda, agendamentos e notificações
- [ ] Victor confere se as telas têm todos os campos de que precisam
- [x] POST /usuarios passa a exigir ADMIN (decidido no código do JWT, 15/11)
- [x] Próprio cadastro: lê no GET /auth/me (sai o GET /usuarios/me) e o PATCH /usuarios/me muda só o nome (Luís, 18 e 21/11; 1.4.0)
- [x] Lista de pacientes do administrador: GET /usuarios?perfil=PACIENTE (Luís, 18/11; 1.4.0)
- [x] Hora: a API aceita HH:mm e HH:mm:ss e responde HH:mm:ss (Luís, 18/11; 1.4.0)
- [x] Tabela única de códigos de erro no topo do contrato; médico inativo é 409 em todo lugar; rotas planejadas com 400, 401 e 403 (Luís, 21/11; 1.4.0)
- [ ] Congelar a versão e registrar a data no arquivo

**Pronto quando**

- [ ] Cada rota planejada tem um cartão de backend que a implementa
- [ ] Depois de congelado, mudança só por PR no repositório de docs, com aviso no grupo
- [ ] Erros em application/problem+json, com o código da tabela de erros do contrato

**Requisitos deste cartão**

- **RNF-009** — O sistema deve utilizar APIs REST para comunicação entre os componentes.
- **RNF-010** — O backend deve permitir a separação das responsabilidades de autenticação, cadastro, agenda e agendamento.
- **RNF-017** — As APIs devem utilizar JSON como formato padrão para troca de dados.

**Links:** [openapi.yaml (contrato; tabela de erros no topo)](../api/openapi.yaml)

<a id="be-01"></a>

#### BE-01 — Completar a base do backend e o ambiente local

**Lista:** Em andamento · **Responsável:** Yuri e Pierre · **Prazo (proposta):** 20/11 · **Depende de:** — · **Etiquetas:** Backend, Banco de dados

**Pra quê.** Qualquer integrante clona, preenche o .env e sobe o backend em poucos minutos.

**O que já se sabe**

- Na master já existem Spring Boot 4.1.2 (Java 21), Flyway com V1 a V3, ddl-auto=validate, leitura do .env e .env no .gitignore, e o CORS do painel (entrou com o JWT em 15/11).
- Faltam PostgreSQL em container, .env.example, README de execução e a origem do app no CORS.

**Entra:** docker-compose com PostgreSQL 16 ou superior; .env.example; README de execução; CORS para painel e app; perfis dev e padrão. **Fica de fora:** publicação do backend (BE-08).

**Passos**

- [x] Projeto Spring Boot com JPA, Flyway, Validation e Security
- [x] V1 a V3 em db/migration e ddl-auto=validate
- [x] Variáveis lidas do .env, que está no .gitignore
- [ ] Criar docker-compose.yml com PostgreSQL 16+ e volume
- [ ] Criar .env.example com DB_HOST, DB_PORT, DB_NAME, DB_USERNAME, DB_PASSWORD, SERVER_PORT, JWT_SECRET, CORS_ALLOWED_ORIGINS e, para o login com Google e o e-mail, GOOGLE_CLIENT_ID e BREVO_API_KEY (nomes a combinar com o Yuri)
- [x] CORS do painel: localhost:5173 e 4173, configurável por CORS_ALLOWED_ORIGINS (15/11)
- [ ] Incluir no CORS a origem do app Capacitor no Android (conferir qual é)
- [ ] Escrever o README: requisitos, .env, docker compose up, ./mvnw spring-boot:run, perfil dev
- [ ] Incluir Swagger UI (springdoc) para testar as rotas — opcional

**Pronto quando**

- [ ] Clone limpo + .env + docker compose up + ./mvnw spring-boot:run sobe sem erro
- [ ] Flyway aplica V1 a V3 num banco vazio
- [ ] O painel rodando local não é barrado por CORS

**Requisitos deste cartão**

- **RNF-009** — O sistema deve utilizar APIs REST para comunicação entre os componentes.
- **RNF-010** — O backend deve permitir a separação das responsabilidades de autenticação, cadastro, agenda e agendamento.
- **RNF-011** — As informações devem ser armazenadas em banco de dados persistente.
- **RNF-014** — O código-fonte deve seguir uma organização modular e padrões de desenvolvimento definidos pela equipe.

**Links:** [backend](https://github.com/faculdade-ads-senai/agendamentos-sa-backend) · [banco-de-dados/AMBIENTES.md](../banco-de-dados/AMBIENTES.md) · [arquitetura/ARQUITETURA.md](../arquitetura/ARQUITETURA.md)

<a id="be-02"></a>

#### BE-02 — Implementar o login com Google e o perfil do usuário

**Lista:** Em andamento · **Responsável:** Yuri · **Prazo (proposta):** 22/11 · **Depende de:** BE-01, INF-01, V4 (DB-01) · **Etiquetas:** Backend, Prioridade alta

**Módulo do enunciado:** 1 — Cadastro e autenticação

**Pra quê.** Todo mundo entra com a conta Google; o backend confere o token do Google e devolve o JWT do sistema, com o perfil.

**O que já se sabe**

- Desde 15/11 a master tem login com JWT (POST /auth/login, token de 1 hora), GET /auth/me, API sem estado e todo o CRUD /api/v1/usuarios restrito a ADMIN; a V3 voltou o perfil de ADMINISTRADOR para ADMIN. O guia está no AUTENTICACAO.md do backend.
- Em 17/11 o grupo decidiu: login só pelo Google, para todos (DEC-02). O JWT do Yuri continua; muda só a porta de entrada. O POST /auth/login com senha vira o login de teste, só no perfil dev, para os usuários de demonstração.
- Como achar o usuário: primeiro pelo google_id; depois pelo e-mail (administradores e médicos são cadastrados antes) e grava o google_id; se não achar, cria um PACIENTE. A V4 (DB-01) traz google_id, senha opcional e o perfil RECEPCIONISTA fora.
- Sem cadastro com senha (/auth/cadastro saiu) e sem recuperação de senha (RF-004 fora da v1). Os IDs de cliente do Google saem do INF-01 (Luís).

**Entra:** POST /auth/google; JWT do sistema; login de teste só no perfil dev; GET /auth/me e PATCH /usuarios/me; filtro ?perfil= no GET /usuarios; autorização por perfil (ADMIN, PACIENTE e MEDICO); medicoId no /auth/me para o médico. **Fica de fora:** senha no ambiente publicado; recuperação de senha (RF-004 fora da v1); cadastro de médico (BE-03).

**Passos**

- [x] CRUD de usuários em /api/v1/usuarios com hash BCrypt
- [x] Login com JWT de 1 hora, filtro JWT, SecurityConfig sem estado, CRUD /usuarios só para ADMIN e GET /auth/me (15/11)
- [x] Perfil do administrador como ADMIN (V3) e x-status de /auth/login e /auth/me no contrato (1.2.0)
- [ ] POST /auth/google: conferir o idToken com a biblioteca do Google (assinatura, emissor, validade e público = IDs de cliente do INF-01)
- [ ] Achar o usuário pelo google_id, depois pelo e-mail (gravando o google_id); senão, criar PACIENTE
- [ ] Deixar POST /auth/login só no perfil dev (login de teste)
- [ ] Tirar RECEPCIONISTA do enum Perfil e tratar MEDICO nas regras de acesso (V4)
- [ ] Incluir medicoId na resposta do /auth/me para o perfil MEDICO
- [ ] PATCH /usuarios/me para o próprio cadastro (a leitura é o GET /auth/me; API-01, 18/11)
- [ ] Filtro ?perfil= no GET /usuarios: a lista de pacientes do administrador é ?perfil=PACIENTE (RF-008)
- [ ] Testes: token do Google inválido ou de outro projeto, sem token, perfil sem permissão
- [ ] Atualizar x-status no openapi.yaml

**Pronto quando**

- [ ] Sem token, ou paciente em rota de administrador: recusado com o código da tabela de erros do contrato
- [ ] Token do Google vencido ou de outro projeto é recusado
- [ ] No perfil publicado, POST /auth/login não existe
- [ ] Usuário desativado não consegue entrar
- [ ] Paciente só lê e altera os próprios dados

**Requisitos deste cartão**

- **RN-001** — Cada paciente deve possuir um cadastro individual no sistema.
- **RN-002** — Apenas usuários autenticados podem realizar agendamentos.
- **RN-009** — Pacientes devem visualizar apenas seus próprios agendamentos e informações pessoais.
- **RF-001** — O sistema deve permitir o cadastro de novos pacientes. O cadastro acontece no primeiro login com a conta Google.
- **RF-002** — O sistema deve permitir a autenticação por meio da conta Google.
- **RF-003** — O sistema deve permitir que pacientes consultem e atualizem seus dados cadastrais.
- **RF-005** — O sistema deve permitir o encerramento da sessão do usuário.
- **RF-006** — O sistema deve identificar o perfil do usuário e disponibilizar as funcionalidades correspondentes.
- **RF-008** — O sistema deve permitir que administradores consultem os pacientes cadastrados.
- **RNF-002** — O sistema não deve armazenar senhas: a autenticação é feita pela conta Google, e o backend confere o token do Google antes de emitir o próprio token de acesso. As senhas dos usuários de demonstração do ambiente de desenvolvimento usam hash BCrypt.
- **RNF-003** — As funcionalidades protegidas devem exigir autenticação válida.
- **RNF-004** — O sistema deve implementar controle de acesso baseado nos perfis de paciente, médico e administrador.
- **RNF-018** — As funcionalidades críticas de autenticação e agendamento devem possuir testes automatizados.

**Links:** [openapi.yaml (contrato; tabela de erros no topo)](../api/openapi.yaml) · [MODELO_DADOS.md (Login com Google)](../banco-de-dados/MODELO_DADOS.md) · [API-USUARIOS.md](https://github.com/faculdade-ads-senai/agendamentos-sa-backend/blob/master/API-USUARIOS.md) · [AUTENTICACAO.md](https://github.com/faculdade-ads-senai/agendamentos-sa-backend/blob/master/AUTENTICACAO.md)

<a id="be-04"></a>

#### BE-04 — Concluir agenda e bloqueios (branch feature/api-agendas)

**Lista:** Em andamento · **Responsável:** Pierre · **Prazo (proposta):** 19/11 · **Depende de:** API-01 · **Etiquetas:** Backend

**Módulo do enunciado:** 2 — Agenda de profissionais

**Pra quê.** Administrador define a agenda semanal e os bloqueios; qualquer usuário consulta os horários livres.

**O que já se sabe**

- O código já existe: commit do Pierre de 02/11 na branch feature/api-agendas (23 arquivos, cerca de 1.270 linhas, com três classes de teste). Tem GET e PUT /medicos/{id}/agenda, GET, POST e DELETE de bloqueios e GET horarios-disponiveis, usando lock no médico.
- O PR #2 foi fechado sem merge pelo Yuri em 15/11: antes de aceitar um PR, o autor apresenta e explica a implementação ao grupo. Em 16/11 o repositório do backend foi recriado na organização faculdade-ads-senai; as páginas dos PRs se perderam, mas a branch foi preservada.
- A branch está atrás da master: precisa receber o JWT, a V3 e, quando entrar, a V4. A revisão de banco não achou problema de mapeamento; há três ajustes pequenos.
- Decisão de 17/11: a consulta dura de 30 a 60 minutos, definida pelo médico em cada janela. Hoje o código aceita a partir de 5.

**Entra:** rotas de agenda, bloqueios e horários disponíveis; geração de horários pela duração da janela; exclusão de horários ocupados e bloqueados. **Fica de fora:** criação de agendamentos (BE-05).

**Passos**

- [x] Entidades AgendaMedico e BloqueioAgenda e consulta de ocupação
- [x] Rotas de agenda, bloqueios e horários disponíveis
- [ ] Atualizar a branch feature/api-agendas com o master (JWT, V3 e V4)
- [ ] Trocar a validação da duração para 30 a 60 minutos (V4)
- [ ] Apresentar e explicar a implementação ao grupo (regra para aceitar PR)
- [ ] Abrir um PR novo da branch feature/api-agendas no repositório agendamentos-sa-backend
- [ ] Tirar o comentário //sale do Application.java
- [ ] Padronizar o pacote das entidades (usuarios usa model; agendas e medicos usam entity)
- [ ] Testar as rotas no Postman ou Insomnia com os dados de demonstração (DB-03)
- [x] PR #1 (teste) fechado pelo Yuri em 15/11
- [ ] Fazer o merge na master

**Pronto quando**

- [ ] Janela inválida, sobreposta ou com duração fora de 30 a 60 minutos é recusada com o código do contrato
- [ ] Horário bloqueado ou ocupado não aparece em horarios-disponiveis
- [ ] horarios-disponiveis responde em até 3 segundos com os dados de demonstração

**Requisitos deste cartão**

- **RN-005** — Consultas devem ser agendadas somente em horários definidos como disponíveis.
- **RN-017** — A duração das consultas é definida pelo médico em cada janela de atendimento, entre 30 e 60 minutos.
- **RF-009** — O sistema deve permitir que administradores definam os dias e horários de atendimento dos médicos.
- **RF-010** — O sistema deve permitir o bloqueio de horários indisponíveis para atendimento.
- **RF-011** — O sistema deve permitir a consulta dos horários disponíveis de cada médico.
- **RF-012** — O sistema deve atualizar a disponibilidade dos horários após a confirmação, cancelamento ou reagendamento de consultas.
- **RNF-005** — As consultas de disponibilidade devem apresentar respostas em até 3 segundos em condições normais de utilização.
- **RNF-012** — O sistema deve preservar a consistência dos agendamentos em operações simultâneas.

**Links:** [branch feature/api-agendas](https://github.com/faculdade-ads-senai/agendamentos-sa-backend/tree/feature/api-agendas) · [openapi.yaml (contrato; tabela de erros no topo)](../api/openapi.yaml)

<a id="fe-01w"></a>

#### FE-01W — Estruturar a base do painel web administrativo

**Lista:** Em andamento · **Responsável:** Victor · **Prazo (proposta):** 20/11 · **Depende de:** API-01 · **Etiquetas:** Frontend, Prioridade alta

**Pra quê.** Ter a estrutura do painel pronta para receber as telas do administrador.

**O que já se sabe**

- Repositório VictorKLing/frontend-agendamento: Vite 7, React 19 e Tailwind 4 em JavaScript, com tela de login (main.jsx) e cliente HTTP (api.jsx).
- Em 15/11 o Yuri ligou o painel ao JWT: login em /auth/login, sessão no sessionStorage restaurada por /auth/me, volta ao login quando a sessão vence e CRUD de usuários para ADMIN (users/Users.jsx).
- A URL da API vem de VITE_API_BASE_URL ou do proxy /api do Vite.

**Entra:** rotas; layout do painel; cliente HTTP central; componentes reaproveitáveis. **Fica de fora:** telas do paciente (vão para o app).

**Passos**

- [x] Projeto Vite + React + Tailwind
- [x] Tela de login e criação de conta integrada ao backend
- [ ] Decidir JavaScript ou TypeScript (a arquitetura do Drive tem as duas versões) — a confirmar
- [ ] React Router com rotas públicas e de administrador
- [ ] Layout do painel: menu lateral, cabeçalho e área de conteúdo
- [x] Cliente HTTP central com o token JWT e a URL em VITE_API_BASE_URL ou no proxy /api (15/11)
- [x] Guardar a sessão e voltar ao login quando ela vence (15/11)
- [ ] Componentes de UI: botão, campo, tabela, modal, carregando, lista vazia

**Pronto quando**

- [ ] Painel usável em computador e tablet
- [ ] Trocar a URL da API não exige mudar código

**Requisitos deste cartão**

- **RNF-008** — O painel administrativo deve apresentar interface responsiva para computadores e tablets.
- **RNF-009** — O sistema deve utilizar APIs REST para comunicação entre os componentes.
- **RNF-014** — O código-fonte deve seguir uma organização modular e padrões de desenvolvimento definidos pela equipe.

**Links:** [frontend-agendamento](https://github.com/VictorKLing/frontend-agendamento) · [arquitetura/ARQUITETURA.md](../arquitetura/ARQUITETURA.md)

<a id="fe-02"></a>

#### FE-02 — Implementar o login com Google no painel e no app

**Lista:** Em andamento · **Responsável:** Victor · **Prazo (proposta):** 25/11 · **Depende de:** BE-02, FE-01W, FE-01M, INF-01 · **Etiquetas:** Frontend, Mobile

**Módulo do enunciado:** 1 — Cadastro e autenticação

**Pra quê.** Entrar com Google e sair funcionando nos dois clientes, cada um só para os perfis dele.

**O que já se sabe**

- Desde 15/11 o painel entra por POST /auth/login com JWT (feito pelo Yuri junto com o BE-02).
- Decisão de 17/11 (DEC-02): o login é só pelo Google. O cliente faz o login do Google, recebe o idToken e manda para POST /auth/google; a resposta é o mesmo JWT de hoje. O cadastro do paciente acontece sozinho no primeiro login, então não há tela de cadastro.
- No painel, o botão vem da biblioteca do Google para a web (Google Identity Services). No app, de um plugin de login Google para o Capacitor, com o ID de cliente Android (INF-01).
- O login com e-mail e senha continua só no modo de desenvolvimento, para os usuários de demonstração.

**Entra:** botão “Entrar com Google” no painel e no app; logout; proteção de rotas por perfil; mensagens de erro. **Fica de fora:** tela de cadastro com senha; recuperação de senha (RF-004 fora da v1).

**Passos**

- [x] Tela de login e criação de conta no painel (login padrão do Spring)
- [x] Trocar o painel para POST /auth/login com JWT (15/11)
- [ ] Botão “Entrar com Google” no painel, mandando o idToken para POST /auth/google
- [ ] Login com Google no app, com o plugin do Capacitor e o ID de cliente Android
- [ ] Deixar o login com e-mail e senha só no modo de desenvolvimento
- [ ] Logout limpando o token nos dois clientes
- [ ] Painel aceita ADMIN (e MEDICO, se o DEC-04 puser a tela do médico no painel); app aceita PACIENTE
- [ ] Mensagens de erro sem detalhes internos

**Pronto quando**

- [ ] Paciente não entra no painel; administrador não entra no app
- [ ] Depois do logout, voltar no navegador não mostra dados
- [ ] O login com Google funciona no APK instalado no celular

**Requisitos deste cartão**

- **RF-001** — O sistema deve permitir o cadastro de novos pacientes. O cadastro acontece no primeiro login com a conta Google.
- **RF-002** — O sistema deve permitir a autenticação por meio da conta Google.
- **RF-005** — O sistema deve permitir o encerramento da sessão do usuário.
- **RF-006** — O sistema deve identificar o perfil do usuário e disponibilizar as funcionalidades correspondentes.
- **RNF-003** — As funcionalidades protegidas devem exigir autenticação válida.

**Links:** [frontend-agendamento](https://github.com/VictorKLing/frontend-agendamento) · [openapi.yaml (contrato; tabela de erros no topo)](../api/openapi.yaml)

<a id="int-01"></a>

#### INT-01 — Integrar painel e app com o backend pelo contrato v1

**Lista:** Em andamento · **Responsável:** Victor, Yuri e Pierre (coordenação: Luís) · **Prazo (proposta):** 04/12 · **Depende de:** BE-02 a BE-06, FE-02 a FE-05 · **Etiquetas:** Integração, Prioridade alta

**Pra quê.** Os dois clientes funcionam de ponta a ponta com o backend, sem divergência do contrato.

**O que já se sabe**

- A primeira integração (criar conta e login no painel) foi feita pelo Victor; em 15/11 o Yuri ligou o painel ao login JWT e ao CRUD de usuários.
- Uma coleção do Postman ou Insomnia serve para testar e para a apresentação, que em Distribuídos foi feita assim em 03/11.

**Entra:** coleção de requisições; conferência tela x contrato; fuso horário; CORS e autenticação local e publicada. **Fica de fora:** novas funcionalidades.

**Passos**

- [x] Primeira integração: criar conta e login no painel
- [x] Login JWT e CRUD de usuários do painel ligados ao backend (15/11)
- [ ] Coleção do Postman ou Insomnia com todas as rotas e exemplos
- [ ] Conferir cada tela contra o openapi.yaml
- [ ] Datas enviadas com fuso e exibidas em America/Sao_Paulo
- [ ] CORS e JWT funcionando local e publicado
- [ ] Fluxo ponta a ponta do paciente no app
- [ ] Fluxo ponta a ponta do administrador no painel
- [ ] Registrar cada divergência como cartão ou issue

**Pronto quando**

- [ ] Nenhum endpoint depende de interpretação diferente do contrato
- [ ] Fluxos de paciente e administrador funcionam com o backend publicado

**Requisitos deste cartão**

- **RNF-001** — Toda comunicação entre as interfaces e o backend publicado deve utilizar HTTPS. No desenvolvimento local, HTTP é aceito.
- **RNF-009** — O sistema deve utilizar APIs REST para comunicação entre os componentes.
- **RNF-017** — As APIs devem utilizar JSON como formato padrão para troca de dados.

**Links:** [openapi.yaml (contrato; tabela de erros no topo)](../api/openapi.yaml)

### Em revisão (PR aberto)

<a id="db-01"></a>

#### DB-01 — Revisar e aprovar o modelo de dados (V1 a V4)

**Lista:** Em revisão (PR aberto) · **Responsável:** Luís (revisores: Yuri e Pierre) · **Prazo (proposta):** 20/11 · **Depende de:** DEC-02 · **Etiquetas:** Banco de dados, Prioridade alta

**Pra quê.** Congelar tabelas, colunas, perfis e status da versão 1.

**O que já se sabe**

- A V1 (estrutura), a V2 (perfis) e a V3 (ADMINISTRADOR volta a ser ADMIN, 15/11) estão na master do backend.
- Em 18/11 o Luís escreveu a V4 com as decisões de 17/11: google_id e senha opcional no usuário, perfil RECEPCIONISTA fora, médico ligado a um usuário, duração de 30 a 60 minutos e motivo obrigatório no cancelamento.
- A V4 está no PR #1 do backend (branch feature/v4-decisoes-dec02-dec03, aberto em 18/11); a revisão do Yuri e do Pierre acontece nesse PR.
- Antes de abrir, o backend subiu com a V4 no perfil dev: Flyway e ddl-auto=validate sem erro, e login de administrador e de médico de demonstração funcionando.
- A modelagem (versão 1.2) documenta tudo: diagrama, dicionário, restrições, gatilhos e o conceito distribuído.

**Entra:** usuario, medico, agenda_medico, bloqueio_agenda, agendamento e notificacao; perfis e status; restrições de exclusão e gatilhos de atualizado_em; V4. **Fica de fora:** prontuário e dados clínicos; unidades de saúde.

**Passos**

- [x] Atualizar MODELO_DADOS.md para a versão 1.1 (V2, perfis, decisões, notificações assíncronas)
- [x] Registrar a V3 (perfil ADMIN) no MODELO_DADOS.md (16/11)
- [x] Escrever a V4 com as decisões de 17/11 e testar num PostgreSQL 18.7 (18/11)
- [x] Atualizar MODELO_DADOS.md para a versão 1.2, com a V4 (18/11)
- [x] Abrir o PR da V4 no backend (PR #1, 18/11)
- [ ] Explicar a V4 ao grupo (regra para aceitar PR)
- [ ] Yuri confere usuario e perfis contra as classes Usuario e Perfil (tirar RECEPCIONISTA do enum)
- [ ] Pierre confere medico, agenda_medico e bloqueio_agenda contra a branch feature/api-agendas
- [ ] Conferir agendamento e notificacao contra as rotas planejadas do contrato
- [ ] Decidir se entra numa V5 o índice único parcial em agenda_medico (opcional)
- [ ] Registrar no documento a data de congelamento

**Pronto quando**

- [ ] Diagrama e dicionário batem com V1 a V4
- [ ] PR #1 revisado pelo Yuri ou pelo Pierre e com merge na master
- [ ] O backend sobe com ddl-auto=validate sem divergência de colunas
- [ ] Depois do congelamento, mudança só por nova migração (V3, V4...) revisada

**Requisitos deste cartão**

- **RN-001** — Cada paciente deve possuir um cadastro individual no sistema.
- **RN-004** — Um médico não pode possuir dois agendamentos ativos que ocupem o mesmo intervalo de atendimento.
- **RN-010** — Toda consulta deve estar vinculada a um paciente, médico, data e horário.
- **RN-012** — Agendamentos cancelados devem permanecer registrados no histórico.
- **RN-013** — O sistema deve controlar os estados dos agendamentos conforme o fluxo definido, conforme: AGENDADA, CANCELADA e CONCLUIDA
- **RN-016** — Todo cancelamento deve registrar o motivo.
- **RN-017** — A duração das consultas é definida pelo médico em cada janela de atendimento, entre 30 e 60 minutos.
- **RF-028** — O sistema deve manter registros das notificações enviadas.
- **RNF-011** — As informações devem ser armazenadas em banco de dados persistente.
- **RNF-012** — O sistema deve preservar a consistência dos agendamentos em operações simultâneas.
- **RNF-015** — O tratamento dos dados pessoais deve observar os requisitos aplicáveis da LGPD.

**Links:** [PR #1 (V4)](https://github.com/faculdade-ads-senai/agendamentos-sa-backend/pull/1) · [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md) · [migrações no backend](https://github.com/faculdade-ads-senai/agendamentos-sa-backend/tree/master/src/main/resources/db/migration)

### Concluído

<a id="dec-01"></a>

#### DEC-01 — Definir os clientes: painel web + app React + Capacitor

**Lista:** Concluído · **Responsável:** Luís · **Prazo (proposta):** 15/11 · **Depende de:** — · **Etiquetas:** Decisão da equipe, Documentação

**Pra quê.** Registrar quais aplicações o grupo entrega na SA.

**O que já se sabe**

- Em 27/10 o escopo era só web responsivo.
- Em 15/11 o grupo decidiu: painel web para o administrador e app React + Capacitor (Android) para o paciente, com o mesmo backend e o mesmo contrato.
- A SA vale para Web, Móveis e Distribuídos, e o tema do enunciado é o aplicativo mobile.
- Cada grupo faz o sistema inteiro: o professor descartou a divisão do PDF em uma equipe por módulo, e dentro do grupo o Victor faz o front de todos os módulos.

**Entra:** painel web administrativo (React + Vite); app do paciente (React + Capacitor, Android); um backend e um contrato para os dois. **Fica de fora:** app iOS; app nativo em Kotlin, Flutter ou React Native.

**Perguntas**

- [x] Decidir entre só web responsivo e web + app
- [x] Registrar a decisão com data no backlog e na modelagem
- [x] Dividir o antigo FE-01 em FE-01W (painel) e FE-01M (app)
- [x] Passar a área do paciente (FE-03) para o app

**Pronto quando**

- [x] Decisão registrada com data (15/11/2026)
- [x] Cartões de frontend refletem os dois clientes

**Requisitos deste cartão**

- **RNF-007** — O aplicativo mobile (React + Capacitor) deve oferecer interface adequada a diferentes tamanhos de tela de celulares.
- **RNF-008** — O painel administrativo deve apresentar interface responsiva para computadores e tablets.
- **RNF-016** — O aplicativo mobile deve funcionar em Android 8.0 (API 26) ou superior.

**Links:** [requisitos/REQUISITOS.md](../requisitos/REQUISITOS.md) · [arquitetura/ARQUITETURA.md](../arquitetura/ARQUITETURA.md)

<a id="dec-02"></a>

#### DEC-02 — Decisões técnicas da versão 1

**Lista:** Concluído · **Responsável:** Todos (Luís registra) · **Prazo (proposta):** 18/11 · **Depende de:** — · **Etiquetas:** Decisão da equipe, Prioridade alta

**Pra quê.** Fechar as decisões técnicas que ainda eram proposta, para backend e clientes pararem de depender delas.

**Decidido**

- Banco PostgreSQL, clínica única e especialidade como atributo do médico.
- Login só com a conta Google, para todos os perfis. Sem senha e sem recuperação de senha. O e-mail e senha de hoje vira login de teste, só no perfil dev.
- Perfis: paciente, médico e administrador. O administrador faz o papel da recepcionista. O médico entra na v1, com login e telas.
- Consulta de 30 a 60 minutos. Quem escolhe é o médico, em cada janela da agenda; o paciente só escolhe o horário.
- Notificações na caixa de entrada do app e do painel e por e-mail, enviado em segundo plano pela Brevo. Sem push no celular.
- Google Agenda: o e-mail leva um convite (.ics) que a pessoa adiciona à agenda dela. A disponibilidade continua no sistema.
- Lembrete 24 horas antes, pelo sistema.
- Backend: Yuri com os módulos 1, 3 e 5; Pierre com os módulos 2 e 4. API publicada no Render pelo Luís.

**O que já se sabe**

- Lido em sala em 17/11 por Luís, Yuri, Pierre e Victor. O Yuri marcou as caixas e deixou nos comentários o que mudou em relação à proposta.
- Em 18/11 o Luís confirmou item por item. O registro completo está na seção “Decisões da versão 1” do MODELO_DADOS.md.
- Mudou em relação à proposta: login só pelo Google; e-mail passou de opcional a obrigatório; recepcionista virou o próprio administrador; médico entra na v1; duração de 30 a 60 minutos.
- Ficou de fora: a disponibilidade vir da Google Agenda do médico, ou o sistema gravar na agenda das pessoas. Isso exige permissão “sensível” do Google: app em modo de teste, cada pessoa cadastrada à mão e acesso que expira a cada 7 dias. Também jogaria fora o módulo de agenda do Pierre.
- O plano gratuito do Render bloqueia o envio de e-mail por SMTP; por isso o e-mail sai pela API HTTP da Brevo (gratuita, 300 por dia).
- Sobrou para o DEC-04: onde fica a tela do médico e como a consulta vira concluída.

**Entra:** banco; login; perfis; duração da consulta; canal e momento das notificações; Google Agenda; divisão do backend; publicação da API. **Fica de fora:** regras de cancelamento e reagendamento (DEC-03); tela do médico e consulta concluída (DEC-04).

**Perguntas**

- [x] Banco: PostgreSQL
- [x] Clínica única, sem tabela de unidade
- [x] Especialidade como atributo do médico
- [x] Login: só pelo Google, para todos; e-mail e senha só no perfil dev
- [x] Perfis: ADMIN (faz o papel da recepcionista), PACIENTE e MEDICO; médico com login e telas na v1
- [x] Duração: 30 a 60 minutos, definida pelo médico em cada janela
- [x] Notificações: caixa de entrada + e-mail pela Brevo em segundo plano; sem push
- [x] Google Agenda: convite .ics no e-mail; disponibilidade continua no sistema
- [x] Lembrete: 24 horas antes, pelo sistema
- [x] Backend: Yuri 1, 3 e 5; Pierre 2 e 4
- [x] Publicação da API: Render, com o Luís (BE-08)
- [x] Registrar no MODELO_DADOS.md e escrever a V4 (18/11)

**Pronto quando**

- [x] Nenhum item da tabela “Decisões da versão 1” continua como proposta
- [x] O grupo deu OK em sala (17/11) e o Luís confirmou item por item (18/11)
- [x] BE-04, BE-05 e BE-06 citam a duração e o canal decididos

**Requisitos deste cartão**

- **RN-005** — Consultas devem ser agendadas somente em horários definidos como disponíveis.
- **RN-017** — A duração das consultas é definida pelo médico em cada janela de atendimento, entre 30 e 60 minutos.
- **RF-002** — O sistema deve permitir a autenticação por meio da conta Google.
- **RF-024** — O sistema deve enviar notificações de confirmação de agendamento.
- **RF-025** — O sistema deve enviar lembretes sobre consultas futuras.
- **RF-026** — O sistema deve notificar pacientes sobre cancelamentos de consultas.
- **RF-027** — O sistema deve notificar pacientes sobre alterações nos agendamentos.
- **RF-028** — O sistema deve manter registros das notificações enviadas.
- **RNF-002** — O sistema não deve armazenar senhas: a autenticação é feita pela conta Google, e o backend confere o token do Google antes de emitir o próprio token de acesso. As senhas dos usuários de demonstração do ambiente de desenvolvimento usam hash BCrypt.
- **RNF-011** — As informações devem ser armazenadas em banco de dados persistente.

**Links:** [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md)

<a id="dec-03"></a>

#### DEC-03 — Regras de cancelamento e reagendamento

**Lista:** Concluído · **Responsável:** Todos (Luís registra) · **Prazo (proposta):** 18/11 · **Depende de:** — · **Etiquetas:** Decisão da equipe, Contrato API

**Módulo do enunciado:** 3 — Agendamento de consultas

**Pra quê.** Definir quem pode cancelar ou reagendar, até quando e com quais dados.

**Decidido**

- Paciente: cancela e reagenda só as próprias consultas futuras, até 24 horas antes do início.
- Médico: só cancela, e só consultas futuras da própria agenda, sem prazo mínimo.
- Administrador: cancela e reagenda qualquer consulta futura, sem prazo mínimo.
- Motivo obrigatório em todo cancelamento, de qualquer um. No reagendamento é opcional e vai só no texto do aviso.
- Toda mudança avisa o paciente e o médico da consulta, menos quem fez a mudança.
- Erros: seguem a tabela de erros do contrato (21/11). O paciente a menos de 24 horas recebe a mensagem “fale com a clínica”.

**O que já se sabe**

- Fechado em sala em 17/11. Comentário do Yuri: “Só cancelar com 1 dia de antecedência (ambos). Motivo obrigatório. Admin pode fazer tudo, mas tem que notificar reagendamentos / cancelamentos.”
- Em 18/11 o Luís confirmou a tabela de regras.
- Por que o médico só cancela: remarcar é escolher outro horário que sirva ao paciente. Isso fica com o próprio paciente, pelo app, ou com o administrador (a recepção), falando com ele. Também é uma permissão a menos para programar e testar.
- O reagendamento altera o intervalo da mesma consulta; o cancelamento guarda quando, quem e por quê, e a consulta continua no histórico.

**Entra:** antecedência mínima; motivo do cancelamento; permissões do paciente, do médico e do administrador; quem é avisado; mensagem para o paciente fora do prazo. **Fica de fora:** multa por falta; lista de espera; remarcação automática.

**Perguntas**

- [x] Reagendar altera o intervalo da mesma consulta
- [x] Cancelar grava cancelado_em, cancelado_por_id e o motivo, e mantém a consulta no histórico
- [x] Paciente: só as próprias consultas futuras, até 24 horas antes
- [x] Médico: só cancela, consultas futuras da própria agenda, sem prazo
- [x] Administrador: cancela e reagenda qualquer consulta futura, sem prazo
- [x] Motivo obrigatório no cancelamento (V4); opcional no reagendamento
- [x] Toda mudança avisa paciente e médico, menos quem fez
- [x] Regras escritas nas duas rotas do openapi.yaml (1.3.0, 18/11)

**Pronto quando**

- [x] Regras registradas no MODELO_DADOS.md e no openapi.yaml
- [x] Erro de cada caso definido; desde 21/11 os códigos estão na tabela de erros do contrato

**Requisitos deste cartão**

- **RN-007** — O cancelamento de uma consulta deve liberar o horário para novos agendamentos, desde que não exista outro bloqueio.
- **RN-008** — O reagendamento deve validar a disponibilidade do novo horário antes da confirmação.
- **RN-012** — Agendamentos cancelados devem permanecer registrados no histórico.
- **RN-015** — O paciente só pode cancelar ou reagendar a própria consulta até 24 horas antes do início. O médico (só cancelamento, nas consultas da própria agenda) e o administrador podem fazê-lo a qualquer momento antes da consulta.
- **RN-016** — Todo cancelamento deve registrar o motivo.
- **RF-015** — O sistema deve permitir o cancelamento de consultas agendadas.
- **RF-016** — O sistema deve permitir o reagendamento de consultas.
- **RF-018** — O sistema deve permitir que administradores cancelem ou reagendem consultas.
- **RF-030** — O sistema deve permitir que médicos cancelem consultas da própria agenda, informando o motivo.

**Links:** [banco-de-dados/MODELO_DADOS.md](../banco-de-dados/MODELO_DADOS.md) · [openapi.yaml (contrato; tabela de erros no topo)](../api/openapi.yaml)

<a id="req-01"></a>

#### REQ-01 — Confirmar os ajustes do documento de requisitos

**Lista:** Concluído · **Responsável:** Luís · **Prazo (proposta):** 18/11 · **Depende de:** DEC-01, DEC-02 · **Etiquetas:** Documentação, Prioridade alta

**Pra quê.** Deixar os requisitos coerentes com a decisão web + app, com o banco e com as decisões de 17/11.

**O que já se sabe**

- O documento saiu do Google Drive e agora fica em requisitos/REQUISITOS.md (versão 1.2, 18/11).
- Em 18/11 o Luís confirmou o que era proposta: RF-004 fora da v1, Android 8.0 ou superior (RNF-016) e notificações assíncronas (RNF-019).
- Entraram com as decisões de 17/11: RN-015 (24 horas para o paciente), RN-016 (motivo obrigatório), RN-017 (duração de 30 a 60 minutos), RF-029 e RF-030 (área do médico). RF-001, RF-002, RNF-002 e RNF-004 foram reescritos para o login com Google e o perfil médico.

**Entra:** RN-003 sem “unidades de saúde”; RNF-007 citando React + Capacitor; RNF-016 com Android 8.0 ou superior; RF-004 fora da v1; RNF-019 novo, notificações assíncronas; RN-015 a RN-017, RF-029 e RF-030 novos. **Fica de fora:** mudança no enunciado da SA.

**Passos**

- [x] Migrar o documento do Drive para requisitos/REQUISITOS.md
- [x] Aplicar RN-003, RNF-007, RNF-016, RF-004 e RNF-019
- [x] Confirmar RNF-016 (Android 8.0 ou superior); a conferência no Capacitor ficou no FE-01M
- [x] Confirmar RF-004 fora da v1 (login pelo Google)
- [x] Confirmar RNF-019 junto com o DIST-01
- [x] Escrever os requisitos novos das decisões de 17/11 (18/11)
- [x] Tirar a marca de proposta do que foi aprovado

**Pronto quando**

- [x] Nenhum requisito cita unidades de saúde
- [x] Todo requisito tem pelo menos um cartão (tabela de rastreabilidade do BACKLOG.md)
- [x] Itens aprovados sem marca de proposta

**Requisitos deste cartão**

- **RN-003** — Apenas administradores podem cadastrar, editar ou desativar médicos.
- **RF-004** — O sistema deve permitir a recuperação de acesso à conta. Fora da versão 1: com o login pelo Google, quem recupera o acesso é o próprio Google.
- **RNF-001** — Toda comunicação entre as interfaces e o backend publicado deve utilizar HTTPS. No desenvolvimento local, HTTP é aceito.
- **RNF-007** — O aplicativo mobile (React + Capacitor) deve oferecer interface adequada a diferentes tamanhos de tela de celulares.
- **RNF-016** — O aplicativo mobile deve funcionar em Android 8.0 (API 26) ou superior.
- **RNF-019** — As notificações devem ser registradas na mesma transação da operação que as origina e enviadas por um processo assíncrono, sem bloquear o agendamento, com registro de tentativas e reenvio em caso de falha.

**Links:** [requisitos/REQUISITOS.md](../requisitos/REQUISITOS.md) · [organizacao/BACKLOG.md](../organizacao/BACKLOG.md)

<a id="doc-02"></a>

#### DOC-02 — Migrar a documentação do Drive para o repositório agendamentos-sa-docs

**Lista:** Concluído · **Responsável:** Luís · **Prazo (proposta):** 16/11 · **Depende de:** — · **Etiquetas:** Documentação

**Pra quê.** Ter um lugar só, versionado, para requisitos, arquitetura, banco, contrato e backlog.

**O que já se sabe**

- No Drive havia o documento de requisitos (Word) e quatro arquivos de arquitetura em texto; modelagem e contrato estavam em arquivos soltos.
- Como no FileMind (backend, frontend e documentação), o projeto passa a ter backend, frontend e agendamentos-sa-docs.

**Entra:** requisitos; arquitetura (backend v1 e v2, painel, app); modelagem e validação do banco; ambientes (local e produção); contrato OpenAPI; backlog. **Fica de fora:** código, que fica nos repositórios de implementação; conversas do grupo.

**Passos**

- [x] Criar o repositório agendamentos-sa-docs (hoje na organização faculdade-ads-senai)
- [x] Converter “Trabalho SA - Desenvolvimento WEB” para requisitos/REQUISITOS.md
- [x] Juntar os quatro arquivos de arquitetura em arquitetura/ARQUITETURA.md
- [x] Copiar modelagem, script de validação, contrato e backlog
- [x] Escrever o README com índice e links dos repositórios
- [x] Dar acesso de escrita a Yuri, Pierre e Victor (conferido em 18/11: Yuri, Victor e Luís administradores, Pierre com escrita)
- [x] Avisar no grupo que o Drive deixa de ser atualizado e deixar lá o link do repositório
- [x] Renomear o quadro do Trello para “Agendamentos SA” (era “Agenda SA — Web Responsivo”)

**Pronto quando**

- [x] Tudo o que estava no Drive tem equivalente no repositório
- [x] Os quatro integrantes abrem e editam o repositório
- [x] Cartões do Trello apontam para o repositório, não para o Drive

**Requisitos deste cartão**

- **RNF-014** — O código-fonte deve seguir uma organização modular e padrões de desenvolvimento definidos pela equipe.

**Links:** [README.md](../README.md) · [frontend-agendamento](https://github.com/VictorKLing/frontend-agendamento) · [agendamentos-sa (backend)](https://github.com/faculdade-ads-senai/agendamentos-sa-backend)

<a id="db-03"></a>

#### DB-03 — Carregar dados de demonstração no perfil dev

**Lista:** Concluído · **Responsável:** Luís · **Prazo (proposta):** 20/11 · **Depende de:** DB-02 · **Etiquetas:** Banco de dados

**Pra quê.** Qualquer integrante sobe o backend local já com usuários, médicos, agendas e consultas para testar.

**O que já se sabe**

- Em 18/11, na branch da V4, os dados ganharam 3 usuários médicos ligados aos médicos fictícios, e as janelas de 20 minutos passaram a 30.
- Concluído em 16/11, com merge do Luís.
- PR #3: o script repetível R__dados_demonstracao.sql, que só roda com SPRING_PROFILES_ACTIVE=dev.
- O perfil dev usa um banco separado, o agenda_sa_demo, porque o teste mostrou que um banco que recebeu a demonstração não sobe mais sem o perfil dev (o Flyway acusa a migração ausente).
- PR #4: scripts/demo-local.ps1 sobe no Windows, em um comando, um PostgreSQL portátil na porta 5433, o backend com o perfil dev e o painel.
- Testado num PostgreSQL 18.7.
- As rotas de agenda ainda não existem na master; o teste delas com estes dados fica no BE-04.

**Entra:** 1 administrador, 2 pacientes e 3 médicos (senha Demo@1234, só para o login de teste do perfil dev); 3 médicos fictícios (CRM DEMO-1001 a 1003/SC); 11 janelas de agenda e 1 bloqueio; 4 consultas: 2 futuras, 1 concluída, 1 cancelada; notificações de confirmação, lembrete e cancelamento; banco separado agenda_sa_demo no perfil dev; scripts/demo-local.ps1 (Windows, um comando). **Fica de fora:** dados reais; banco de produção.

**Passos**

- [x] Escrever R__dados_demonstracao.sql com ON CONFLICT e NOT EXISTS (repetível)
- [x] Criar application-dev.yaml com a pasta db/dev no Flyway e o banco separado agenda_sa_demo
- [x] Atualizar a branch para o master com JWT e usar o perfil ADMIN (V3)
- [x] Rodar com o perfil dev num banco vazio (16/11, PostgreSQL 18.7)
- [x] Rodar de novo e confirmar que nada duplica
- [x] Subir sem o perfil dev e confirmar que nada é inserido
- [x] Publicar a branch e abrir PR no backend (PR #3, merge em 16/11)
- [x] Script de demonstração em um comando no Windows (PR #4, merge em 16/11)
- [x] Listar os usuários de demonstração: AMBIENTES.md, PR #3 e cabeçalho do script (o backend não tem README)

**Pronto quando**

- [x] Com o perfil dev, os usuários de demonstração entram e aparecem na rota de usuários e no painel
- [x] Rodar duas vezes não duplica nada
- [x] Sem o perfil dev, nenhum dado de demonstração é criado

**Requisitos deste cartão**

- **RNF-015** — O tratamento dos dados pessoais deve observar os requisitos aplicáveis da LGPD.
- **RNF-018** — As funcionalidades críticas de autenticação e agendamento devem possuir testes automatizados.

**Links:** [banco-de-dados/AMBIENTES.md](../banco-de-dados/AMBIENTES.md) · [dados de demonstração](https://github.com/faculdade-ads-senai/agendamentos-sa-backend/tree/master/src/main/resources/db/dev) · [scripts/demo-local.ps1](https://github.com/faculdade-ads-senai/agendamentos-sa-backend/blob/master/scripts/demo-local.ps1)
