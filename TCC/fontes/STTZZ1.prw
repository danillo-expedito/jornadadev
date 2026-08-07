#include "protheus.ch"

/*
==============================================================================
Função:      STTZZ1
Objetivo:    Manutenção da tabela ZZ1 (Controle de Fornecimento ISO 9001)
==============================================================================
*/

USER FUNCTION STTZZ1()

		// Variáveis Privadas obrigatórias para o funcionamento do mBrowse    
		PRIVATE cCadastro := "Controle de Fornecimento ISO 9001"
		PRIVATE aRotina := {}
		PRIVATE aCores := {}
		
		// Definição das opções do menu
    	// Estrutura: { "Título", "Função a executar", Nível de acesso, Tipo de operação }         
		AAdd(aRotina, {"Pesquisar"  , "AxPesqui"   , 0, 1})
	    AAdd(aRotina, {"Visualizar" , "AxVisual"   , 0, 2})
	    AAdd(aRotina, {"Incluir"    , "U_IncZZ1"   , 0, 3})
	    AAdd(aRotina, {"Alterar"    , "AxAltera"   , 0, 4})
	    AAdd(aRotina, {"Excluir"    , "U_ExcZZ1"   , 0, 5}) 
	    
    	// Botão customizado que vai chamar a função da ZZ2  
     	AAdd(aRotina, {"Ocorrencias", "U_STTZZ2FLT", 0, 6})		                
    
	    // Definição da legenda de cores
	    // Estrutura: { "Condição em formato texto", "Cor" }         
	    AAdd(aCores, {"ZZ1->ZZ1_VALCER < dDataBase"             , "BR_VERMELHO"})
	    AAdd(aCores, {"U_CertificadoVencendo(ZZ1->ZZ1_VALCER)"     , "BR_AMARELO"})
	    AAdd(aCores, {"ZZ1->ZZ1_VALCER > (dDataBase + 30)"      , "BR_VERDE"})         
	    
	    // Preparação e abertura da tabela 
	    dbSelectArea("ZZ1")
	    dbSetOrder(1)
	             
	    // Chamada da função que desenha o ecrã
	    // mBrowse(nTop, nLeft, nBottom, nRight, cAlias, ..., aCores)
	    mBrowse( 1, 1, 22, 75, "ZZ1", , , , , , aCores)
	    
RETURN NIL          


/*
==============================================================================
Função:      IncZZ1
Objetivo:    Protege a inclusão padrão com controle de transação e tratamento de erro
==============================================================================
*/
USER FUNCTION IncZZ1()
    // Redireciona qualquer erro fatal para o nosso bloco RECOVER
    Local bErrorBlock := ErrorBlock({|e| Break(e)}) 
    Local oError

    BEGIN SEQUENCE
        // Inicia a transação com o banco de dados
        BeginTran()
        
        // Chama a tela padrão de inclusão
        AxInclui("ZZ1", 0, 3)
        
        // Se tudo der certo, efetiva a gravação
        EndTran()
        
    RECOVER USING oError
        // Se der qualquer erro fatal, desfaz tudo que foi feito no banco
        DisarmTransaction() 
        
        // Mensagem amigável exigida pelo TCC
        MsgStop("Ocorreu um erro inesperado ao tentar gravar os dados. Nossa equipe técnica ja foi notificada.", "Aviso ao Usuario")
        
        // Chama a nossa biblioteca para gravar o log técnico
        U_GravarLogTCC("STTZZ1 - IncZZ1", oError)
        
    END SEQUENCE

    // Restaura o tratamento de erros original do Protheus
    ErrorBlock(bErrorBlock) 
    
RETURN NIL        


/*
==============================================================================
Função:      ExcZZ1
Objetivo:    Impede a exclusão de um controle ZZ1 que possua ocorrências
             (ZZ2) vinculadas, garantindo a integridade relacional.
==============================================================================
*/             

USER FUNCTION ExcZZ1()
    Local aAreaZZ1    := ZZ1->(GetArea())
    Local aAreaZZ2    := ZZ2->(GetArea())
    Local lTemVinculo := .F.
    Local cChaveBusca := ""

    // Monta a chave parcial para buscar no Indice 1 da ZZ2
    cChaveBusca := xFilial("ZZ2") + ZZ1->ZZ1_CODIGO

    // Muda o foco para a tabela filha e prepara a busca
    dbSelectArea("ZZ2")
    dbSetOrder(1)

    // dbSeek busca instantaneamente pelo inicio da chave
    If dbSeek(cChaveBusca)
        lTemVinculo := .T.
    EndIf

    // Tomada de decisao
    If lTemVinculo
        // Emite alerta visual e aborta a exclusao
        Aviso("Atenção", "Não é possível excluir este Controle. Existem ocorrências vinculadas a ele.", {"OK"})
    Else
        // Se estiver limpo, chama a rotina padrao de exclusao (5)
        AxDeleta("ZZ1", ZZ1->(RecNo()), 5)
    EndIf

    // Restaura as posicoes originais para nao quebrar a interface
    RestArea(aAreaZZ2)
    RestArea(aAreaZZ1)

RETURN NIL