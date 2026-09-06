# PontoFato

> Onde fica e quem está num CEP, das bases públicas do IBGE (CNEFE 2022) e da Receita.

**In English.** PontoFato answers two questions about a place in Brazil: where it is and who is there. The point comes from CNEFE, the address list IBGE walked for the 2022 Census (111 million addresses with an official coordinate, all 27 states); the fact comes from the open CNPJ data: the companies registered at that postal code. Free API without an account (radius neighbourhood beyond ten calls a day is paid); responses in Portuguese; remote MCP server.

**No ar:** https://pontofato.com · **Índice da API:** https://pontofato.com/api/ · **OpenAPI:** https://pontofato.com/openapi.json · **Servidor MCP:** https://pontofato.com/mcp · **Docs para agentes:** https://pontofato.com/llms.txt

## O que faz

O PontoFato responde duas perguntas sobre um lugar no Brasil: onde ele está e quem está nele.

O ponto vem do CNEFE, a lista de endereços que o IBGE percorreu no Censo de 2022, com a coordenada oficial de cada unidade — não é geocodificação por aproximação. O fato vem dos dados abertos do CNPJ da Receita Federal, recarregados duas vezes por semana: quem está registrado naquele CEP, ativas primeiro, mas também baixadas e inaptas, porque o histórico de um lugar faz parte do fato.

## Começo rápido (sem cadastro)

Pontos de um CEP com lat/lon do IBGE, espécie, setor censitário, quadra e face:

```bash
curl -s https://pontofato.com/api/cep/70040010
```

Empresas da Receita registradas no CEP:

```bash
curl -s 'https://pontofato.com/api/empresas?cep=70040010'
```

Ponto CNEFE mais próximo de uma coordenada:

```bash
curl -s 'https://pontofato.com/api/proximo?lat=-15.7891&lon=-47.8800'
```

CEPs num raio em metros:

```bash
curl -s 'https://pontofato.com/api/raio?cep=70040010&raio=500'
```

## Servidor MCP (remoto, sem instalar nada)

Streamable HTTP sobre a mesma API pública. Cada tool é uma chamada nesta API; o `operationId` do OpenAPI é o nome da tool. Cartão do servidor: `GET https://pontofato.com/mcp`.

Claude Code:

```bash
claude mcp add --transport http pontofato https://pontofato.com/mcp
```

Cursor (`.cursor/mcp.json`):

```json
{
  "mcpServers": {
    "pontofato": {
      "url": "https://pontofato.com/mcp"
    }
  }
}
```

Tools principais: `cep`, `unidades`, `proximo`, `buscar`, `empresas`, `raio`, `vizinhanca`.

## Preço

**Grátis.** Consulta de CEP, coordenada, unidades, ponto mais próximo, busca de logradouro, raio e empresas do CEP, sem cadastro; dez vizinhanças por raio por dia.

**Pago.** Vizinhança por raio além das dez chamadas por dia: US$ 0,05 por chamada, por requisição (x402) ou crédito pré-pago.

## O que não é

Não é geocodificação por aproximação, não é o DNE dos Correios (para o CEP de hoje, Correios) e não guarda o que você consulta.

## Arquivos deste repositório

| | |
|---|---|
| `README.md` | esta página |
| `openapi.json` | documento OpenAPI 3; `operationId` = nome da tool MCP |
| `llms.txt` | guia curto para agentes (rotas, auth, preço, MCP) |
| `llms-full.txt` | referência completa: parâmetros, corpo, resposta campo a campo, erros (quando publicada) |
| `apis.json` | índice APIs.json (APIs.io) |
| `mcp/server.json` | manifesto publicado no registro oficial de MCP (`com.pontofato/pontofato`) |
| `okf/` | bundle OKF: markdown com front-matter (índice, sobre, API, FAQ) |
| `examples/` | `curl.sh` e `python.py` com as chamadas grátis acima |

## Sobre este repositório

Este repositório espelha as superfícies públicas e legíveis por máquina do PontoFato, como servidas em https://pontofato.com: o documento OpenAPI, o guia `llms.txt`, o manifesto do registro MCP, o bundle OKF e o índice APIs.json. O produto em si não é código aberto; o espelho existe para a API e o servidor MCP poderem ser encontrados, lidos e linkados daqui. Os arquivos são regenerados das superfícies no ar (última sincronização: 2026-09-05); se algo aqui divergir do site, vale o site.

Issues e sugestões são bem-vindas aqui. Contato: contato@pontofato.com. Autor: Wendel ([@wrpbr](https://github.com/wrpbr)).
