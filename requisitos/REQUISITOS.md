# Requisitos — Agendamentos SA

Versão 1.1 — 15/11/2026. Migrado do documento "Trabalho SA - Desenvolvimento WEB" (Google Drive do grupo), versão de 26/10/2026. A partir de agora este arquivo é a versão oficial; o documento do Drive não é mais atualizado.

Clientes: painel web para o administrador (React + Vite) e aplicativo React + Capacitor para o paciente (Android), conforme decisão do grupo de 15/11/2026. Os dois usam a mesma API REST.

Itens marcados com **(proposta)** ainda dependem da confirmação do grupo. As mudanças desde a versão do Drive estão no fim do arquivo.

## 1. Regras de negócio (RN)

As regras de negócio determinam as condições que devem ser respeitadas durante a execução das funcionalidades.

| ID | Descrição |
|---|---|
| RN-001 | Cada paciente deve possuir um cadastro individual no sistema. |
| RN-002 | Apenas usuários autenticados podem realizar agendamentos. |
| RN-003 | Apenas administradores podem cadastrar, editar ou desativar médicos. |
| RN-004 | Um médico não pode possuir dois agendamentos ativos que ocupem o mesmo intervalo de atendimento. |
| RN-005 | Consultas devem ser agendadas somente em horários definidos como disponíveis. |
| RN-006 | Agendamentos não podem ser realizados para datas ou horários anteriores ao momento atual. |
| RN-007 | O cancelamento de uma consulta deve liberar o horário para novos agendamentos, desde que não exista outro bloqueio. |
| RN-008 | O reagendamento deve validar a disponibilidade do novo horário antes da confirmação. |
| RN-009 | Pacientes devem visualizar apenas seus próprios agendamentos e informações pessoais. |
| RN-010 | Toda consulta deve estar vinculada a um paciente, médico, data e horário. |
| RN-011 | A desativação de um médico deve impedir a criação de novos agendamentos para esse profissional. |
| RN-012 | Agendamentos cancelados devem permanecer registrados no histórico. |
| RN-013 | O sistema deve controlar os estados dos agendamentos conforme o fluxo definido, conforme: AGENDADA, CANCELADA e CONCLUIDA |
| RN-014 | Uma solicitação de agendamento deve ser confirmada somente após a verificação da disponibilidade do horário. |

## 2. Requisitos funcionais (RF)

Os requisitos funcionais definem as operações que o sistema deverá disponibilizar.

### 2.1. Cadastro e autenticação

| ID | Descrição | Perfil |
|---|---|---|
| RF-001 | O sistema deve permitir o cadastro de novos pacientes. | Paciente |
| RF-002 | O sistema deve permitir a autenticação por meio de credenciais. | Ambos |
| RF-003 | O sistema deve permitir que pacientes consultem e atualizem seus dados cadastrais. | Paciente |
| RF-004 | O sistema deve permitir a recuperação de acesso à conta. **(proposta: fora da versão 1)** | Ambos |
| RF-005 | O sistema deve permitir o encerramento da sessão do usuário. | Ambos |
| RF-006 | O sistema deve identificar o perfil do usuário e disponibilizar as funcionalidades correspondentes. | Ambos |

O banco aceita também os perfis `MEDICO` e `RECEPCIONISTA`, reservados para versões futuras. Na versão 1 só os perfis Paciente e Administrador têm funcionalidades.

RF-004 **(proposta)**: o banco não guarda o código de recuperação de senha. Para manter o requisito na versão 1 é preciso uma migração com tabela de códigos (hash, validade e uso único) e envio por e-mail.

### 2.2. Gerenciamento administrativo

| ID | Descrição |
|---|---|
| RF-007 | O sistema deve permitir que administradores cadastrem, editem, consultem e desativem médicos. |
| RF-008 | O sistema deve permitir que administradores consultem os pacientes cadastrados. |

### 2.3. Gerenciamento de agendas

| ID | Descrição |
|---|---|
| RF-009 | O sistema deve permitir que administradores definam os dias e horários de atendimento dos médicos. |
| RF-010 | O sistema deve permitir o bloqueio de horários indisponíveis para atendimento. |
| RF-011 | O sistema deve permitir a consulta dos horários disponíveis de cada médico. |
| RF-012 | O sistema deve atualizar a disponibilidade dos horários após a confirmação, cancelamento ou reagendamento de consultas. |

### 2.4. Agendamento de consultas

| ID | Descrição | Perfil |
|---|---|---|
| RF-013 | O sistema deve permitir a seleção de médico e horário para agendamento. | Paciente |
| RF-014 | O sistema deve permitir a confirmação de um agendamento quando houver disponibilidade. | Paciente |
| RF-015 | O sistema deve permitir o cancelamento de consultas agendadas. | Paciente |
| RF-016 | O sistema deve permitir o reagendamento de consultas. | Paciente |
| RF-017 | O sistema deve permitir que administradores consultem os agendamentos realizados. | Administrador |
| RF-018 | O sistema deve permitir que administradores cancelem ou reagendem consultas. | Administrador |
| RF-019 | O sistema deve permitir a consulta do status de cada agendamento. | Ambos |

### 2.5. Histórico de consultas

| ID | Descrição |
|---|---|
| RF-020 | O sistema deve permitir que pacientes consultem seus próximos agendamentos. |
| RF-021 | O sistema deve permitir que pacientes visualizem o histórico de agendamentos anteriores. |
| RF-022 | O sistema deve permitir que administradores consultem o histórico de agendamentos dos pacientes. |
| RF-023 | O sistema deve permitir a filtragem de agendamentos por período, médico ou status no painel administrativo. |

O histórico conterá somente dados administrativos dos agendamentos, sem informações clínicas ou prontuários.

### 2.6. Notificações

| ID | Descrição |
|---|---|
| RF-024 | O sistema deve enviar notificações de confirmação de agendamento. |
| RF-025 | O sistema deve enviar lembretes sobre consultas futuras. |
| RF-026 | O sistema deve notificar pacientes sobre cancelamentos de consultas. |
| RF-027 | O sistema deve notificar pacientes sobre alterações nos agendamentos. |
| RF-028 | O sistema deve manter registros das notificações enviadas. |

**(proposta)** Na versão 1 as notificações usam o canal interno do sistema (listadas no aplicativo); o envio por e-mail é opcional. O lembrete é gerado 24 horas antes da consulta.

## 3. Requisitos não funcionais (RNF)

Os requisitos não funcionais estabelecem padrões técnicos e de qualidade esperados.

| ID | Categoria | Descrição |
|---|---|---|
| RNF-001 | Segurança | Toda comunicação entre as interfaces e o backend publicado deve utilizar HTTPS. No desenvolvimento local, HTTP é aceito. |
| RNF-002 | Segurança | As senhas dos usuários devem ser armazenadas utilizando algoritmos seguros de hash. |
| RNF-003 | Segurança | As funcionalidades protegidas devem exigir autenticação válida. |
| RNF-004 | Segurança | O sistema deve implementar controle de acesso baseado nos perfis de paciente e administrador. |
| RNF-005 | Desempenho | As consultas de disponibilidade devem apresentar respostas em até 3 segundos em condições normais de utilização. |
| RNF-006 | Desempenho | O sistema deve suportar, inicialmente, pelo menos 50 usuários simultâneos sem perda de funcionalidades. |
| RNF-007 | Usabilidade | O aplicativo mobile (React + Capacitor) deve oferecer interface adequada a diferentes tamanhos de tela de celulares. |
| RNF-008 | Usabilidade | O painel administrativo deve apresentar interface responsiva para computadores e tablets. |
| RNF-009 | Arquitetura | O sistema deve utilizar APIs REST para comunicação entre os componentes. |
| RNF-010 | Arquitetura | O backend deve permitir a separação das responsabilidades de autenticação, cadastro, agenda e agendamento. |
| RNF-011 | Persistência | As informações devem ser armazenadas em banco de dados persistente. |
| RNF-012 | Confiabilidade | O sistema deve preservar a consistência dos agendamentos em operações simultâneas. |
| RNF-013 | Disponibilidade | O sistema deve possuir mecanismos de tratamento de falhas de comunicação com o backend. |
| RNF-014 | Manutenibilidade | O código-fonte deve seguir uma organização modular e padrões de desenvolvimento definidos pela equipe. |
| RNF-015 | Privacidade | O tratamento dos dados pessoais deve observar os requisitos aplicáveis da LGPD. |
| RNF-016 | Compatibilidade | O aplicativo mobile deve funcionar em Android 8.0 (API 26) ou superior. **(proposta)** |
| RNF-017 | Integração | As APIs devem utilizar JSON como formato padrão para troca de dados. |
| RNF-018 | Testabilidade | As funcionalidades críticas de autenticação e agendamento devem possuir testes automatizados. |
| RNF-019 | Arquitetura (sistemas distribuídos) | As notificações devem ser registradas na mesma transação da operação que as origina e enviadas por um processo assíncrono, sem bloquear o agendamento, com registro de tentativas e reenvio em caso de falha. **(proposta)** |

Observação: Os valores de desempenho, concorrência e compatibilidade são metas sugeridas. Eles precisam ser validados pela equipe e acompanhados de condições de teste antes de serem considerados requisitos definitivos.

O RNF-019 atende ao item da SA que pede pelo menos um conceito de sistemas distribuídos aplicado e justificado. O funcionamento está em [Notificações assíncronas](../banco-de-dados/MODELO_DADOS.md#notificações-assíncronas-conceito-de-sistemas-distribuídos).

## Mudanças desde a versão do Drive (26/10)

| ID | Mudança | Motivo |
|---|---|---|
| RN-003 | Sai "e unidades de saúde". | Clínica única: não existe cadastro de unidades na versão 1. |
| RF-004 | Proposta de tirar da versão 1. | O banco não guarda código de recuperação de senha. |
| 2.1 | Nota sobre os perfis reservados `MEDICO` e `RECEPCIONISTA`. | A migração V2 passou a aceitar esses perfis. |
| 2.6 | Proposta de canal interno e lembrete 24 horas antes. | Define o que a versão 1 entrega. |
| RNF-001 | HTTPS obrigatório no ambiente publicado; HTTP aceito no desenvolvimento local. | Evita exigir certificado na máquina de cada integrante. |
| RNF-007 | Cita React + Capacitor. | Decisão do grupo de 15/11. |
| RNF-016 | Proposta: Android 8.0 (API 26) ou superior. | O texto anterior não definia a versão. |
| RNF-019 | Novo, proposto. | Conceito de sistemas distribuídos da SA. |
