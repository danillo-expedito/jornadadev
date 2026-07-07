# Pílula #10 — Estruturas Condicionais (IF/ELSEIF/ELSE)

## O que foi feito

Implementação de estruturas de tomada de decisão em Harbour utilizando as palavras-chave `IF`, `ELSEIF`, `ELSE` e `ENDIF`. Foram criados três cenários práticos para explorar fluxos condicionais numéricos, manipulação de médias com arrays e condicionais com operadores lógicos:

| Arquivo | Cenário | Variáveis Aplicadas |
|----------|-----------|---------------------|
| `condicionais-1.prg` | Validação de saldo para compras | `nSaldo`, `nValorItem1`, `nValorItem2` |
| `condicionais-2.prg` | Cálculo de média aritmética e aprovação escolar | `aNotasAluno1`, `aNotasAluno2`, `nMediaAluno1`, `nMediaAluno2` |
| `condicionais-3.prg` | Decisão baseada em previsão do tempo | `lTemPrevisaoDeChuva`, `lEstaChovendo` |

Os nomes seguem a **notação húngara** (prefixos: `n` = numérico, `a` = array/vetor, `l` = lógico/booleano), alinhados com as boas práticas globais do ecossistema xBase, ADVPL e Protheus.

## Conceitos aplicados

- `IF` / `ELSEIF` / `ELSE` / `ENDIF` — blocos de controle de fluxo condicional
- `[ ]` — indexação e acesso a posições de um Array (base 1 no Harbour)
- Operadores relacionais (`>=`) e lógicos (`.OR.`)
- `?` — impressão no console com quebra de linha

## Particularidades da Sintaxe

Em Harbour e ADVPL, toda estrutura condicional `IF` obrigatoriamente deve ser encerrada com a palavra-chave `ENDIF`. Diferente de linguagens como C, C++ ou Java, que utilizam chaves `{}` para delimitar escopos, as linguagens da família xBase utilizam delimitadores textuais explícitos. 

Outro detalhe crucial observado no arquivo `condicionais-2.prg` é que **os arrays em Harbour começam com o índice 1** (`aNotasAluno1[1]`), e não com o índice 0 como na maioria das linguagens de programação modernas.

## Como executar

```bash
hbmk2 -run condicionais-1.prg
hbmk2 -run condicionais-2.prg
hbmk2 -run condicionais-3.prg
```

## Referências

- [Documentação oficial do Harbour](https://harbour.github.io/doc/)
- [Curso de Harbour 2ª ed. — SAGI ERP (PDF)](https://sagierp.com.br/devel/aulas/Harbour2ed.pdf)