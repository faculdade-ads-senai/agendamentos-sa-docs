# Contrato da API — Agendamentos SA

[openapi.yaml](openapi.yaml) é o contrato REST (OpenAPI 3.0.3, versão 1.5.0) usado pelo backend, pelo painel web e pelo app.

## Como ver

- Cole o conteúdo em [editor.swagger.io](https://editor.swagger.io) para ver as rotas e testar os exemplos.
- No VS Code, a extensão "OpenAPI (Swagger) Editor" mostra o arquivo navegável.
- Para importar no Postman ou no Insomnia: Import → arquivo `openapi.yaml`. Gera uma coleção com todas as rotas.

## Como ler

- Cada operação tem `x-status`: `implementado` (existe no código; `x-origem` diz se está na `master` ou no PR #2) ou `planejado` (ainda não existe).
- Base local: `http://localhost:8080/api/v1`.
- Datas e horas em ISO-8601 com fuso; a tela mostra em `America/Sao_Paulo`.
- Listas paginadas recebem `page`, `size` e `sort` e devolvem `content`, `page`, `size`, `totalElements` e `totalPages`.
- Erros seguem o ProblemDetail do Spring (`type`, `title`, `status`, `detail`, `instance`), com a lista `erros` (`campo`, `mensagem`) quando a validação falha. 400 é formato ou campo inválido, 409 é conflito (por exemplo, horário já ocupado) e 422 é regra de agenda violada.

## Como mudar

Mudança de rota, campo ou código de resposta entra por PR neste repositório, junto com o PR do backend que a implementa. O frontend só começa a usar uma rota nova depois que ela estiver aqui.

## Integração atual

Login exclusivamente Google OIDC, sessão HTTP e CSRF. Perfis ADMIN, MEDICO e PACIENTE; não há recepcionista. [Matriz de conformidade](CONFORMIDADE.md), [execução e Google Cloud](INTEGRACAO-OAUTH.md) e [contrato legado 1.3.0](historico/openapi-1.3.0.yaml). O histórico descreve decisões substituídas e não deve orientar novas integrações.

[Cadastro completo 1.5.0, criptografia e configuração de chaves](DADOS-PESSOAIS.md).
