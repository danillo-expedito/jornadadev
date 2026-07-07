# Pílula #02 — Variáveis

## O que foi feito

Declaração das primeiras variáveis em Harbour usando `LOCAL`, cobrindo três
tipos primitivos da linguagem:

| Variável | Tipo      | Exemplo             |
|----------|-----------|---------------------|
| `cNome`  | Caractere | `"Danillo Expedito"`|
| `nIdade` | Numérico  | `25`                |
| `dNasc`  | Data      | `CToD("10/09/2000")`|

Os nomes seguem a **notação húngara** (prefixo indica o tipo: `c` = caractere,
`n` = numérico, `d` = data), convenção padrão no ecossistema xBase e adotada
também no ADVPL/Protheus.

## Conceitos aplicados

- `LOCAL` — escopo de variável restrito à função
- `:=` — operador de atribuição
- `CToD()` — conversão de string para o tipo Data
- `?` — impressão no console com quebra de linha
- `SET DATE BRITISH` — formato de data `dd/mm/yyyy`
- `SET CENTURY ON` — exibição do ano com 4 dígitos

## Formato de data

Por padrão, o Harbour interpreta datas no formato americano (`mm/dd/yyyy`).
Sem configuração, `CToD("10/09/2000")` seria armazenado como **9 de outubro**
— e o erro passaria despercebido, pois a exibição usa o mesmo formato e
imprime a data igual à string digitada. Para o formato brasileiro:

```harbour
SET DATE BRITISH
SET CENTURY ON
```

## Ordem das declarações

Em Harbour, toda declaração `LOCAL` deve vir **antes de qualquer
comando executável** da função. Como `SET DATE` é um comando, a solução foi
declarar `dNasc` sem valor e atribuir com `CToD()` somente após configurar o
formato de data — garantindo que a conversão já use `dd/mm/yyyy`:

```harbour
LOCAL dNasc          // declaração (nasce NIL)
SET DATE BRITISH     // configura o ambiente
dNasc := CToD("10/09/2000")  // atribuição no formato correto
```

## Como executar

```bash
hbmk2 -run variaveis.prg
```

## Referências

- [Documentação oficial do Harbour](https://harbour.github.io/doc/)
- [Curso de Harbour 2ª ed. — SAGI ERP (PDF)](https://sagierp.com.br/devel/aulas/Harbour2ed.pdf)