#include "protheus.ch"

/*
==============================================================================
Classe:      LogTCC
Objetivo:    Diferencial do TCC - Implementação de Orientação a Objetos (POO)
             para encapsular a lógica de gravação de erros.
==============================================================================
*/ 

CLASS LogTCC
    // Propriedades (Atributos) da classe
    DATA cLogPath
    DATA cMensagem

    // Métodos da classe
    METHOD New(cPath) CONSTRUCTOR
    METHOD SetMensagem(cFuncao, cErroDesc)
    METHOD Gravar()
ENDCLASS

/*
------------------------------------------------------------------------------
Método Construtor: Inicializa o objeto na memória
------------------------------------------------------------------------------
*/
METHOD New(cPath) CLASS LogTCC
    ::cLogPath  := cPath
    ::cMensagem := ""
RETURN Self

/*
------------------------------------------------------------------------------
Método SetMensagem: Formata o texto do erro
------------------------------------------------------------------------------
*/
METHOD SetMensagem(cFuncao, cErroDesc) CLASS LogTCC
    ::cMensagem := DtoC(Date()) + " " + Time() + " - " + ;
                   "Funcao: " + cFuncao + " - " + ;
                   "Erro: " + cErroDesc
RETURN NIL

/*
------------------------------------------------------------------------------
Método Gravar: Executa a escrita no arquivo físico e no console
------------------------------------------------------------------------------
*/
METHOD Gravar() CLASS LogTCC
    // Grava no arquivo texto do servidor
    MemoWrite(::cLogPath, ::cMensagem)
    
    // Imprime no console (tela preta) do servidor
    ConOut("=== LOG DE ERRO TCC (POO) ===")
    ConOut(::cMensagem)
    ConOut("=============================")
RETURN NIL


/*
==============================================================================
Função:      GravarLogTCC (REFATORADA)
Objetivo:    Acionar a classe LogTCC quando o BEGIN SEQUENCE falhar
==============================================================================
*/     

USER FUNCTION GravarLogTCC(cFuncao, oErro)
    Local oLog // Variável que vai abrigar o nosso objeto

    // 1. Instancia (cria) o objeto
    oLog := LogTCC():New("\system\tcc_error.log")

    // 2. Passa as informações para o objeto processar
    oLog:SetMensagem(cFuncao, oErro:Description)

    // 3. Dá a ordem para o objeto gravar
    oLog:Gravar()
    
RETURN NIL  
             

/*
==============================================================================
Função:      PercNaoConforme
Objetivo:    Calcula o percentual de não conformidade, protegido contra
             divisão por zero
==============================================================================
*/          

USER FUNCTION PercNaoConforme(nOk, nNok)
    Local nPerc := 0

    If (nOk + nNok) > 0
        nPerc := (nNok / (nOk + nNok)) * 100
    EndIf

RETURN nPerc                       


/*
==============================================================================
Função:      NomeFornecedor
Objetivo:    Retorna o nome do fornecedor a partir do código e loja
==============================================================================
*/              

USER FUNCTION NomeFornecedor(cFornec, cLoja)
    Local cNome := ""

    If !Empty(cFornec) .And. !Empty(cLoja)
        cNome := POSICIONE("SA2", 1, xFilial("SA2")+cFornec+cLoja, "A2_NOME")
    EndIf

RETURN cNome

/*
==============================================================================
Função:      NomeProduto
Objetivo:    Retorna a descrição do produto a partir do código
==============================================================================
*/             

USER FUNCTION NomeProduto(cCodPro)
    Local cDesc := ""

    If !Empty(cCodPro)
        cDesc := POSICIONE("SB1", 1, xFilial("SB1")+cCodPro, "B1_DESC")
    EndIf

RETURN cDesc

/*
==============================================================================
Função:      CertificadoVencendo
Objetivo:    Retorna .T. se o certificado vence dentro de 30 dias (ou já venceu)
==============================================================================
*/              

USER FUNCTION CertificadoVencendo(dValCer)
    Local lVencendo := .F.

    If !Empty(dValCer)
        lVencendo := dValCer <= (dDataBase + 30)
    EndIf

RETURN lVencendo                                                     


/*
==============================================================================
Função:      InicNomeForn
Objetivo:    Resolver o limite de tamanho do Inicializador Padrão no SX3
             e evitar o erro INITERR durante a exclusão de registros.
==============================================================================
*/         

USER FUNCTION InicNomeForn(cTabela)
    Local cRetorno := ""

    // Verifica se a chamada veio da tabela ZZ1
    If cTabela == "ZZ1"
        If Type("M->ZZ1_FORNEC") == "C" // Se as variáveis de tela existirem (Inclusão/Alteração)
            cRetorno := U_NomeFornecedor(M->ZZ1_FORNEC, M->ZZ1_LOJAFO)
        Else // Se não existirem (Exclusão/Visualização), lê direto do banco
            cRetorno := U_NomeFornecedor(ZZ1->ZZ1_FORNEC, ZZ1->ZZ1_LOJAFO)
        EndIf
    EndIf

    // Verifica se a chamada veio da tabela ZZ2
    If cTabela == "ZZ2"
        If Type("M->ZZ2_FORNEC") == "C" // Se as variáveis de tela existirem
            cRetorno := U_NomeFornecedor(M->ZZ2_FORNEC, M->ZZ2_LOJAFO)
        Else // Se não existirem, lê direto do banco
            cRetorno := U_NomeFornecedor(ZZ2->ZZ2_FORNEC, ZZ2->ZZ2_LOJAFO)
        EndIf
    EndIf

RETURN cRetorno