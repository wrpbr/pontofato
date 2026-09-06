import requests

r = requests.get("https://pontofato.com/api/cep/70040010", timeout=30).json()
p = r["pontos"][0]
print(p["lat"], p["lon"], p["especie_label"], p["setor"])

e = requests.get("https://pontofato.com/api/empresas", params={"cep": "70040010"}, timeout=30).json()
for x in e["items"][:5]:
    print(x["cnpjFormatted"], x["razaoSocial"], x["situacao"]["label"])
