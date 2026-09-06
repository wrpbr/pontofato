---
type: "API"
title: "API do PontoFato"
description: "Superfície HTTP e MCP do PontoFato, com o modelo de cobrança."
resource: "https://pontofato.com/api/"
---

# API do PontoFato

Base: https://pontofato.com

## Como pagar

Lookup de CEP, ponto, raio e empresas é grátis. Vizinhança por raio (`/api/vizinhanca`) custa $0.05 por chamada depois de 10 chamadas grátis por dia por IP; contato de agente custa $0.10. Os dois aceitam x402 por requisição ou crédito pré-pago (`POST /api/credito?usd=10`), que vale em todos os produtos da casa.

## Endpoints

* `GET /okf/:arquivo` — Bundle OKF (Open Knowledge Format v0.1): markdown com frontmatter para o agente ler o produto inteiro sem parsear HTML.
* `GET /.well-known/:arquivo` — Descoberta de máquina antes da home: `api-catalog` (RFC 9727, linkset com a API e o MCP), `security.txt` (RFC 9116) e `mcp-registry-auth` (chave do registro oficial de MCP).
* `GET /apis.json` — APIs.json (apisjson.org, 0.19): o índice que o APIs.io colhe — a API, o MCP, OpenAPI, guia e bundle OKF num arquivo só. Também em `/.well-known/apis.json`.
* `GET /api/` — Índice auto-descrito: cada rota, o que cobra e como plugar o MCP.
* `GET /api/health` — Saúde da origem sqlite e cobertura por UF.
* `POST /mcp` — MCP Streamable HTTP — as tools deste catálogo, despachadas neste mesmo Worker.
* `GET /api/cep/:cep` — Pontos CNEFE de um CEP, com lat/lon IBGE — não é chute de mapa.
* `GET /api/cep/:cep/unidades` — Unidades CNEFE de um CEP, com complemento, espécie e id — paginado.
* `GET /api/proximo` — Ponto CNEFE mais perto de um par lat/lon. Sem default para (0,0).
* `GET /api/buscar` — Busca textual de logradouro (FTS5), com UF e cidade opcionais.
* `GET /api/empresas` — Estabelecimentos da Receita neste CEP (join no c3, teto 50).
* `GET /api/raio` — CEPs a N metros de um ponto, com distância e quantos endereços CNEFE cada um tem — raio em metros, não bairro em texto.
* `GET /api/vizinhanca` — Empresas ativas, abertas e baixadas num raio em metros, por CNAE, com as aberturas mais recentes e a distância de cada uma — o CNEFE dá o raio, a Receita dá o fato.
* `GET /api/local` — Cidade/UF de quem chama, pela borda Cloudflare. Sem cache.
* `POST /api/contact` — Contato: humano com Turnstile (grátis) ou agente com x402 $0.10.
* `GET /api/metrics` — Métricas dos últimos 7 dias para o painel do operador; com o token, inclui os pagamentos.
* `POST /api/credito` — Recarrega crédito pré-pago: paga uma vez com x402 e recebe o token que desconta em qualquer API da casa.
* `GET /api/credito` — Saldo e extrato do crédito — as últimas movimentações, sem devolver o token.

Catálogo completo: https://pontofato.com/llms-full.txt · OpenAPI: https://pontofato.com/openapi.json
