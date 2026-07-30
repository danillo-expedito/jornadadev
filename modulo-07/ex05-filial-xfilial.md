# Exercício 5 — A1_FILIAL e xFilial()

## a. Por que existe o campo de filial em toda tabela Protheus

O Protheus é nativamente **multiempresa e multifilial**. O campo de filial (`A1_FILIAL` na SA1, `ZA1_FILIAL` na nossa tabela customizada) controla o **compartilhamento de dados**, definindo a quem cada registro pertence. Configurado no Dicionário de Dados (SIGACFG):

- **Tabela exclusiva**: campo preenchido com o código da filial logada (ex.: "01") — só aquela filial vê/edita o registro.
- **Tabela compartilhada**: campo gravado em branco — o registro fica disponível para todas as filiais do grupo.

Sem essa obrigatoriedade, o sistema não conseguiria segmentar consultas, misturando cadastros e comprometendo a segurança das informações.

## b. Papel da xFilial() e risco de "escrever a filial na mão"

`xFilial("SA1")` é um **interpretador dinâmico**: consulta o Dicionário de Dados, verifica se a tabela é Exclusiva ou Compartilhada, lê o ambiente do usuário logado e só então retorna o valor correto a ser gravado.

**Se o desenvolvedor gravasse a filial fixa no código (ex.: sempre "01")**:

- **Invalida o Dicionário de Dados**: se a regra de negócio mudar (ex.: passar de exclusiva para compartilhada), o Configurador não terá efeito algum sobre um código engessado — a customização quebra.
- **Corrompe registros**: um usuário logado na filial "02" que rode uma rotina hardcoded para "01" gravará o dado na filial errada. O usuário da filial correta nunca verá o registro, gerando inconsistência grave na base.
