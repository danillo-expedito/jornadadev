# Autoavaliação — TCC Harbour/ADVPL: Controle de Não Conformidades ISO 9001

Checklist do que foi entregue, organizada pelos critérios de avaliação do enunciado.

## Núcleo mínimo (piso do TCC)

- [X]  Tabela ZZ1 no dicionário (campos + índices) — SX2/SX3/SIX completos
- [X]  STTZZ1.PRW — manutenção da ZZ1 via mBrowse (Pesquisar, Visualizar, Incluir,
  Alterar, Excluir, Ocorrências)
- [X]  Validações da ZZ1 (fornecedor existe na SA2; tolerância entre 0 e 100)
- [X]  BEGIN SEQUENCE protegendo a gravação, com mensagem amigável (função `IncZZ1`)

## Critérios de avaliação (com peso)

- [X]  **Configuração correta do dicionário — 20%**
  Tabelas ZZ1 e ZZ2, todos os campos (SX3) e índices (SIX) criados e testados.
- [X]  **Rotinas funcionais (mBrowse, legendas, filtros) — 20%**
  `STTZZ1.PRW` e `STTZZ2.PRW`/`STTZZ2FLT` funcionando, com legendas coloridas
  (vencimento de certificado na ZZ1; % não conforme vs. tolerância na ZZ2) e filtro
  da ZZ2 pelo botão "Ocorrências" da ZZ1.
- [X]  **Validações de dados (campo a campo, integridade referencial) — 15%**
  `ExistCpo` (fornecedor na SA2, produto na SB1, controle na ZZ1), faixa de
  tolerância (0–100), datas não futuras.
- [X]  **Gatilhos automáticos corretos — 10%**
  SX7 configurados para nome do fornecedor (ZZ1 e ZZ2) e para replicar
  fornecedor/loja da ZZ1 para a ZZ2 a partir do controle vinculado.
- [X]  **Tratamento de erros com BEGIN SEQUENCE — 10%**
  Implementado em `IncZZ1` (inclusão) e `ExcZZ1` (exclusão), com mensagem amigável
  ao usuário e log técnico via classe `LogTCC`.
- [X]  **Biblioteca de funções comuns (STTZZLIB) — 10%**
  `GravarLogTCC` (via classe `LogTCC`), `NomeFornecedor`, `NomeProduto`,
  `PercNaoConforme`, `CertificadoVencendo`, `InicNomeForn`.
- [X]  **Menu configurado corretamente — 5%**
  Pasta "Controle ISO 9001" no SIGACOM com os dois itens (ZZ1 e ZZ2), gerado em
  `sigacom.xnu`.
- [X]  **Documentação completa e organizada — 10%**
  README + autoavaliação, com decisões técnicas, testes e desvios do
  enunciado justificados.

## Diferenciais (pontos extras)

- [X]  Indentação e documentação nos fontes (comentários de cabeçalho em todas as
  funções)
- [X]  Reaproveitamento de código — zero duplicação (fórmulas do dicionário
  substituídas por chamadas às funções da `STTZZLIB`)
- [X]  Validação de consistência em todos os campos de entrada relevantes
- [X]  Legenda da ZZ2 calculando o % de não conformidade vs. tolerância do
  certificado (`ZZ1_TOLERA`)
- [X]  Implementada classe ADVPL (POO): `LogTCC`, usada em `GravarLogTCC`
- [X]  Impedida a exclusão de ZZ1 quando há ZZ2 vinculada (`ExcZZ1`)

## Desvios do enunciado (documentados e justificados no README)

- Remoção de `xFilial()` das regras `ExistCpo()` (Val Usuário) — mantido em
  gatilhos/`POSICIONE()`, onde funcionou normalmente.
- Gatilhos autorreferentes de `ZZ2_DATA`/`ZZ2_HORA` substituídos por
  `Inic. Padrão`, pois não disparavam nesta build.
- Ordem de validação/gatilho da ZZ1 movida do campo `ZZ1_FORNEC` para
  `ZZ1_LOJAFO` (posteriormente ajustada de volta após a Consulta Padrão da SA2
  passar a preencher código e loja juntos).

Ver `README.md` para o relato completo do processo de desenvolvimento, testes e
descobertas técnicas.
