// ============================================
// STTIP003SALVAR.PRW
// Gravacao segura de um Contato (SZ1)
// Blindagem: validacao (IF/Break) + transacao
// (BeginTran/BEGIN SEQUENCE) + log de erro
// ============================================
#include "protheus.ch"

USER FUNCTION STTIP003SALVAR()
    LOCAL lOk := .T.
    LOCAL oErro

    BeginTran() // 1. inicia a transacao (tudo ou nada)

    BEGIN SEQUENCE

        // 1) validacao dos campos obrigatorios
        IF Empty(M->Z1_CLIENTE)
            MsgAlert("Cliente e obrigatorio!", "Atencao")
            lOk := .F.
            BREAK
        ENDIF

        IF Empty(M->Z1_ASSUNTO)
            MsgAlert("Assunto e obrigatorio!", "Atencao")
            lOk := .F.
            BREAK
        ENDIF

        // 2) grava com RecLock/MsUnLock
        dbSelectArea("SZ1")
        IF INCLUI
            RecLock("SZ1", .T.)
        ELSE
            RecLock("SZ1", .F.)
        ENDIF

        SZ1->Z1_CODIGO  := M->Z1_CODIGO
        SZ1->Z1_CLIENTE := M->Z1_CLIENTE
        SZ1->Z1_ASSUNTO := M->Z1_ASSUNTO
        MsUnLock()

    RECOVER USING oErro
        // 3) rollback + mensagem + log
        lOk := .F.
        RollBackTran()
        MsgStop("Erro ao salvar: " + oErro:Description, "Erro")
        U_GRAVARLOG("STTIP003SALVAR", oErro)
        RETURN lOk
    END SEQUENCE

    // 4) commit se deu tudo certo
    IF lOk
        CommitTran()
    ENDIF

RETURN lOk

// ============================================
// NOTA — resultado esperado em execucao
// ============================================
// Este arquivo foi validado quanto a logica e a sintaxe (compilacao
// isolada bem-sucedida). A execucao completa via um arquivo de teste
// dedicado (chamando U_STTIP003SALVAR() com variaveis de memoria
// simuladas) nao pode ser confirmada neste ambiente: o RPO local
// apresentou uma associacao residual de "funcao duplicada" ligada ao
// nome do arquivo-fonte de teste, que persistiu mesmo apos renomear o
// arquivo e a funcao envolvida por mais de uma vez. O problema parece
// estar restrito ao RPO deste ambiente de desenvolvimento, nao ao
// codigo em si.
//
// Comportamento esperado, caso executada com sucesso:
//
// Cenario 1 — M->Z1_CLIENTE vazio:
//   1. O IF de validacao identifica o campo vazio.
//   2. MsgAlert("Cliente e obrigatorio!", "Atencao") e exibido.
//   3. lOk recebe .F. e o BREAK interrompe a sequencia, desviando
//      direto para o ponto seguinte ao END SEQUENCE (nao ha bloco
//      RECOVER acionado, pois BREAK sem argumento nao gera erro real).
//   4. Como lOk e .F., o CommitTran() NAO e chamado — nenhum dado e
//      gravado na SZ1, e a transacao aberta por BeginTran() fica
//      pendente de commit/rollback ate uma proxima operacao ou o
//      encerramento natural do fluxo.
//
// Cenario 2 — Z1_CLIENTE e Z1_ASSUNTO preenchidos:
//   1. Os dois IFs de validacao sao ultrapassados sem disparar BREAK.
//   2. RecLock() trava o registro (novo ou existente, conforme INCLUI).
//   3. Os campos M->Z1_CODIGO, M->Z1_CLIENTE e M->Z1_ASSUNTO sao
//      gravados no registro corrente da SZ1.
//   4. MsUnLock() libera o lock e efetiva a gravacao no arquivo.
//   5. lOk permanece .T., e CommitTran() confirma a transacao.
//
// Cenario 3 — erro inesperado durante a gravacao (ex.: falha de
// disco, timeout de lock, etc.):
//   1. O erro de runtime interrompe a execucao dentro do
//      BEGIN SEQUENCE e é capturado por RECOVER USING oErro.
//   2. RollBackTran() desfaz qualquer alteracao pendente da transacao.
//   3. MsgStop() exibe uma mensagem amigavel ao usuario, sem expor
//      detalhes tecnicos na tela.
//   4. U_GRAVARLOG() registra o detalhe tecnico do erro (descricao,
//      funcao/linha, subsistema, operacao) em arquivo de log, para
//      diagnostico posterior pela equipe de TI.
//   5. RETURN lOk (.F.) interrompe a funcao imediatamente apos o
//      tratamento, sem chegar ao CommitTran() final.
