SET PROCEDURE TO estoque_lib.prg

FUNCTION Main()
    LOCAL aEstoque := {}
    LOCAL nOpcao := -1
    LOCAL cInputOp
    LOCAL nCodigo, nPos

    hb_cdpSelect("PT850")

    DO WHILE .T.
        ExibirMenu()
        ACCEPT " Escolha uma op‡Æo: " TO cInputOp
        nOpcao := Val(cInputOp)


        IF nOpcao < 0 .OR. nOpcao > 6 .OR. Val(cInputOp) != Int(nOpcao)
            ? "================================================="
            ? " Op‡Æo inv lida! Escolha um n£mero entre 0 e 6."
            ? "================================================="
            LOOP
        ENDIF

        DO CASE
            CASE nOpcao == 1
                CadastrarProduto(aEstoque)
            CASE nOpcao == 2
                ListarProdutos(aEstoque)
            CASE nOpcao == 3
                EntradaEstoque(aEstoque)
            CASE nOpcao == 4
                SaidaEstoque(aEstoque)
            CASE nOpcao == 5
                ? "================================================="
                ? "           === Buscar por C¢digo ===             "
                ? "================================================="
                ACCEPT " Digite o c¢digo que deseja buscar: " TO cInputOp
                nCodigo := Val(cInputOp)
                nPos := BuscarProduto(aEstoque, nCodigo)
                IF nPos > 0
                    ? " Produto ENCONTRADO na posi‡Æo " + AllTrim(Str(nPos)) + ":"
                    ? " C¢d: " + AllTrim(Str(aEstoque[nPos][1])) + " | Nome: " + aEstoque[nPos][2]
                    ? " Qtd: " + AllTrim(Str(aEstoque[nPos][3])) + " | Pre‡o: R$ " + AllTrim(Str(aEstoque[nPos][4], 10, 2))
                ELSE
                    ? " Produto NÇO encontrado (Retorno: 0)."
                ENDIF
                ? "================================================="
            CASE nOpcao == 6
                RelatorioEstoque(aEstoque)
            CASE nOpcao == 0
                ? "================================================="
                ? " Encerrando o Controle de Estoque. At‚ logo!"
                ? "================================================="
                EXIT
        ENDCASE
    ENDDO

RETURN NIL

FUNCTION ExibirMenu()
    ? ""
    ? "================================================="
    ? "      === CONTROLE DE ESTOQUE SIMPLIFICADO ===   "
    ? "================================================="
    ? " [1] ? Cadastrar produto"
    ? " [2] ? Listar produtos"
    ? " [3] ? Entrada de estoque"
    ? " [4] ? Sa¡da de estoque"
    ? " [5] ? Buscar produto por c¢digo"
    ? " [6] ? Relat¢rio de valor em estoque"
    ? " [0] ? Sair"
    ? "================================================="
RETURN NIL
