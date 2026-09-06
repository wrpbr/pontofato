---
type: "FAQ"
title: "FAQ — PontoFato"
description: "Perguntas e respostas sobre o PontoFato, as mesmas publicadas na página."
resource: "https://pontofato.com/"
---

# Perguntas frequentes — PontoFato

## De onde vem a coordenada?

Do CNEFE, o Cadastro Nacional de Endereços para Fins Estatísticos do Censo 2022 do IBGE: 111 milhões de endereços com latitude e longitude, nas 27 unidades da federação. É a coordenada que o IBGE registrou na coleta, não uma aproximação por mapa.

## Isso substitui o ViaCEP ou o cadastro dos Correios?

Não. O CNEFE é um retrato do Censo de 2022: endereço criado depois disso não está aqui, e o CEP é o registrado na coleta. O PontoFato dá o que esses serviços não dão: a coordenada oficial por unidade, a espécie de cada endereço e as empresas registradas no CEP.

## Como sei quem está registrado num CEP?

Pelos dados abertos do CNPJ da Receita Federal, cruzados com o CEP consultado. Cada empresa vem com CNPJ, razão social, nome fantasia, atividade (CNAE) e situação cadastral. Ativas aparecem primeiro; baixadas e inaptas também, porque o histórico do lugar faz parte do fato.

## Com que frequência os dados mudam?

A base da Receita é recarregada duas vezes por semana a partir do dump oficial, e a data da carga em uso vem em toda resposta de vizinhança. O CNEFE é fixo: é o Censo 2022.

## O que é grátis e o que é pago?

CEP, endereço, ponto mais próximo, raio de CEPs e empresas por CEP são grátis. A vizinhança por raio, que agrega empresas por atividade em até 2.000 metros, tem dez consultas grátis por dia por endereço IP; depois custa US$ 0,05 por chamada, paga por requisição (x402) ou descontada de crédito pré-pago.

## Preciso criar conta?

Não. Nenhuma consulta exige cadastro. Quando uma rota cobra, a resposta 402 traz as duas formas de pagar: por requisição, com USDC na rede Base, ou com um token de crédito pré-pago que vale em todos os produtos da casa.
