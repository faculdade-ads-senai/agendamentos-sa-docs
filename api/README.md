# Contrato da API — Agendamentos SA

[openapi.yaml](openapi.yaml) é o contrato REST (OpenAPI 3.0.3, versão 1.4.0) usado pelo backend, pelo painel web e pelo app. Front e back podem trabalhar ao mesmo tempo olhando para ele: o front monta a tela pelos campos e exemplos, e o back implementa a rota com os mesmos nomes e códigos.

## Como ver

- Em [editor.swagger.io](https://editor.swagger.io): File → Import URL → `https://raw.githubusercontent.com/faculdade-ads-senai/agendamentos-sa-docs/main/api/openapi.yaml`. Mostra as rotas, os campos, os exemplos e os erros.
- No VS Code, a extensão "OpenAPI (Swagger) Editor" mostra o arquivo navegável.
- Para importar no Postman ou no Insomnia: Import → arquivo `openapi.yaml`. Gera uma coleção com todas as rotas.

## Como ler

- Cada operação tem `x-status`: `implementado` (existe no código; `x-origem` diz se está na `master` ou no PR #2) ou `planejado` (ainda não existe).
- Base local: `http://localhost:8080/api/v1`.
- Datas e horas em ISO-8601 com fuso; a tela mostra em `America/Sao_Paulo`.
- Listas paginadas recebem `page`, `size` e `sort` e devolvem `content`, `page`, `size`, `totalElements` e `totalPages`.
- Erros seguem o ProblemDetail do Spring (`type`, `title`, `status`, `detail`, `instance`), com a lista `erros` (`campo`, `mensagem`) quando a validação falha. Quando usar cada código (400, 401, 403, 404, 409 e 422) está na tabela **Códigos de erro**, no topo do `openapi.yaml`. É o único lugar com essa regra: o Trello e os outros documentos apontam para lá.

## Como mudar

Mudança de rota, campo ou código de resposta entra por PR neste repositório, junto com o PR do backend que a implementa. O frontend só começa a usar uma rota nova depois que ela estiver aqui.
