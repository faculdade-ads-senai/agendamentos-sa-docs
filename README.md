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
| `VictorKLing/frontend-agendamento` | Painel web do administrador (React + Vite) |
| a criar | App do paciente (React + Capacitor) |
| `agendamentos-sa-docs` | Esta documentação |

## Decisões a confirmar pelo grupo

O resto da documentação descreve o que já foi decidido ou já está no código. Só estes itens são propostas:

1. Consultas de 30 minutos, configuráveis por janela da agenda.
2. Na versão 1, notificações só no canal interno (lista no app); lembrete 24 horas antes da consulta.
3. Cancelar e reagendar sem antecedência mínima; motivo do cancelamento opcional; o administrador altera qualquer consulta; o paciente, só as próprias consultas futuras.
4. Recuperação de senha (RF-004) fora da versão 1.
5. App para Android 8.0 ou superior.
6. Notificações assíncronas (RNF-019) como o conceito de sistemas distribuídos da SA.
7. Perfis `MEDICO` e `RECEPCIONISTA` reservados, sem funcionalidades na versão 1.

Quem discordar abre uma issue ou fala no grupo; sem objeção, valem como decididos.

## Como contribuir

- Mudança na documentação entra por PR, com commit no formato `docs: o que mudou`.
- Mudança no banco entra por nova migração no backend e é descrita no [modelo de dados](banco-de-dados/MODELO_DADOS.md) no mesmo dia.
- Mudança de rota, campo ou código de resposta da API entra primeiro no [contrato](api/openapi.yaml).
