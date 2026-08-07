# TCC — Controle de Não Conformidades ISO 9001 (Protheus/ADVPL)

**Curso:** START 2026 — Jornada DEV, trilha Harbour → ADVPL/Protheus
**Autor:** Danillo Santos
**Ambiente:** MP8 — Build 7.00.050131A (Protheus 8, ~2005), rodando em VM Windows 10

---

## 1. Sobre o projeto

A Indústria XYZ (cenário fictício do enunciado) precisa monitorar não conformidades
na entrada de materiais de fornecedores, como parte do processo de certificação ISO
9001. Este projeto implementa, dentro do módulo de Compras (SIGACOM) do Protheus,
duas tabelas customizadas e as rotinas necessárias para:

- Cadastrar e acompanhar o **certificado de qualidade** de cada fornecedor, com
  alerta visual de vencimento (tabela `ZZ1` - Controle de Fornecimento).
- Registrar as **ocorrências de (não) conformidade** em cada entrega, vinculadas ao
  fornecedor e ao certificado correspondente, com alerta visual quando o percentual
  de itens não conformes ultrapassa a tolerância definida (tabela `ZZ2` -
  Ocorrências do Fornecedor).

## 2. Estrutura de dados

### ZZ1 — Controle de Fornecimento

10 campos (filial, código, fornecedor/loja, nome do fornecedor`virtual`, dados e
validade do certificado, tolerância, totais conforme/não conforme), 3 índices
(chave primária, por fornecedor, por validade do certificado).

### ZZ2 — Ocorrências do Fornecedor

13 campos (filial, controle vinculado à ZZ1, fornecedor/loja, nome do fornecedor`virtual`,data/hora, produto, quantidades conforme/não conforme, valor unitário,
totais em R$ `virtuais`), 3 índices (chave primária, por fornecedor e data, por
data).

A estrutura completa de campos e índices segue exatamente o layout definido no
enunciado do TCC; os desvios pontuais (explicados na seção 4) foram
todos em **regras de validação e gatilho**, não na estrutura de dados em si.

## 3. Arquitetura dos fontes


| Arquivo        | Responsabilidade                                                                                                                                                    |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `STTZZ1.PRW`   | mBrowse da ZZ1 (legenda por vencimento de certificado),`IncZZ1` (inclusão protegida por `BEGIN SEQUENCE`) e `ExcZZ1` (exclusão bloqueada se houver ZZ2 vinculada) |
| `STTZZ2.PRW`   | mBrowse da ZZ2 (legenda por % não conforme vs. tolerância),`STTZZ2FLT` (versão filtrada, chamada pelo botão "Ocorrências" da ZZ1)                              |
| `STTZZLIB.PRW` | Biblioteca de funções comuns:`NomeFornecedor`, `NomeProduto`, `PercNaoConforme`, `CertificadoVencendo`, `InicNomeForn`, `GravarLogTCC` e a classe `LogTCC`        |

Todas as fórmulas que originalmente estariam "espalhadas" pelo dicionário de dados
(gatilhos, Inic. Browse, Inic. Padrão, legendas) foram centralizadas em chamadas às
funções da `STTZZLIB`, evitando duplicação de lógica.

## 4. Processo de desenvolvimento

O desenvolvimento foi feito de forma incremental e testado a cada etapa diretamente
no ambiente real (SmartClient conectado ao MP8 na VM), em vez de escrever o projeto
inteiro e só depois testar. Essa abordagem foi o que permitiu identificar as
particularidades de comportamento desta build específica, descritas a seguir.

### 4.1 `xFilial()` funciona de forma diferente em `ExistCpo()` e em `POSICIONE()`

O enunciado pede validações como:

```
ExistCpo("SA2", xFilial("SA2")+M->ZZ1_FORNEC+M->ZZ1_LOJAFO, 1)
```

Essa regra, exatamente como escrita, retornava erro de registro não encontrado
mesmo com o fornecedor corretamente cadastrado. A primeira hipótese foi de que os
dados de teste fornecidos (`sa2990.dbf`) tivessem sido gravados com a filial física
preenchida, divergindo do que `xFilial()` retorna para uma tabela Compartilhada.

Essa hipótese caiu quando o mesmo problema se repetiu na validação de
`ZZ2_CONFOR` contra a **ZZ1**, uma tabela criada e populada durante desenvolvimento nesta
sessão, sem qualquer possibilidade de divergência de dado físico. Ainda assim, o
gatilho SX7 (que usa `POSICIONE()`, um mecanismo de busca por índice parecido)
funcionou normalmente **com** `xFilial()`.

**Conclusão registrada:** nesta build, `xFilial()` dentro de uma expressão
`ExistCpo()` executada no contexto de "Val Usuário" (validação de campo do
dicionário) não se comporta como esperado, mesmo sendo a sintaxe correta segundo a
documentação e o enunciado. Em `POSICIONE()` (usado nos gatilhos SX7), o mesmo
`xFilial()` funciona sem problemas. A causa exata (macro-execução, contexto de
compilação em runtime da expressão) não foi confirmada com certeza absoluta, o que
temos é o padrão comportamental reproduzido de forma consistente em 3 tabelas
diferentes (SA2, ZZ1, SB1).

**Solução aplicada:** as validações `ExistCpo()` foram configuradas sem
`xFilial()`. Os gatilhos SX7 mantiveram `xFilial()`, exatamente como o enunciado
pede, pois funcionam corretamente nesse contexto.

### 4.2 `BeginTran()`/`EndTran()` em volta de `AxInclui()`

A recomendação geral (e a documentação oficial) é evitar transação manual em volta
de uma rotina de tela padrão como `AxInclui`, pois ela já controla sua própria
transação internamente, e abrir uma interface gráfica com uma transação pendente é
arriscado. Na prática, **nesta build específica (MP8 2005)**, a combinação
funcionou sem problemas nos testes realizados. Documentei essa divergência da
prática recomendada porque decidi manter o código funcionando conforme testado
em vez de trocar por uma versão "teoricamente mais correta" sem evidência de que
resolveria algo, mas é um ponto que merece atenção em caso de portar este código
para uma versão mais nova do Protheus.

### 4.3 Consultas Padrão (SXB) não leem campos virtuais

O motor de Consulta Padrão lê diretamente o arquivo físico (`.dbf`). Um campo
`Virtual` (como `ZZ1_NOMEFO`) não existe fisicamente, só existe em memória durante
a tela ativa e sua presença como coluna de uma consulta padrão quebra a janela de
pesquisa (F3). A solução foi substituir o campo virtual, na configuração da coluna
da consulta, por uma **expressão ADVPL equivalente** (`POSICIONE(...)`), que o SXB
aceita e executa em tempo real ao montar a grade de resultados.

### 4.4 Retorno de múltiplos campos numa Consulta Padrão

Ao usar a lupa (F3) num campo, apenas o primeiro item da lista de "Retorno" da
consulta é preenchido automaticamente pelas telas genéricas (`AxInclui`/`mBrowse`).
Para que código **e** loja do fornecedor fossem preenchidos juntos ao escolher um
registro na consulta da SA2, foi necessário adicionar `SA2->A2_COD` **e**
`SA2->A2_LOJA`, nessa ordem, na lista de Retorno.

### 4.5 `Inic. Browse` vs. `Inic. Padrão`

Duas propriedades do campo, na aba Opções do dicionário, com efeitos diferentes:

- **Inic. Browse**: preenche o campo apenas na grade do `mBrowse` (listagem).
- **Inic. Padrão**: preenche o campo sempre que qualquer tela abre (Incluir,
  Visualizar, Alterar).

Para um campo virtual calculado (como `ZZ1_NOMEFO`/`ZZ2_NOMEFO`) aparecer
corretamente em **todos** os contextos de uso, os dois precisam ser configurados
com a mesma fórmula.

### 4.6 Erro `INITERR` ao excluir/visualizar registros

O gatilho SX7 (que dispara em eventos de tela) e o `Inic. Padrão`/`Inic. Browse`
(que dependem de variáveis de memória `M->`) quebravam ao excluir ou visualizar um
registro, porque essas variáveis simplesmente não existem fora dos modos de
Inclusão/Alteração. A correção foi criar a função `InicNomeForn(cTabela)` na `STTZZLIB.PRW`
que usa `Type("M->campo") == "C"` para decidir, em tempo de execução, se lê da
memória (tela em edição) ou do alias físico (`ZZ1->`/`ZZ2->`, exclusão/
visualização). Essa função também resolveu, de quebra, um limite de tamanho do
campo `Inic. Padrão` no dicionário, que não comportava a fórmula completa
originalmente escrita ali, a solução de mover a lógica para uma função de
biblioteca e deixar só a chamada curta no dicionário é o padrão recomendado quando
uma fórmula não cabe na caixa de texto do Configurador.

### 4.7 Gatilho autorreferente não dispara

Os gatilhos de `ZZ2_DATA` e `ZZ2_HORA`, como definidos no enunciado, têm o mesmo
campo como origem e destino (`IF(INCLUI, dDataBase, ZZ2->ZZ2_DATA)`). Esse padrão
autorreferente não disparou nesta build. A solução foi mover a mesma fórmula para
`Inic. Padrão`, que preenche o valor default na inclusão preservando o valor
existente na alteração, sem depender do evento de saída do campo.

## 5. Diferenciais implementados

- **Classe ADVPL (POO):** `LogTCC`, com construtor (`New`), atributos (`cLogPath`,
  `cMensagem`) e métodos (`SetMensagem`, `Gravar`), encapsulando a gravação do log
  técnico de erros.
- **Impedir exclusão de ZZ1 vinculada:** `ExcZZ1()` verifica, via `dbSeek` no
  índice 1 da ZZ2 (reaproveitado, sem criar índice novo), se existe alguma
  ocorrência vinculada ao controle antes de permitir a exclusão.
- **Reaproveitamento de código:** todas as fórmulas de busca/cálculo usadas em
  gatilhos, Inic. Browse, Inic. Padrão e legendas foram centralizadas em funções da
  `STTZZLIB.PRW`.
- **Legenda calculada:** a cor da legenda da ZZ2 é calculada em tempo real
  (`PercNaoConforme`, protegida contra divisão por zero) e comparada com a
  tolerância cadastrada no certificado (`ZZ1_TOLERA`) do controle vinculado.

## 6. Testes realizados

Todas as rotinas foram testadas manualmente no SmartClient, conectado ao ambiente
MP8 da VM, com dados de exemplo cadastrados durante o desenvolvimento (fornecedores,
produtos, controles de certificado e ocorrências). As evidências visuais (telas,
mensagens de erro capturadas durante o debug, e telas finais funcionando) estão na
pasta `evidencias/`.

## 7. Instrução de instalação

1. Restaurar/importar os arquivos de dicionário (`sx2990.dbf`, `sx3990.dbf`,
   `six990.dbf`, `sx7990.dbf`, `sxb990.dbf`) e as tabelas (`zz1990.dbf`,
   `zz2990.dbf`) na pasta de dados do ambiente Protheus.
2. Importar o menu `sigacom.xnu` no módulo SIGACOM via SIGACFG.
3. Compilar `STTZZLIB.PRW`, `STTZZ1.PRW` e `STTZZ2.PRW`, nessa ordem (a biblioteca
   precisa estar compilada antes das rotinas que a chamam).
4. Acessar o SIGACOM > Cadastros > Controle ISO 9001.

## 8. Agradecimentos

Agradeço à TOTVS Paulista pela oportunidade de participar do programa START 2026 —
Jornada DEV, e por toda a estrutura de ensino que tornou possível sair do zero em
Harbour até chegar a um projeto funcional em ADVPL/Protheus. Foi um processo
desafiador, cheio de comportamentos inesperados de uma build de 2005 que exigiram
investigação real em vez de simplesmente seguir a documentação ao pé da letra.
