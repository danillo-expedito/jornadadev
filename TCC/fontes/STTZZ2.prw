#include "protheus.ch"

/*
==============================================================================
Função:      MontaCoresZZ2 (uso interno deste arquivo)
Objetivo:    Monta o array de legenda de cores da ZZ2, reaproveitado pelas
             duas rotinas de browse (normal e filtrada)
==============================================================================
*/                          

STATIC FUNCTION MontaCoresZZ2()
    Local aCoresZZ2 := {}

    AAdd(aCoresZZ2, {"U_PercNaoConforme(ZZ2->ZZ2_QTDOK, ZZ2->ZZ2_QTDNOK) > Posicione('ZZ1', 1, xFilial('ZZ1')+ZZ2->ZZ2_CONFOR, 'ZZ1_TOLERA')", "BR_VERMELHO"})
    AAdd(aCoresZZ2, {"U_PercNaoConforme(ZZ2->ZZ2_QTDOK, ZZ2->ZZ2_QTDNOK) <= Posicione('ZZ1', 1, xFilial('ZZ1')+ZZ2->ZZ2_CONFOR, 'ZZ1_TOLERA')", "BR_VERDE"})

RETURN aCoresZZ2


/*
==============================================================================
Função:      STTZZ2
Objetivo:    Manutenção geral da tabela ZZ2 (Todas as Ocorrências)
==============================================================================
*/    

USER FUNCTION STTZZ2()
    Private cCadastro := "Ocorrencias de Fornecedores"
    Private aRotina   := {}
    Private aCores    := MontaCoresZZ2()

    // Opções do Menu
    AAdd(aRotina, {"Pesquisar"  , "AxPesqui"   , 0, 1})
    AAdd(aRotina, {"Visualizar" , "AxVisual"   , 0, 2})
    AAdd(aRotina, {"Incluir"    , "AxInclui"   , 0, 3}) 
    AAdd(aRotina, {"Alterar"    , "AxAltera"   , 0, 4})
    AAdd(aRotina, {"Excluir"    , "AxDeleta"   , 0, 5})

    dbSelectArea("ZZ2")
    dbSetOrder(1)

    mBrowse(1, 1, 22, 75, "ZZ2", , , , , , aCores)

RETURN NIL


/*
==============================================================================
Função:      STTZZ2FLT
Objetivo:    Manutenção da tabela ZZ2 filtrada por um Controle (ZZ1)
==============================================================================
*/        

USER FUNCTION STTZZ2FLT(cCodigoZZ1)
    Local aIndexZZ2 := {}
    Local cFiltro   := ""
    Local cFiltroVl := ""

    // Por segurança, se vier vazio, pegamos o código diretamente da tabela ZZ1 posicionada.
    cFiltroVl := If(cCodigoZZ1 == NIL, ZZ1->ZZ1_CODIGO, cCodigoZZ1)
    
    // Define o filtro macro para a tela
    cFiltro := "ZZ2_CONFOR == '" + cFiltroVl + "'"

    Private cCadastro := "Ocorrencias do Controle: " + cFiltroVl
    Private aRotina   := {}
    Private aCores    := MontaCoresZZ2()

    // Menu (sem incluir para evitar ocorrências órfãs durante o filtro)
    AAdd(aRotina, {"Pesquisar"  , "AxPesqui"   , 0, 1})
    AAdd(aRotina, {"Visualizar" , "AxVisual"   , 0, 2})
    AAdd(aRotina, {"Incluir"    , "AxInclui"   , 0, 3}) 
    AAdd(aRotina, {"Alterar"    , "AxAltera"   , 0, 4})
    AAdd(aRotina, {"Excluir"    , "AxDeleta"   , 0, 5})

    dbSelectArea("ZZ2")
    dbSetOrder(1)

    // Início da "bolha" de filtro conforme a dica do TCC
    FilBrowse("ZZ2", @aIndexZZ2, @cFiltro)

    mBrowse(1, 1, 22, 75, "ZZ2", , , , , , aCores)

    // Remove o filtro ao fechar a tela para não travar o ambiente
    EndFilBrw("ZZ2", aIndexZZ2)

RETURN NIL