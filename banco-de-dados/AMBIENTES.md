# Ambientes do banco — Agendamentos SA

| Ambiente | Onde roda | Quem usa | Dados |
|---|---|---|---|
| Desenvolvimento | PostgreSQL 16+ na máquina de cada integrante | Cada integrante, para programar e testar | Dados de demonstração (perfil `dev`) ou criados no teste |
| Produção | Neon (PostgreSQL gerenciado, plano gratuito) | Backend publicado e apresentação da SA | Só o que for cadastrado pelo sistema; nunca dados de demonstração automáticos |

Nos dois ambientes a estrutura vem das mesmas migrações Flyway do backend. Ninguém cria ou altera tabela à mão.

## Desenvolvimento local

1. Suba um PostgreSQL 16 ou superior. Com Docker:

   ```bash
   docker run --name agenda-sa-db -e POSTGRES_DB=agenda_sa -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres:17
   ```

2. Crie o arquivo `.env` na raiz do backend (o `.gitignore` já o ignora):

   ```properties
   DB_HOST=localhost
   DB_PORT=5432
   DB_NAME=agenda_sa
   DB_USERNAME=postgres
   DB_PASSWORD=postgres
   ```

3. Rode o backend. Na primeira subida o Flyway aplica V1, V2 e V3.
4. Para ter dados de demonstração, rode com `SPRING_PROFILES_ACTIVE=dev`. Usuários: `admin.demo@example.com`, `ana.demo@example.com` e `bruno.demo@example.com`, senha `Demo@1234`. Depende do PR dos dados de demonstração estar na `master`.
5. Para conferir as restrições do banco, rode [validacao_restricoes.sql](validacao_restricoes.sql) no DBeaver, pgAdmin ou psql. Ele desfaz tudo no fim.

Para recomeçar do zero: apague e recrie o banco `agenda_sa` e suba o backend de novo.

## Produção (Neon)

### Por que o Neon

- Gratuito sem prazo de validade, com 1 GB por projeto, que sobra para a SA.
- Não pausa o projeto por falta de uso. Ele só desliga o processamento depois de alguns minutos parado e religa na conexão seguinte. O Supabase gratuito, por exemplo, pausa o projeto depois de 7 dias sem uso, o que é arriscado perto da apresentação.
- PostgreSQL 17 com a extensão `btree_gist`, que a V1 usa para barrar horários sobrepostos.

### Como criar

1. Conta em [neon.com](https://neon.com), entrando com o GitHub.
2. Projeto `agendamentos-sa`, PostgreSQL 17, região AWS São Paulo (`sa-east-1`) se ela aparecer na lista. Se não aparecer, use a mesma região onde o backend for publicado.
3. Banco `agenda_sa` (o Neon cria um `neondb` padrão; crie o `agenda_sa` em Databases ou use `DB_NAME=neondb`).
4. Em **Connect**, copie host, usuário e senha da conexão direta (o host sem `-pooler`).
5. Primeira subida: um `.env` com os dados de produção e o backend rodando **sem** o perfil `dev`. O Flyway cria a `flyway_schema_history` e aplica V1, V2 e V3.

   ```properties
   spring.datasource.url=jdbc:postgresql://<host-do-neon>/agenda_sa?sslmode=require
   DB_USERNAME=<usuario>
   DB_PASSWORD=<senha>
   ```

   A linha `spring.datasource.url` substitui a URL montada pelo `application.yaml` e força conexão criptografada, que o Neon exige.

6. Conferência no SQL Editor do Neon:

   ```sql
   SELECT version, description, success FROM flyway_schema_history ORDER BY installed_rank;
   ```

   Devem aparecer V1, V2 e V3 com `success = true`.

7. Primeiro administrador: desde o login com JWT (15/11), `POST /api/v1/usuarios` exige um `ADMIN` logado. O primeiro é criado direto no banco com o `scripts/criar-admin.sql` do backend, no SQL Editor do Neon (troque nome, e-mail e senha no próprio editor). O editor guarda o histórico das consultas: use uma senha provisória e troque-a em seguida pelo painel (edição de usuário). Os próximos usuários saem pelo painel.

### Regras

- A senha do banco de produção fica só com quem administra o banco (Luís) e com quem publica o backend. Nunca em repositório, Trello, print ou documento compartilhado. Se vazar, troque em **Roles → Reset password** no Neon e atualize o backend publicado.
- Ninguém aponta o backend local para produção. Teste é no banco local.
- Nunca rode o backend com o perfil `dev` ligado ao banco de produção: ele grava os dados de demonstração.
- A primeira requisição depois de um tempo parado demora um pouco mais, porque o Neon religa o processamento. Antes da apresentação, abra o sistema alguns minutos antes.
- O plano gratuito guarda pouco histórico para restauração. Antes da apresentação, faça uma cópia com `pg_dump`.
