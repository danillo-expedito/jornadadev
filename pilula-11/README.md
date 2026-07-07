# Pílula #11 — Estruturas de Repetição (FOR EACH e WHILE)

## O que foi feito

Implementação de estruturas de repetição (loops) em Harbour para iteração e controle de fluxos de código. Foram criados dois cenários práticos para explorar as particularidades do loop controlado por coleção (`FOR EACH`) e do loop controlado por condição (`WHILE`):

| Arquivo | Estrutura | Propósito |
|----------|-----------|---------------------|
| `loop-for.prg` | `FOR EACH` / `NEXT` | Iteração simplificada sobre um array de números primos para acumular a soma de seus valores |
| `loop-while.prg` | `WHILE` / `ENDDO` | Criação de uma contagem regressiva de 10 a 1 baseada em decremento de variável |

Os nomes seguem a **notação húngara** (prefixos: `a` = array/vetor, `n` = numérico), mantendo a padronização e boas práticas exigidas no ecossistema xBase e ADVPL/Protheus.

## Conceitos aplicados

- `FOR EACH ... IN ... NEXT` — iteração direta sobre elementos de uma coleção sem uso de índices estruturados
- `WHILE ... ENDDO` — laço de repetição condicional (enquanto a expressão for verdadeira)
- `+=` e `--` — operadores de atribuição cumulativa e pós-decremento
- `?` — impressão no console com quebra de linha

## Particularidades da Sintaxe

Em Harbour e ADVPL, as estruturas de repetição possuem fechamentos textuais explícitos muito específicos: o bloco `FOR` é encerrado com `NEXT`, enquanto o bloco `WHILE` é obrigatoriamente fechado com `ENDDO`. 

O uso do `FOR EACH` demonstrado em `loop-for.prg` traz uma grande vantagem moderna para o ecossistema xBase: ele abstrai a necessidade de controlar manualmente a variável de índice do array (`aNumerosPrimos[nI]`) e evita erros clássicos de estouro de escopo (*out of bounds*), injetando o valor de cada posição diretamente na variável de referência (`nNumero`) a cada iteração.

## Como executar

```bash
hbmk2 -run loop-for.prg
hbmk2 -run loop-while.prg
```

## Referências

- [Documentação oficial do Harbour](https://harbour.github.io/doc/)
- [Curso de Harbour 2ª ed. — SAGI ERP (PDF)](https://sagierp.com.br/devel/aulas/Harbour2ed.pdf)