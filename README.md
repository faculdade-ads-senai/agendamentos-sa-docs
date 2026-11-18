# Agendamentos SA — Documentação

Documentação compartilhada do sistema de agendamento de consultas, a Situação de Aprendizagem (SA) de Desenvolvimento de Sistemas Web, Desenvolvimento de Sistemas Móveis e Desenvolvimento de Sistemas Distribuídos (SENAI).

Este repositório substitui a pasta do Google Drive. Requisitos, arquitetura, banco, contrato da API e backlog ficam aqui; o código fica nos repositórios de implementação.

**Prazo:** a tarefa da SA no AVA (Desenvolvimento de Sistemas Web) vence em 08/12/2026 às 00:00, ou seja, a entrega tem que sair até 07/12 às 23:59. O AVA aceita um envio só.

## Conteúdo

| Assunto | Arquivo |
|---|---|
| Requisitos (regras de negócio, funcionais e não funcionais) | [requisitos/REQUISITOS.md](requisitos/REQUISITOS.md) |
| Arquitetura e estrutura de pastas | [arquitetura/ARQUITETURA.md](arquitetura/ARQUITETURA.md) |
| Modelo de dados, migrações e decisões | [banco-de-dados/MODELO_DADOS.md](banco-de-dados/MODELO_DADOS.md) |
| Banco local e de produção (Neon) | [banco-de-dados/AMBIENTES.md](banco-de-dados/AMBIENTES.md) |
| Validação das restrições do banco | [banco-de-dados/validacao_restricoes.sql](banco-de-dados/validacao_restricoes.sql) |
| Contrato da API (OpenAPI) | [api/openapi.yaml](api/openapi.yaml) e [api/README.md](api/README.md) |
| Backlog do Trello, detalhado | [organizacao/BACKLOG.md](organizacao/BACKLOG.md) |

## Repositórios do projeto

| Repositório | Conteúdo |
|---|---|
| [`faculdade-ads-senai/agendamentos-sa-backend`](https://github.com/faculdade-ads-senai/agendamentos-sa-backend) | Backend Spring Boot e migrações do banco (privado; até 16/11 era `yuriOdsz/agendamentos-sa`) |
| `VictorKLing/frontend-agendamento` | Painel web (React + Vite) e, provavelmente, o app do paciente: o Capacitor gera o APK do mesmo projeto React (a confirmar com o Victor) |
| [`faculdade-ads-senai/agendamentos-sa-docs`](https://github.com/faculdade-ads-senai/agendamentos-sa-docs) | Esta documentação (pública; até 18/11 era `luisctorrens/agendamentos-sa-docs`) |

## Decisões da versão 1

O grupo fechou as decisões técnicas em sala em 17/11/2026 (DEC-02 e DEC-03). Em resumo:

- Login só com a conta Google, para todos. Sem senha e sem recuperação de senha.
- Perfis: paciente, médico e administrador. O administrador faz também o papel da recepcionista.
- Consulta de 30 a 60 minutos, definida pelo médico em cada janela da agenda.
- Notificações na caixa de entrada do app e do painel e por e-mail, com convite para a Google Agenda. Lembrete 24 horas antes. Sem push no celular.
- Paciente cancela ou reagenda até 24 horas antes; médico só cancela; administrador faz tudo. Motivo obrigatório no cancelamento.
- Backend: Yuri com os módulos 1, 3 e 5; Pierre com os módulos 2 e 4. API publicada no Render pelo Luís.

A tabela completa está em [Decisões da versão 1](banco-de-dados/MODELO_DADOS.md#decisões-da-versão-1-dec-02-e-dec-03).

Ainda em aberto (DEC-04, no Trello):

- Onde fica a tela do médico: no painel web ou no app.
- Como a consulta vira `CONCLUIDA`: sozinha, depois do horário, ou o médico marca.
- Painel e app no mesmo projeto React (a confirmar com o Victor).

## Módulos do sistema

O enunciado divide o sistema em 6 módulos: 1 cadastro e autenticação, 2 agenda de profissionais, 3 agendamento de consultas, 4 histórico e consultas do paciente, 5 notificações e 6 aplicativo mobile. Cada equipe faz o sistema inteiro. No grupo, o Victor faz o front de todos os módulos, Yuri e Pierre dividem o backend e o Luís faz o banco de todos os módulos, o Trello e a documentação. A ligação de cada módulo com os cartões está no [backlog](organizacao/BACKLOG.md#módulos-do-enunciado).

## Como contribuir

- Mudança na documentação entra por PR, com commit no formato `docs: o que mudou`.
- Mudança no banco entra por nova migração no backend e é descrita no [modelo de dados](banco-de-dados/MODELO_DADOS.md) no mesmo dia.
- Mudança de rota, campo ou código de resposta da API entra primeiro no [contrato](api/openapi.yaml).
