# Exercício 07 — Gatilho de CEP (SX7)

## O que foi feito

Compilei o `stcep.prw` com F9 e rodei o `STCEPTESTE` no SmartClient antes de mexer em qualquer dicionário, só pra confirmar que a função respondia certo isolada. Depois fui no SIGACFG → Dicionário → Gatilhos e criei os três gatilhos no campo `A1_CEP`, um pra cada contra-domínio (`A1_BAIRRO`, `A1_MUN`, `A1_EST`), cada um chamando `U_STCEP()` passando o parâmetro certo ("BAIRRO", "CIDADE", "UF").

Testei no cadastro de Clientes (Incluir), digitando `13330-000` (um dos CEPs de exemplo que já estava na tabela do fonte, referente a Indaiatuba/SP) e saindo do campo com Tab. Os três campos (Bairrinho, Município, Estado) preencheram sozinhos, sem precisar tocar em nada. (print em anexo confirmando o resultado)

## Respostas

### a. Diferença entre campo, contra-domínio e regra

O **campo** é o gatilho em si, o "disparador" e no nosso caso, sempre o `A1_CEP`, porque é ele que o  usuário preenche e é a saída dele (Tab) que faz o gatilho rodar.

O **contra-domínio** é pra onde o resultado vai e cada um dos trêsgatilhos que criei tem um contra-domínio diferente (`A1_BAIRRO`, `A1_MUN`, `A1_EST`), mas todos "escutam" o mesmo campo `A1_CEP`.

A **regra** é o meio de campo entre os dois: a fórmula que pega o valor do campo gatilhante e calcula o que vai ser jogado no contra-domínio. Aqui, a regra é sempre uma chamada pra `U_STCEP()`, mudando só o segundo parâmetro conforme o que cada gatilho precisa devolver.

Resumindo: campo dispara → regra calcula → contra-domínio recebe.

### b. Por que `M->A1_CEP` e não `SA1->A1_CEP`

`M->` acessa a variável de memória, sendo o que o usuário acabou de digitar. `SA1->` acessaria o registro já gravado no
banco. No momento em que o gatilho dispara, o CEP ainda não foi salvo em lugar nenhum e só existe na tela, como memória. Se a regra tentasse ler de `SA1->A1_CEP`, ela pegaria o valor antigo (ou vazio, se for um cliente novo), porque o dado que acabei de digitar ainda não foi registrado.

### c. Dois problemas de deixar os CEPs dentro do fonte, em produção

**1. Manutenção/escala.** Os CEPs estão soltos dentro do `aTabCEP()`, dentro do próprio `.prw`. Isso significa que, pra cada CEP novo que precisar ser reconhecido, alguém teria que editar o código-fonte e recompilar. Isso não escala.

*Como eu resolveria:* tiraria essa lista do fonte e colocaria numa tabela própria do dicionário (uma `Z` qualquer, tipo `ZCEP`, com os campos CEP/Bairro/Cidade/UF). Aí o `U_STCEP()` passa a fazer um `Posicione()`/`SEEK` nessa tabela em vez de comparar contra um array fixo no código. Atualizar a base vira só importar dados novos, sem precisar tocar em código nem recompilar nada.

**2. Fica desatualizado.** Uma lista fixa no fonte "trava" a informação no dia em que foi escrita. Se CEP mudar (bairro novo, por exemplo), a fonte não tem como acompanhar isso sozinha.

*Como eu resolveria:* usaria um serviço externo (tipo ViaCEP) pra consultar em tempo real, com a tabela local funcionando como cache. Primeiro tenta achar localmente (rápido), se não achar, consulta a API
e já grava o resultado localmente pra próxima vez ser instantâneo. Isso
resolve os dois lados: não fica batendo toda hora numa API externa, e
também não fica preso a uma lista estática que nunca mais é atualizada.

### d. Se pedissem pra preencher também o `A1_COD_MUN`

1. Criaria um **quarto gatilho** no mesmo campo `A1_CEP`, com
   contra-domínio `A1_COD_MUN` e regra `U_STCEP(M->A1_CEP,"COD_MUN")`.
2. Ajustaria a função `U_STCEP()` pra reconhecer esse novo parâmetro
   `"COD_MUN"` e devolver o código do município.

O único porém é que a fonte de dados usada (seja o fonte fixo, seja minha tabela própria, seja uma API) precisaria ter essa informação disponível e nem toda base de CEP simplificada traz o código do município junto. Isso reforça de novo o ponto do item (c): trocar o fonte fixo por uma tabela de dicionário facilita muito adicionar esse tipo de coluna nova depois.
