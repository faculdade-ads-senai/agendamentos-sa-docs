# Arquitetura — Agendamentos SA

## Visão geral

```mermaid
flowchart LR
    web["Painel web<br>React + Vite<br>(administrador)"] -->|HTTPS + JSON| api
    app["App Android<br>React + Capacitor<br>(paciente)"] -->|HTTPS + JSON| api
    api["API REST<br>Spring Boot 4 / Java 21"] -->|JDBC + Flyway| db[("PostgreSQL<br>produção: Neon")]
    envio["Envio de notificações<br>processo agendado"] -->|lê PENDENTE,<br>marca ENVIADA ou FALHA| db
    api -. grava notificação<br>na mesma transação .-> db
```

| Parte | Tecnologia | Repositório | Situação em 15/11/2026 |
|---|---|---|---|
| API | Spring Boot 4.1, Java 21, Spring Data JPA, Flyway, Spring Security | `faculdade-ads-senai/agendamentos-sa-backend` | CRUD de usuários pronto; agenda, bloqueios e horários disponíveis no PR #2 |
| Painel web | React 19, Vite, Tailwind CSS (JavaScript) | `VictorKLing/frontend-agendamento` | Login e usuários integrados |
| App do paciente | React, Vite, Capacitor (Android) | a criar | Não iniciado |
| Banco | PostgreSQL 16+ | migrações no backend (`src/main/resources/db/migration`) | V1, V2 e V3 prontas; produção no Neon (ver [ambientes](../banco-de-dados/AMBIENTES.md)) |
| Documentação | Markdown e OpenAPI | `agendamentos-sa-docs` (este) | Versão 1.1 |

Princípios:

- Os dois clientes falam só com a API; nenhum acessa o banco direto.
- O banco é definido pelas migrações Flyway. O Hibernate só confere se as entidades batem com ele (`ddl-auto=validate`).
- Conflito de horário é barrado no próprio banco (restrição de exclusão), não só na aplicação. Assim dois pedidos simultâneos não reservam o mesmo horário.
- As notificações são gravadas junto com o agendamento e enviadas depois por um processo separado (caixa de saída transacional). É o conceito de sistemas distribuídos da SA; detalhes em [Notificações assíncronas](../banco-de-dados/MODELO_DADOS.md#notificações-assíncronas-conceito-de-sistemas-distribuídos).
- O contrato da API está em [api/openapi.yaml](../api/openapi.yaml).

As estruturas de pastas abaixo foram definidas pelo grupo e migradas dos arquivos de texto do Google Drive (pasta "Desenvolvimento Web - SA"). O código nos repositórios é a referência quando houver diferença.

## Estruturas planejadas

### Backend (versão 2, atual)

Arquivo de origem: `Arquitetura-BackEnd_v2.txt`.

```
src/
└── main/
    ├── java/
    │   └── com/
    │       └── agendasa/
    │           ├── agendamentos/
    │           │   ├── controller/
    │           │   ├── dto/
    │           │   ├── entity/
    │           │   ├── mapper/
    │           │   ├── repository/
    │           │   └── service/
    │           ├── agendas/
    │           │   ├── controller/
    │           │   ├── dto/
    │           │   ├── entity/
    │           │   ├── mapper/
    │           │   ├── repository/
    │           │   └── service/
    │           ├── autenticacao/
    │           │   ├── controller/
    │           │   ├── dto/
    │           │   ├── entity/
    │           │   ├── mapper/
    │           │   ├── repository/
    │           │   └── service/
    │           ├── config/
    │           │   └── security/
    │           ├── medicos/
    │           │   ├── controller/
    │           │   ├── dto/
    │           │   ├── entity/
    │           │   ├── mapper/
    │           │   ├── repository/
    │           │   └── service/
    │           ├── notificacoes/
    │           │   ├── controller/
    │           │   ├── dto/
    │           │   ├── entity/
    │           │   ├── mapper/
    │           │   ├── repository/
    │           │   └── service/
    │           ├── shared/
    │           │   ├── dto/
    │           │   ├── enums/
    │           │   ├── exception/
    │           │   └── util/
    │           └── usuarios/
    │               ├── config/
    │               ├── controller/
    │               │   └── v1/
    │               ├── dto/
    │               ├── exception/
    │               ├── mapper/
    │               ├── model/
    │               ├── repository/
    │               ├── service/
    │               └── validation/
    └── resources/
        └── db/
            └── migration/
```

### Aplicativo mobile, versão em JavaScript

Arquivo de origem: `Arquitetura-frontend.txt`.

```
agenda-sa-mobile/
│
├── android/
│
├── public/
│   ├── favicon.ico
│   └── images/
│
├── src/
│   │
│   ├── assets/
│   │   ├── images/
│   │   └── icons/
│   │
│   ├── components/
│   │   ├── ui/
│   │   │   ├── Button.jsx
│   │   │   ├── Input.jsx
│   │   │   ├── Modal.jsx
│   │   │   ├── Loading.jsx
│   │   │   └── EmptyState.jsx
│   │   │
│   │   ├── layout/
│   │   │   ├── AppLayout.jsx
│   │   │   ├── Header.jsx
│   │   │   ├── BottomNavigation.jsx
│   │   │   └── Sidebar.jsx
│   │   │
│   │   ├── auth/
│   │   │   ├── LoginForm.jsx
│   │   │   └── CadastroForm.jsx
│   │   │
│   │   ├── medicos/
│   │   │   ├── MedicoCard.jsx
│   │   │   └── MedicoList.jsx
│   │   │
│   │   ├── horarios/
│   │   │   ├── Calendario.jsx
│   │   │   └── HorarioCard.jsx
│   │   │
│   │   └── consultas/
│   │       ├── ConsultaCard.jsx
│   │       └── ConsultaStatus.jsx
│   │
│   ├── pages/
│   │   ├── Login.jsx
│   │   ├── Cadastro.jsx
│   │   ├── Home.jsx
│   │   ├── Medicos.jsx
│   │   ├── Horarios.jsx
│   │   ├── AgendarConsulta.jsx
│   │   ├── MinhasConsultas.jsx
│   │   ├── Historico.jsx
│   │   └── Perfil.jsx
│   │
│   ├── services/
│   │   ├── api.js
│   │   ├── authService.js
│   │   ├── medicoService.js
│   │   ├── horarioService.js
│   │   ├── agendamentoService.js
│   │   └── usuarioService.js
│   │
│   ├── contexts/
│   │   ├── AuthContext.jsx
│   │   └── AppContext.jsx
│   │
│   ├── hooks/
│   │   ├── useAuth.js
│   │   ├── useMedicos.js
│   │   ├── useHorarios.js
│   │   └── useConsultas.js
│   │
│   ├── routes/
│   │   ├── AppRoutes.jsx
│   │   ├── PrivateRoute.jsx
│   │   └── PublicRoute.jsx
│   │
│   ├── utils/
│   │   ├── formatDate.js
│   │   ├── formatPhone.js
│   │   └── validators.js
│   │
│   ├── App.jsx
│   ├── main.jsx
│   └── index.css
│
├── capacitor.config.js
├── index.html
├── package.json
├── vite.config.js
└── .gitignore
```

### Aplicativo mobile, versão em TypeScript

Arquivo de origem: `Arquitetura-FrontEnd-Mobile.txt`.

```
agenda-sa-mobile/
├── android/
├── public/
├── src/
│   ├── assets/
│   ├── components/
│   │   ├── layout/
│   │   └── ui/
│   │
│   ├── pages/
│   │   ├── Login.tsx
│   │   ├── Cadastro.tsx
│   │   ├── Home.tsx
│   │   ├── Medicos.tsx
│   │   ├── Horarios.tsx
│   │   ├── AgendarConsulta.tsx
│   │   ├── MinhasConsultas.tsx
│   │   ├── Historico.tsx
│   │   └── Perfil.tsx
│   │
│   ├── services/
│   │   ├── api.ts
│   │   ├── authService.ts
│   │   └── agendamentoService.ts
│   │
│   ├── contexts/
│   │   └── AuthContext.tsx
│   ├── hooks/
│   ├── routes/
│   ├── types/
│   ├── App.tsx
│   └── main.tsx
│
├── capacitor.config.ts
├── index.html
├── package.json
├── tsconfig.json
└── vite.config.ts
```

### Backend (versão 1, substituída pela versão 2)

Arquivo de origem: `Arquitetura-BackEnd_v1.txt`.

```
agenda-sa-backend/
├── pom.xml
├── Dockerfile
├── .env.example
├── src/
│   ├── main/
│   │   ├── java/com/agendasa/
│   │   │   ├── AgendaSaApplication.java
│   │   │   │
│   │   │   ├── config/
│   │   │   │   ├── SecurityConfig.java
│   │   │   │   └── CorsConfig.java
│   │   │   │
│   │   │   ├── autenticacao/
│   │   │   │   ├── controller/
│   │   │   │   ├── service/
│   │   │   │   └── dto/
│   │   │   │
│   │   │   ├── usuarios/
│   │   │   │   ├── controller/
│   │   │   │   ├── service/
│   │   │   │   ├── repository/
│   │   │   │   ├── model/
│   │   │   │   └── dto/
│   │   │   │
│   │   │   ├── medicos/
│   │   │   │   ├── controller/
│   │   │   │   ├── service/
│   │   │   │   ├── repository/
│   │   │   │   ├── model/
│   │   │   │   └── dto/
│   │   │   │
│   │   │   ├── agendas/
│   │   │   │   ├── controller/
│   │   │   │   ├── service/
│   │   │   │   ├── repository/
│   │   │   │   ├── model/
│   │   │   │   └── dto/
│   │   │   │
│   │   │   ├── agendamentos/
│   │   │   │   ├── controller/
│   │   │   │   ├── service/
│   │   │   │   ├── repository/
│   │   │   │   ├── model/
│   │   │   │   └── dto/
│   │   │   │
│   │   │   ├── notificacoes/
│   │   │   │   ├── service/
│   │   │   │   ├── repository/
│   │   │   │   └── model/
│   │   │   │
│   │   │   └── shared/
│   │   │       └── exception/
│   │   │
│   │   └── resources/
│   │       ├── application.yml
│   │       └── db/migration/
│   │           └── V1__initial_schema.sql
│   │
│   └── test/
│       └── java/com/agendasa/
└── README.md
```
