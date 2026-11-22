> Cadastro 1.5.0: aplicar V1–V7 e configurar chaves de dados no backend antes de iniciar. Não gerar chaves novas sobre banco existente sem rotação; [instruções de geração, backup e recuperação](../api/DADOS-PESSOAIS.md). Backups do banco e chaves correspondentes devem ser preservados separadamente.

> Atualização 22/11/2026: contrato atual 1.4.0, perfis ADMIN/MEDICO/PACIENTE e migrações V1–V6. V6 renomeia ADMINISTRADOR para ADMIN sem excluir registros. Menções à V5 e a perfis anteriores abaixo preservam o histórico. Execução e validação: [guia OAuth](../api/INTEGRACAO-OAUTH.md).

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
   GOOGLE_CLIENT_ID=<cliente-web-do-backend>
   GOOGLE_CLIENT_SECRET=<segredo-do-cliente-web>
   MASTER_EMAIL=<conta-google-verificada-do-administrador>
   GOOGLE_REDIRECT_URI=http://localhost:8080/login/oauth2/code/google
   FRONTEND_URL=http://localhost:5173
   BACKEND_URL=http://localhost:8080
   SESSION_COOKIE_SECURE=false
   ```

3. Rode o backend. Na primeira subida o Flyway aplica V1 a V5.
4. Para demonstração, configure primeiro as variáveis Google e MASTER_EMAIL. O script `scripts/demo-local.ps1` usa PostgreSQL na porta 5433 e banco `agenda_sa_demo`; o perfil dev carrega dados fictícios, sem senhas e sem acesso automático. Entre com a conta Google Master real e emita convites para contas reais. Não existem credenciais Demo@1234 ou login dev por senha. Não apague banco com dados para renovar datas; use apenas ambiente descartável quando precisar recriar a demonstração.
5. Para conferir as restrições do banco, rode [validacao_restricoes.sql](validacao_restricoes.sql) no DBeaver, pgAdmin ou psql. Ele desfaz tudo no fim.

Recriação de banco é somente para ambientes descartáveis e após conferir o destino. Bancos com dados devem receber migrações versionadas e backup.

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
5. Primeira subida: um `.env` com os dados de produção e o backend rodando **sem** o perfil `dev`. O Flyway cria a `flyway_schema_history` e aplica V1 a V5.

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

   Devem aparecer V1 a V5 com `success = true`.

7. Primeiro administrador: configure MASTER_EMAIL, GOOGLE_CLIENT_ID e GOOGLE_CLIENT_SECRET no serviço. Após Flyway V5, o ApplicationRunner cria o Master automaticamente e sem senha. Não execute o antigo criar-admin.sql. Cadastros comuns precisam de convite; o Master vincula seu primeiro sub ao e-mail Google verificado configurado.

### Configuração de autenticação publicada

- `GOOGLE_REDIRECT_URI=https://<backend>/login/oauth2/code/google` deve coincidir exatamente com o cliente OAuth Web do Google Cloud.
- Configure `FRONTEND_URL`, `BACKEND_URL` e `CORS_ALLOWED_ORIGINS` com os domínios reais. Use `SESSION_COOKIE_SECURE=true`; SameSite=Lax se estiverem no mesmo site, ou None + HTTPS se necessário e validado.
- `SESSION_TIMEOUT=30m` e `INVITE_TTL=PT24H` são os padrões. Não configure JWT_SECRET; não há JWT próprio.
- OIDC solicita apenas openid/email/profile. Google Cloud em teste exige test users; entrar no Google não dispensa cadastro/convite no Agenda SA.
- Guarde o client secret somente no backend. Valide sessão/cookies no APK e no domínio publicado; a integração mobile está pendente, sem fallback por token.
- Sessões são locais à instância: múltiplas instâncias exigem afinidade ou armazenamento compartilhado.

### Regras

- A senha do banco de produção fica só com quem administra o banco (Luís) e com quem publica o backend. Nunca em repositório, Trello, print ou documento compartilhado. Se vazar, troque em **Roles → Reset password** no Neon e atualize o backend publicado.
- Ninguém aponta o backend local para produção. Teste é no banco local.
- Nunca rode o backend com o perfil `dev` ligado ao banco de produção: ele grava os dados de demonstração.
- A primeira requisição depois de um tempo parado demora um pouco mais, porque o Neon religa o processamento. Antes da apresentação, abra o sistema alguns minutos antes.
- O plano gratuito guarda pouco histórico para restauração. Antes da apresentação, faça uma cópia com `pg_dump`.
