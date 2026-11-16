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
| `yuriOdsz/agendamentos-sa` | Backend Spring Boot e migrações do banco |
| `VictorKLing/frontend-agendamento` | Painel web (React + Vite) e, provavelmente, o app do paciente: o Capacitor gera o APK do mesmo projeto React (a confirmar com o Victor) |
| `agendamentos-sa-docs` | Esta documentação |

## Decisões a confirmar pelo grupo

O resto da documentação descreve o que já foi decidido ou já está no código. Só estes itens são propostas:

1. Consultas de 30 minutos, configuráveis por janela da agenda.
2. Na versão 1, notificações só no canal interno (lista no app); lembrete 24 horas antes da consulta.
3. Cancelar e reagendar sem antecedência mínima; motivo do cancelamento opcional; o administrador altera qualquer consulta; o paciente, só as próprias consultas futuras.
4. Recuperação de senha (RF-004) fora da versão 1.
5. App para Android 8.0 ou superior.
6. Notificações assíncronas (RNF-019) como o conceito de sistemas distribuídos da SA.

Quem discordar abre uma issue ou fala no grupo; sem objeção, valem como decididos.

Em aberto, sem proposta (precisa de resposta do grupo):

- Perfis `MEDICO` e `RECEPCIONISTA`: ganham telas na versão 1 ou ficam para depois? Se entrarem, o médico vê a própria agenda e conclui a consulta, e o recepcionista cadastra o paciente e agenda ou cancela por ele. O médico exige uma migração nova (V3, `medico.usuario_id`) e mudanças no backend; o recepcionista só muda o backend.
- Divisão do backend por módulo: Yuri com os módulos 1, 3 e 5 e Pierre com os módulos 2 e 4 (lembrança do Luís, a confirmar). O Yuri se atribuiu ao cadastro de médicos (módulo 2) no Trello em 27/10.
- Publicação da API na nuvem e quem publica (o enunciado fala em backend hospedado em nuvem).
- Painel e app no mesmo projeto React.

## Módulos do sistema

O enunciado divide o sistema em 6 módulos: 1 cadastro e autenticação, 2 agenda de profissionais, 3 agendamento de consultas, 4 histórico e consultas do paciente, 5 notificações e 6 aplicativo mobile. Cada equipe faz o sistema inteiro. No grupo, o Victor faz o front de todos os módulos, Yuri e Pierre dividem o backend e o Luís faz o banco de todos os módulos, o Trello e a documentação. A ligação de cada módulo com os cartões está no [backlog](organizacao/BACKLOG.md#módulos-do-enunciado).

## Como contribuir

- Mudança na documentação entra por PR, com commit no formato `docs: o que mudou`.
- Mudança no banco entra por nova migração no backend e é descrita no [modelo de dados](banco-de-dados/MODELO_DADOS.md) no mesmo dia.
- Mudança de rota, campo ou código de resposta da API entra primeiro no [contrato](api/openapi.yaml).
