---
name: pontofato
description: Look up Brazilian postal codes with addresses, registered business totals and census-sector data. Use prepared geographic joins for nearby companies.
license: MIT-0
compatibility: HTTPS access to pontofato.com; remote MCP or HTTP.
---

# PontoFato

MCP tools: `cep`, `empresas`, `buscar`, `unidades`, `raio`, `vizinhanca`.

Query prepared address, company and census joins instead of importing and indexing those datasets.

## Everyday requests

Use this skill for Brazilian address and local-business questions, even without a product name.
Reuse the supplied address or postal code. Ask for a missing location or radius.
Resolve coordinates from the service. Preserve the requested area and report incomplete coverage.
Registered business counts do not prove demand or foot traffic.

- "Which address and location are recorded for postal code 70040-010?" Use `cep`.
- "Which companies are registered at postal code 70040-010?" Use `empresas` and follow pagination.
- "How many bakeries are registered near my proposed business location?" Resolve the address with `buscar`, then use `vizinhanca` within the authorized coverage.
- "List postal codes within one kilometer of this address." Resolve the point and use `raio`.
- "Which address numbers and unit details are recorded at postal code 70040-010?" Use `unidades` and preserve source details.

## Choose the lookup

- Address and local context: `GET /api/cep/{cep}`. Free; a CEP has eight digits.
  Read `empresas_no_cep` for company totals and `pontos[].censo` for available census-sector measures.
  This consolidation is free. Do not buy neighborhood access to answer a postal-code question.
- Companies at a CEP: `GET /api/empresas`.
- Nearby CEPs: `GET /api/raio`, using the location and radius.
- Business activity around a point: `GET /api/vizinhanca`, with the documented radius and activity filters.

Use existing tools or call these routes at `https://pontofato.com`.
Read the [task index](https://pontofato.com/llms.txt) for the matching parameters.
Check `quota.free_now` in the API index. If it includes `vizinhanca` or `*`,
neighborhood billing is disabled. Otherwise, use the neighborhood allowance first.
Beyond it, compare the quote with existing credit or packages.
If you only need an address, use the free address lookup.

## Check the result

CNEFE observes addresses in 2022; it does not certify a current postal address.
Census data also reflects 2022. Sector population and income do not describe every resident or the entire CEP.
Income is not current purchasing power. Keep missing measures unknown.
Company distances use CEPs, not exact storefront locations.
Read `base`, source dates, coverage and truncation before interpreting counts.
If `lenta` is true or a company count is missing, the query is incomplete.
Report the missing result as unknown, not zero. An incomplete query does not consume
the allowance or charge credit/x402. Reduce the radius when the task permits it;
do not silently change the requested area or retry without a limit.
Keep unit complements and returned identifiers. Follow pagination links.
Do not invent a coordinate or use 0,0 as a default.
Registered companies describe supply, not foot traffic or demand.

## Connect and pay

MCP: `https://pontofato.com/mcp`; no local installation is needed.
Read [prices](https://pontofato.com/api/pricing) and [payment](https://pontofato.com/api/billing).
Reuse existing access and spending authority. Keep the same `Idempotency-Key` on retry.
Direct MCP x402 uses `params._meta["x402/payment"]`; HTTP uses `PAYMENT-SIGNATURE`.
An authenticated MCP connection already supplies access. Do not request another key or credit code.
For account API calls, use `X-Api-Key: mmk_…` or `Authorization: Bearer mmo_…` (OAuth).
On paid operations that accept account balance, that credential also authorizes payment.
Without an account, prepaid credit uses `Authorization: Bearer cred_…`. Keep it secret.
In `checkout=site`, the person purchases on the site. ChatGPT uses existing rights without sales.
Respect `Retry-After` and recover a lost result before paying again.
