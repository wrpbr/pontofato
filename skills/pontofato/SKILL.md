---
name: pontofato
description: Find Brazilian addresses and the companies around them with PontoFato (pontofato.com). Look up a CEP for its addresses with IBGE coordinates (CNEFE 2022) and census data, search a street by name, find the address nearest to a coordinate, list the units of a building, list the CEPs within a radius, list the companies registered at a CEP and count active, opened and closed companies by activity (CNAE) within up to 2 km. Use when a task mentions CEP, endereço, coordenadas, latitude and longitude in Brazil, geocoding, IBGE, CNEFE, vizinhança or companies near a place.
license: MIT-0
compatibility: Needs HTTPS access to pontofato.com. Works with the remote MCP server or with plain HTTP calls.
---

# PontoFato

PontoFato links Brazilian postal codes (CEP) to the address points of the IBGE 2022 Census (CNEFE) and to the
companies registered at each CEP. Use it to put an address on the map and to see the businesses around it.

## Connect

- MCP server (preferred): `https://pontofato.com/mcp?checkout=site`. Transport: Streamable HTTP. The free tools
  need no key. With `checkout=site`, the person buys on the site and the agent never pays.
- HTTP API: base URL `https://pontofato.com`. Each MCP tool calls one route of this API.
- If the MCP tools are not available, call the HTTP routes with `curl` or with your fetch tool.
- Discovery: `GET https://pontofato.com/api/` lists the routes, prices and limits.
  `https://pontofato.com/llms-full.txt` has the full reference.

## MCP tools

| Tool | HTTP | Use it to | Cost |
|---|---|---|---|
| `cep` | `GET /api/cep/{cep}` | List the addresses of a CEP with latitude, longitude and the census tract data of each building. | Free |
| `unidades` | `GET /api/cep/{cep}/unidades` | List each unit (apartment, shop) of a CEP with its complement. Paginated. | Free |
| `buscar` | `GET /api/buscar` | Find a street by name (`q`), with optional `uf` and `cidade`. Up to 20 results. | Free |
| `proximo` | `GET /api/proximo` | Find the address nearest to `lat` and `lon`. | Free |
| `empresas` | `GET /api/empresas` | List the companies registered at a CEP, 50 per page. | Free |
| `raio` | `GET /api/raio` | List the CEPs within `raio` meters (1 to 2000) of a CEP or a coordinate. | Free |
| `vizinhanca` | `GET /api/vizinhanca` | Count active, opened and closed companies by CNAE within a radius, with the latest openings. | Read `quota.free_now` |
| `consulta_cnpj` | `GET /api/consulta/cnpj/{cnpj}` | Check a company: Receita record, sanctions and the map point of its address. | Daily free allowance, then balance |
| `consulta_cep` | `GET /api/consulta/cep/{cep}` | Get up to 20 addresses and 20 companies of a CEP in one lookup. | Daily free allowance, then balance |
| `consulta_planos` | `GET /api/consulta` | Read the free allowance of today, the plans and your balance. | Free |
| `api_index` | `GET /api/` | Read the routes, the prices and `quota.free_now`. | Free |
| `pricing` | `GET /api/pricing` | Read the current prices and free allowances. | Free |
| `health` | `GET /api/health` | Read the coverage by state. `cobertura.completa` is true only with all 27 states. | Free |

## Rules

1. A CEP has 8 digits. An invalid CEP returns HTTP 400. A valid CEP that is not in the data returns 404 with
   `cobertura`.
2. CNEFE is an observation from 2022. It does not prove that a CEP or an address is valid today.
   Do not mix it with postal address data (DNE or ViaCEP).
3. Do not send `lat=0` and `lon=0` as a default value. If you do not have a coordinate, ask for it or use a CEP.
4. Do not merge units only by street number. Keep `complemento` and `cod_unico_endereco`.
5. The companies are matched to addresses by CEP. A company distance is a CEP distance, not the exact building.
6. Opened and closed counts use the Receita data date in `base.dump_date`. The default window is the 90 days
   before that date, not before today. Read the field before you say that a street stopped growing.
7. Before `vizinhanca`, read `quota.free_now` from `api_index`. If it includes `vizinhanca` or `*`, the call is
   free. If not, read the price and get the approval of the user first.
8. Before a call that spends balance, read the price from `pricing` or `consulta_planos`.
   Do not spend balance until the user approves the item and the amount.
9. Never pay by yourself. If a call returns HTTP 402, show the price and https://pontofato.com/pricing to the
   user. The person buys on the site. After the purchase, send the same call again with the person's prepaid
   credit token in the header `Authorization: Bearer cred_…`. Keep the same `Idempotency-Key` when you retry.
10. Keep tokens (`cred_…`, `mmk_…`) secret. Do not write them in files, logs or answers.
11. If you get HTTP 429 or 503, wait for the time in `Retry-After` and try once more.

## Buy

- The person buys on the site: https://pontofato.com/pricing shows the lookup plans, the packs and the prepaid
  credit, with the prices. Plans do not renew automatically.
- `consulta_planos` and `pricing` read the plans and the prices. They do not charge.
- A prepaid credit gives a `cred_…` token one time only. The same token works in PontoFato, Radar CNPJ and
  EditalMD.

## Examples

```bash
# Addresses of a CEP, with coordinates (free)
curl -s https://pontofato.com/api/cep/01310100

# CEPs within 300 m (free)
curl -s 'https://pontofato.com/api/raio?cep=01310100&raio=300'

# Restaurants (CNAE 5611201) within 500 m
curl -s 'https://pontofato.com/api/vizinhanca?cep=01310100&raio=500&cnae=5611201'
```

## Limits

- Address data: IBGE CNEFE 2022. Company data: the public Receita Federal dump, with its date in `base`.
- Terms: https://pontofato.com/termos. Privacy: https://pontofato.com/privacidade.
  Contact: contato@pontofato.com.
