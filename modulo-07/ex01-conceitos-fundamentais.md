# Exercício 1 — Conceitos Fundamentais do Protheus

## a. Função do AppServer

O AppServer é o "motor" do Protheus, encarregado do processamento e execução das regras de negócio e interpretação do código ADVPL. O AppServer também faz a ponte entre o SmartClient e o banco de dados, além de tornar possível o controle de sessões de usuários.

## b. O que é o RPO

RPO = **Repositório de Objetos** (Repository of Objects). É um arquivo físico que armazena todo o código do sistema já compilado, tanto rotinas padrão da TOTVS quanto customizações. Quando o usuário abre uma tela, o AppServer consulta o RPO para saber como montar e executar aquela rotina.

## c. Para que serve o Configurador (SIGACFG)

Módulo administrativo que permite modelar o ERP sem programar, podendo trabalhar com Dicionário de Dados, como tabelas (SX2), campos (SX3), índices e parâmetros. Dentro do SIGACFG é possível realizar configurações de segurança, gerenciando privilégios de acesso, usuários, senhas, etc. Há também as configurações de interface e estrutura, que possibilitam realizar alterações na montagem dos menus, assim como a configuração de empresas e filiais.

## d. Campo Real x Campo Virtual (SX3)

O campo de tipo Real existe fisicamente no banco de dados, geralmente usado para armazenar dados persistentes.

O campo de tipo Virtual existe apenas no Dicionário de Dados, geralmente utilizado para realização de cálculos ou para exibição de dados já gravados em outras tabelas (permitindo que a mesma informação não tenha que ser salva em dois locais diferentes).
