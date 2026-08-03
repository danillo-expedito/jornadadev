# Exercício 1 — AxCadastro × mBrowse

> ⚠️ **Nota de ambiente:** durante a configuração do campo `ZA1_NOMCLI` no
> Configurador (SIGACFG) desta versão (Protheus 8, build `7.00.050131A`,
> Fev/2005), **não existe** um campo "Relação" editável em nenhuma aba da
> tela de edição de campo (Campo, Informações, Opções, Validações, Uso,
> Módulos). O `X3_RELACAO` — que teoricamente permitiria a um campo Virtual
> se recalcular sozinho toda vez que a tela exibe o registro — simplesmente
> não é exposto na interface dessa versão do dicionário. Por isso, o
> recálculo do nome do cliente foi implementado via **Gatilho (SX7)** no
> campo `ZA1_CLIENT`, que dispara a mesma função `POSICIONE()` nas
> condições de inclusão/alteração. Essa constatação prática é retomada na
> resposta da pergunta (d).

---

## a. Quando usar AxCadastro e quando usar mBrowse?

O `AxCadastro` é a forma mais rápida de montar uma tela de manutenção (incluir, alterar, excluir, visualizar) de uma tabela, porque a estrutura vem pronta, montando tela de edição, menu de opções e todo o fluxo necessário para gravação dos dados, isso tudo, baseado no que está cadastrado no dicionário (SX3) da tabela. É utilizado quando o cadastro é simples e não precisa de nenhuma listagem sofisticada antes da edição.

O `mBrowse`, por outro lado, é utilizado quando você precisa dessa listagem customizada antes da tela de edição, com colunas específicas, legenda em cores, filtros e ordenação por índice. Um exemplo é o cadastro de Pets (ZA1): antes de editar, o usuário quer ver todos os pets de um cliente específico, com cores diferentes indicando, por exemplo, se a vacinação está em dia ou atradasada.

## b. Três coisas que o mBrowse faz e o AxCadastro não faz

1. **Legendas coloridas (aColors):** o mBrowse permite pintar linhas da
   grid de acordo com uma condição (ex.: vermelho para pet com vacina
   vencida), o que o AxCadastro sozinho não oferece.
2. **Escolha de índice/ordem na tela:** o mBrowse permite ao usuário
   trocar a ordem de exibição (por código, por cliente, etc.) diretamente
   na interface, navegando pelos índices (SIX) da tabela.
3. **Filtro e busca incremental na listagem:** o mBrowse oferece campos
   de busca/posicionamento incremental na própria grid, permitindo achar
   um registro digitando parte da chave, sem precisar abrir tela nenhuma.

## c. Por que a regra ".T." deve ficar por último no aColors?

O array `aColors` é avaliado item a item, na ordem em que foi declarado, e a primeira condição que retornar verdadeiro é a que define a cor da linha. Se a regra .T. viesse antes de todas as outras condições específicas, ela "venceria" a avaliação assim que fosse alcançada, e todas as outras regras colocadas após ela, não seriam testadas, e nesse caso toda a grid ficaria da cor declarada na condição. Por conta disso, a regra que é sempre .T., funciona como um padrão, como um DEFAULT de um DO/CASE, e deve ser posicionada ao final da lista de regras para cobrir os casos que nenhuma regra capturou.

## d. Diferença entre campo Virtual (X3_RELACAO) e Gatilho (SX7) para preencher o nome do cliente

Um campo **Virtual com Relação** (`X3_RELACAO`) é pensado para se recalcular automaticamente toda vez que a tela ou a grid exibe aquele registro, e por isso ele não grava nada na tabela, só existe em tempo de exibição,e por isso reflete o valor mais atual do campo de origem (aqui, o nome do cliente na SA1) mesmo que o `ZA1_CLIENT` tenha sido alterado depois.

Já o **Gatilho (SX7)** é um mecanismo que dispara em momentos específicos do fluxo de gravação. Nas condições configuradas, por exemplo `INCLUI.OR.ALTERA` ele funciona recalculando e posicionando um valor em outro camponaquele instante. A diferença prática é que o Gatilho depende de um evento (incluir ou alterar) para rodar, enquanto a Relação (quando disponível) recalcula sempre que a informação é exibida, independente de estar em modo de edição.

No caso concreto deste exercício, como a versão do Configurador em uso não expõe o campo Relação na interface (ver nota no topo do documento), o Gatilho acabou sendo a única alternativa funcional disponível para manter o `ZA1_NOMCLI` atualizado a partir do `ZA1_CLIENT` + `ZA1_LOJA`.
