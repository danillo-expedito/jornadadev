# Exercício 2 — Estrutura da Tabela Customizada ZA1 (Cadastro de Pets)

## a. Campos da ZA1


| Campo        | Tipo         | Tamanho | Descrição                                                             |
| ------------ | ------------ | ------- | ----------------------------------------------------------------------- |
| `ZA1_FILIAL` | Caracter (C) | 2       | Campo obrigatório em toda tabela Protheus; define a filial do registro |
| `ZA1_NOME`   | Caracter (C) | 30      | Nome do pet                                                             |
| `ZA1_RACA`   | Caracter (C) | 30      | Raça do pet                                                            |
| `ZA1_DTNASC` | Data (D)     | 8       | Data de nascimento (formato AAAAMMDD)                                   |

## b. Índice ideal

**`ZA1_FILIAL + ZA1_NOME + ZA1_RACA`**

**Justificativa (analogia da lista telefônica)**: sem índice, buscar um nome seria varrer a tabela inteira registro por registro. Um índice ordena os dados como uma lista telefônica ordena nomes de A a Z, permitindo achar o registro quase instantaneamente. `ZA1_FILIAL` entra primeiro porque o Protheus sempre filtra as buscas pela filial logada.

`ZA1_RACA` foi incluída como terceira chave porque é comum existir mais de um pet com o mesmo nome (ex.: dois "Rex" cadastrados). Usar só `FILIAL + NOME` geraria muitos registros "empatados" no índice, exigindo uma varredura extra dentro do próprio grupo de nomes iguais para achar o pet certo. Acrescentando a raça, o índice já chega mais próximo do registro específico, reduzindo a ambiguidade.

## c. Por que o prefixo é "Z"

Tabelas de A a T são **padrão TOTVS**. O prefixo **Z é reservado para tabelas customizadas**, garantindo que atualizações do sistema nunca sobrescrevam ou apaguem as customizações do cliente, funcionando como um "escudo de proteção".

## d. Por que os campos começam com "ZA1_"

Prefixar cada campo com o alias da tabela evita ambiguidade:

- Na programação ADVPL, o desenvolvedor identifica de imediato a que tabela o campo pertence.
- No banco de dados, evita erro de *ambiguous column name*. Se `ZA1` e `SA1` tivessem ambos um campo genérico "NOME", uma consulta cruzando as duas tabelas não saberia a qual "NOME" se referir. Com o prefixo, fica 100% claro.
