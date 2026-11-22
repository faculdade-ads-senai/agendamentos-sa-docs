> Este relatório registra a etapa OAuth 1.4.0. A entrega posterior de cadastro 1.5.0 e seus resultados estão em [RELATORIO-DADOS-PESSOAIS.md](RELATORIO-DADOS-PESSOAIS.md).

# Entrega da integração — 22/11/2026

## Diagnóstico e resultado

O frontend usava JWT em sessionStorage, senha e mocks fixos. O backend já tinha OIDC/sessões/convites, mas ainda continha consumidores JWT ativos que impediam compilar/iniciar sem o modelo antigo. O OpenAPI 1.3.0 descrevia JWT, enquanto requisitos e guias recentes descreviam sessões. A instrução final e o enum do OpenAPI definem ADMIN; a implementação recente usava ADMINISTRADOR.

Foi implementado login por navegação ao backend, recuperação do usuário por sessão, transporte HTTP com cookies/CSRF, logout no servidor, formulários sem senha e emissão/cópia de convite. O perfil foi alinhado a ADMIN por V6, preservando V1–V5, registros e vínculos. Não foram adicionadas bibliotecas ou telas de negócio novas.

Classificações e contratos por operação estão na [matriz atualizada](CONFORMIDADE.md). O [OpenAPI 1.4.0](openapi.yaml) é a referência atual; o contrato substituído foi preservado em `historico/openapi-1.3.0.yaml`.

## Arquivos desta entrega

Os caminhos abaixo são relativos aos respectivos projetos. O workspace já tinha alterações anteriores; esta lista identifica o trabalho desta integração, sem atribuir todo o diff preexistente a ela.

### Frontend

| Arquivo | Responsabilidade |
|---|---|
| `src/http.js` | Transporte central, JSON/204, credenciais, CSRF compartilhado, renovação limitada, 401/403 e erros de rede |
| `src/api.jsx` | Serviços por sessão, URL do login, logout e convites; retirada de Bearer, senha e persistência JWT |
| `src/main.jsx` | Bootstrap de sessão, Google, expiração, logout confirmado e mensagens seguras; limpeza das chaves legadas |
| `src/users/Users.jsx` | CRUD preservado, geração/cópia de convite, estado de ativação e campos protegidos |
| `src/users/validation.js` | Validação sem senha; perfis ADMIN/MEDICO/PACIENTE |
| `src/account/Profile.jsx` | Atualização somente do nome, e-mail Google somente leitura e proteção de componente desmontado |
| `src/mock.js` | Sessão simulada em memória, CSRF, logout, convites e proteções locais de cadastro |
| `src/mockResources.js` | Remoção de credenciais de senha simuladas |
| `src/mock.json` | Dados sem senha/token, com Master e estado de ativação |
| `vite.config.js` | Proxy dos caminhos API/OAuth/convite, porta local e build ES2022 para importação condicional dos mocks |
| `.env.example` | Base configurável e modo mock explícito |
| `playwright.config.js` | Execução de interface contra API interceptada, sem mock silencioso |
| `test/auth.test.mjs` | Testes do transporte, cookies, CSRF, 401/403, rede e respostas inesperadas |
| `test/users.test.mjs` | Validação do contrato de usuários sem senha e perfis permitidos |
| `test/browser/auth.spec.js` | Login, bootstrap/reload, logout/falha, permissão, expiração, CRUD, convites e paginação |
| `README.md` | Entrada para execução, configuração e testes |

### Backend

| Arquivo | Responsabilidade |
|---|---|
| `src/main/java/com/agendaSa/auth/config/SecurityConfig.java` | Perfil ADMIN, retorno seguro de falhas OAuth e Problem Details com código de rejeição CSRF |
| `src/main/java/com/agendaSa/auth/service/MasterProvisioner.java` | Provisionamento do Master com perfil ADMIN |
| `src/main/java/com/agendaSa/shared/enums/Perfil.java` | Enum exclusivo ADMIN/MEDICO/PACIENTE |
| `src/main/java/com/agendaSa/convites/controller/ConviteController.java` | Convite inválido retorna ao frontend sem expor detalhes |
| `src/main/resources/db/migration/V6__padronizar_perfil_admin.sql` | Renomeia valor do perfil e atualiza CHECKs, preservando registros e Master |
| `src/main/resources/db/dev/R__dados_demonstracao.sql` | Dados de demonstração compatíveis com ADMIN |
| `src/test/java/com/agendaSa/ApplicationTests.java` | Expectativas ADMIN na aplicação e migração preservando relacionamentos |
| `src/test/java/com/agendaSa/auth/AuthControllerTest.java` | Contrato OIDC do usuário atual, substituindo testes JWT obsoletos |
| `src/test/java/com/agendaSa/auth/SecurityTest.java` | CSRF, CORS, logout, perfis e redirecionamentos seguros |
| `src/test/java/com/agendaSa/auth/IdentidadeGoogleServiceTest.java` | Ajuste das expectativas de perfil administrativo para ADMIN |
| `src/test/java/com/agendaSa/usuarios/UsuarioControllerTest.java` | DTOs atuais, enum, paginação, validação, respostas e exigência de CSRF |
| `src/test/java/com/agendaSa/usuarios/UsuarioServiceTest.java` | Proteções administrativas com perfil ADMIN |
| `src/test/java/com/agendaSa/usuarios/UsuarioPersistenceTest.java` | Suíte opcional adaptada para DTOs sem senha e migrações atuais |
| `.env.example` | Placeholders sem segredo real e sem Client ID formatado como URL |
| `API-USUARIOS.md`, `AUTENTICACAO.md` | Contratos atuais e nota de substituição dos comportamentos anteriores |

Removidos por serem exclusivos do fluxo substituído: `auth/service/AuthService.java`, `auth/config/JwtConfig.java`, `auth/config/DatabaseJwtAuthenticationConverter.java`, `auth/dto/LoginRequest.java`, `auth/dto/LoginResponse.java`, `usuarios/config/UsuarioPasswordConfig.java`, `usuarios/validation/SenhaValida.java` e `usuarios/validation/SenhaValidator.java` (todos sob `src/main/java/com/agendaSa/`). Sua manutenção causava erro de compilação por `Usuario.getSenha()` inexistente e dependência indevida de `app.jwt.secret`.

### Documentação

| Arquivo | Responsabilidade |
|---|---|
| `api/openapi.yaml` | Sessões/OIDC, CSRF, convites, DTOs sem senha, perfil ADMIN e status real dos módulos |
| `api/historico/openapi-1.3.0.yaml` | Preserva integralmente o contrato anterior |
| `api/CONFORMIDADE.md` | Matriz por endpoint e classificação de divergências |
| `api/INTEGRACAO-OAUTH.md` | Google Cloud, ambiente, execução, segurança, proxy, mocks e roteiro manual |
| `api/RELATORIO-INTEGRACAO.md` | Este relatório |
| `api/README.md` | Índice da versão atual e dos guias |
| `README.md` | Nota de atualização dos perfis e migrações |
| `requisitos/REQUISITOS.md` | Perfis atuais sem alterar regras de negócio |
| `arquitetura/ARQUITETURA.md` | Referência atual de autenticação e perfis |
| `banco-de-dados/AMBIENTES.md` | Nota das migrações e execução atual |
| `banco-de-dados/MODELO_DADOS.md` | Schema atual ADMIN/V6, preservando histórico V1–V5 |
| `banco-de-dados/validacao_restricoes.sql` | Validação SQL compatível com ADMIN e rejeição dos valores antigos |

## Autenticação e segurança

O botão navega para `/oauth2/authorization/google`; o Spring recebe o callback, valida OIDC e a identidade local e salva o contexto na sessão. Retorna ao frontend, que consulta `/api/v1/auth/me`. A mesma consulta restaura a interface após reload. O JavaScript nunca lê JSESSIONID ou tokens Google.

Escritas enviam o token de `/api/v1/auth/csrf` com o cabeçalho informado pelo servidor. Apenas rejeição identificada como CSRF permite uma repetição após renovação. Logout é POST com CSRF e confirmação no servidor. 401 durante uso limpa estados protegidos; 403 de permissão não é confundido com expiração. Backend continua responsável por autorizar e reler atividade/perfil.

Cookies continuam HttpOnly; Secure e SameSite são configurados no servidor. CORS continua com origens explícitas e credenciais habilitadas. Nenhuma segurança foi desabilitada. Falhas de navegação usam códigos fixos; erros internos não são mostrados ao usuário.

## Testes executados

| Verificação | Resultado |
|---|---|
| `npm ci` | Sucesso, sem novas dependências |
| `npm run build` (API real e mock explícito) | Ambos passaram; build final em modo real |
| `npm test` | 6 passaram |
| `PLAYWRIGHT_CHANNEL=msedge npm run test:e2e` | 7 passaram, API interceptada |
| `mvn clean test` e execução final `mvn test` | Compilação passou; execução final: 71 descobertos, 68 executados com sucesso, 3 opcionais ignorados |
| PostgreSQL temporário da suíte padrão | Aplicação/Flyway, unicidade, ativação concorrente e preservação de vínculos passaram |
| Parse do OpenAPI e referências locais | YAML válido; 25 caminhos e 176 referências resolvidas |
| `git diff --check` frontend/documentação | Sem erros de whitespace |

As primeiras execuções identificaram código/testes JWT obsoletos, classes antigas em `target` e um seletor ambíguo no teste de interface. Foram corrigidos; a tabela informa a execução final. Chromium do Playwright não estava instalado; a suíte final utilizou Edge existente. O wrapper Maven falhou antes de iniciar; foi usado Maven 3.9.16 instalado com Java 21. Não existe comando de lint configurado no frontend.

O script SQL documental de restrições foi atualizado, mas não foi executado manualmente contra um banco. Os 3 testes opcionais exigem propriedades `usuario.postgres.tests` e banco externo de teste; não foram contabilizados como aprovados.

## Configuração e pendências reais

As variáveis e os comandos completos estão no [guia de execução](INTEGRACAO-OAUTH.md). No frontend: `VITE_API_BASE_URL`, `VITE_USE_MOCK` e `API_PROXY_TARGET`. No backend: banco, cliente Google, MASTER_EMAIL, URLs públicas, CORS e parâmetros de cookie/sessão/convite.

- Configurar credenciais válidas e consentimento no Google Cloud e executar o roteiro manual de login/cancelamento/convites em conta real. Não houve validação contra Google real ou produção.
- Revogar/substituir o segredo Google que constava no exemplo anterior; a remoção do arquivo não o revoga.
- Integrar os módulos de médicos, agendas, agendamentos e notificações ausentes neste checkout para testar suas telas com API real. Isso é uma pendência preexistente de implementação, não de autenticação; telas e contratos foram preservados.
- Validar a publicação HTTPS, domínios, CORS, callback e cookies na hospedagem escolhida. Nenhum deploy ou alteração de banco de produção foi realizado.
