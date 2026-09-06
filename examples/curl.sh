#!/usr/bin/env bash
# PontoFato — free calls, no account. Chamadas grátis, sem cadastro.
set -euo pipefail

# Pontos de um CEP com lat/lon do IBGE, espécie, setor censitário, quadra e face
curl -s https://pontofato.com/api/cep/70040010

# Empresas da Receita registradas no CEP
curl -s 'https://pontofato.com/api/empresas?cep=70040010'

# Ponto CNEFE mais próximo de uma coordenada
curl -s 'https://pontofato.com/api/proximo?lat=-15.7891&lon=-47.8800'

# CEPs num raio em metros
curl -s 'https://pontofato.com/api/raio?cep=70040010&raio=500'
