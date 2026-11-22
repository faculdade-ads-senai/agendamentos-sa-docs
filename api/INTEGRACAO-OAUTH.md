> Pré-requisito adicional da versão 1.5.0: configurar as chaves de dados pessoais e aplicar V7. Consulte [DADOS-PESSOAIS.md](DADOS-PESSOAIS.md). OAuth e convites permanecem; cadastro administrativo agora exige CPF/nascimento para todos os perfis e PATCH próprio admite contato.

# Integração Google OIDC — execução e validação

Contrato atual: [OpenAPI 1.4.0](openapi.yaml). Diagnóstico e limites por endpoint: [matriz de conformidade](CONFORMIDADE.md). Perfis exclusivos: ADMIN, MEDICO, PACIENTE. O histórico 1.3.0 foi preservado em `historico/` e não descreve a autenticação atual.

## Configuração local

Requisitos: Java 21, Maven, Node compatível com Vite 7 e PostgreSQL 16+. Crie um banco local vazio, por exemplo `CREATE DATABASE agenda_sa;`, sem apontar o ambiente local para produção. Flyway aplica V1–V6; Hibernate apenas valida. Em banco existente, faça backup e revise a V5 (remoção histórica de senha) antes de atualizar. A nova V6 somente renomeia ADMINISTRADOR para ADMIN e mantém IDs, vínculos, Master e registros.

Na raiz do backend, copie `.env.example` para `.env` e configure:

| Variáveis | Uso |
|---|---|
| DB_HOST, DB_PORT, DB_NAME, DB_USERNAME, DB_PASSWORD | Banco local |
| GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET | Cliente OAuth Web; segredo apenas no servidor |
| GOOGLE_REDIRECT_URI | `http://localhost:8080/login/oauth2/code/google` |
| MASTER_EMAIL | E-mail Google real do administrador inicial |
| FRONTEND_URL | `http://localhost:5173` |
| BACKEND_URL | `http://localhost:8080`; base dos links de convite |
| CORS_ALLOWED_ORIGINS | `http://localhost:5173` (origens explícitas) |
| SESSION_COOKIE_SECURE | `false` somente no HTTP local; produção `true` |
| SESSION_COOKIE_SAME_SITE | `lax` para o desenvolvimento local e publicação no mesmo site |
| SESSION_TIMEOUT, INVITE_TTL | Padrões `30m` e `PT24H` |
| SERVER_PORT | Padrão 8080 |

No frontend, copie `.env.example` para `.env.local`:

```dotenv
VITE_API_BASE_URL=http://localhost:8080
VITE_USE_MOCK=false
API_PROXY_TARGET=http://localhost:8080
```

`VITE_API_BASE_URL` é a origem/base do backend, sem `/api/v1`; os serviços já acrescentam os caminhos completos. Nenhum segredo pode ter prefixo `VITE_`. Reinicie o Vite após mudar o ambiente.

Execute em terminais separados, partindo da pasta do workspace:

```powershell
cd agendamentos-sa-backend
mvn spring-boot:run
```

```powershell
cd agendamentos-sa-frontend
npm ci
npm run dev
```

O wrapper também existe (`.\mvnw.cmd spring-boot:run`), mas falhou ao inicializar neste ambiente. As verificações foram executadas com o Maven instalado. Não alteramos sua configuração preexistente.

## Google Cloud

Crie/selecione um projeto no Google Cloud e configure o consentimento/branding e o público. Em teste, adicione as contas necessárias como usuários de teste. Crie um cliente OAuth do tipo **Aplicativo da Web** e configure exatamente o redirect URI do backend acima. O Client ID é o identificador puro terminado em `.apps.googleusercontent.com`, sem `http://` ou barras. Guarde ID e Secret no ambiente do backend.

O fluxo é Authorization Code/OIDC no servidor com `openid,email,profile`. Não exige SDK Google no React nem origens JavaScript para uma chamada direta ao Google. Se outro componente usar SDK JavaScript, suas origens deverão ser cadastradas separadamente. O redirect URI precisa coincidir exatamente com o cliente Web, conforme a [documentação oficial Google](https://developers.google.com/identity/protocols/oauth2/web-server).

O `.env.example` antigo continha um segredo com aparência de credencial real. Foi substituído por placeholder; revogue/substitua esse segredo no Google Cloud e atualize seu `.env` privado. A remoção do exemplo não revoga a credencial já divulgada.

## Fluxo implementado

1. React consulta `/api/v1/auth/me` com cookies. Durante essa consulta, não mostra telas protegidas. 401 inicial representa visitante; outros erros são exibidos sem confundir falha de rede com expiração.
2. “Entrar com Google” navega para `/oauth2/authorization/google` no backend. O Spring valida state, nonce e ID token; a aplicação valida identidade local ativa e ativada. Master pode vincular o primeiro sub ao e-mail verificado configurado; os demais precisam de convite inicial.
3. O callback estabelece a sessão e retorna a FRONTEND_URL. React consulta novamente `me`. Nenhum JWT próprio, token Google ou cookie HttpOnly é manipulado/persistido em JavaScript.
4. Antes de escritas, o cliente obtém `/api/v1/auth/csrf` e usa `headerName` e `token`. O token fica em memória; consultas concorrentes compartilham a preparação. Uma rejeição 403 com `code=csrf_invalid` renova e repete no máximo uma vez; 403 de permissão e erros de rede não repetem escritas automaticamente.
5. “Sair” envia POST com CSRF para `/api/v1/auth/logout`. O Spring invalida a sessão e remove o cookie; o React limpa estados após 204. Se houver falha, consulta `me`: apenas 401 confirma ausência de sessão; outros resultados mantêm erro e possibilidade de tentar novamente. Logout não encerra a conta Google do navegador.
6. 401 durante uso encerra a interface protegida e informa expiração. O backend relê atividade e perfil por requisição. Atualização própria e 403 administrativo consultam novamente os dados do usuário. Master e e-mail vinculado continuam protegidos pelo servidor.

Falhas OAuth retornam `auth_error=login_failed`; convite inválido retorna `auth_error=invite_invalid`. A interface consome esses parâmetros e mostra texto seguro. Cancelamento e conta não autorizada compartilham mensagem genérica, sem permitir enumerar cadastros.

Na administração, crie o usuário sem senha e use **Gerar convite** na listagem. A emissão retorna link e prazo; copiar é uma ação explícita, com seleção manual alternativa. Reemissão revoga o anterior. Envie o link por canal apropriado; não há envio automático de e-mail. Links não são persistidos no navegador ou analytics.

## Proxy, mock e publicação

Base vazia usa o proxy Vite para `/api`, `/oauth2`, `/login/oauth2` e `/convite`. Ele preserva cabeçalhos e cookies. O callback local continua no backend 8080; use sempre `localhost`, sem misturar com `127.0.0.1`, pois cookies são por host. Em produção, o proxy do servidor web deve encaminhar os mesmos caminhos se a base for vazia; o proxy Vite não faz parte dos arquivos estáticos publicados.

`VITE_USE_MOCK=true` ativa explicitamente a demonstração em memória, identificada na tela de login. Recarregar reinicia sessão e alterações simuladas. Os mocks não acessam Google e nunca substituem a API real após uma falha. Não use esse modo para validar OAuth.

Publique preferencialmente frontend e backend no mesmo site via HTTPS, com Secure=true, HttpOnly e SameSite=Lax. Configure URLs e CORS explícitos e o callback HTTPS exato no Google Cloud. Sites distintos podem exigir SameSite=None/Secure e ainda depender do bloqueio de cookies de terceiros; valide antes de adotar essa topologia. Configure o proxy de confiança/forwarded headers de acordo com sua hospedagem. Sessões ficam na instância; múltiplas instâncias exigem afinidade ou armazenamento compartilhado.

## Verificações

```powershell
# frontend
npm run build
npm test
# use Chromium instalado pelo Playwright ou Edge existente
$env:PLAYWRIGHT_CHANNEL='msedge'
npm run test:e2e

# backend (testes padrão incluem PostgreSQL temporário isolado)
mvn clean test
```

Os testes de interface interceptam a API e validam contratos e estados do React; não demonstram autenticação real Google. Os testes Spring exercitam a cadeia de segurança, início do OAuth, sessão, logout e CSRF. O teste de aplicação usa PostgreSQL temporário, sem acessar dados do usuário. A suíte de persistência opcional continua condicionada a `usuario.postgres.tests` e a um banco de teste separado.

Validação manual externa: entrar como Master; cadastrar usuário e abrir convite com a conta correta; cancelar login; tentar conta divergente/inativa; verificar cookie HttpOnly, atualização da página e requisições com cookies no DevTools; confirmar logout seguido de `GET /api/v1/auth/me` retornando 401; repetir no domínio HTTPS. Não registrar cookies, links de convite ou credenciais em capturas e logs compartilhados.

Médicos/agendas/agendamentos/notificações têm telas e contratos preservados, mas seus controllers estão ausentes neste checkout. Sua validação real depende da integração desses módulos, não apenas de configurar o Google Cloud. Não foram substituídos por implementações simplificadas.
