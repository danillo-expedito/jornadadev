FUNCTION BuscarProduto(aEstoque, nCodigo)
    LOCAL nI
    FOR nI := 1 TO Len(aEstoque)
        IF aEstoque[nI][1] == nCodigo
            RETURN nI
        ENDIF
    NEXT
RETURN 0

FUNCTION CadastrarProduto(aEstoque)
    LOCAL nCodigo, cNome, nQtd, nPreco
    LOCAL cInput

    ? "================================================="
    ? "             === Cadastrar Produto ===           "
    ? "================================================="

    DO WHILE .T.
        ACCEPT " Digite o c¢digo num‚rico do produto: " TO cInput
        nCodigo := Val(cInput)
        IF nCodigo > 0 .AND. BuscarProduto(aEstoque, nCodigo) == 0
            EXIT
        ENDIF
        IF nCodigo <= 0
            ? " C¢digo inv lido! Digite um n£mero maior que zero."
        ELSE
            ? " C¢digo j  cadastrado! Tente outro."
        ENDIF
        ? "-------------------------------------------------"
    ENDDO

    DO WHILE .T.
        ACCEPT " Digite o nome do produto: " TO cNome
        IF Len(Trim(cNome)) > 0
            EXIT
        ENDIF
        ? " Nome inv lido! O nome nÆo pode ser vazio."
        ? "-------------------------------------------------"
    ENDDO

    DO WHILE .T.
        ACCEPT " Digite a quantidade inicial: " TO cInput
        nQtd := Val(cInput)
        IF nQtd >= 0 .AND. Val(cInput) == Int(nQtd)
            EXIT
        ENDIF
        ? " Quantidade inv lida! Digite um n£mero inteiro maior ou igual a zero."
        ? "-------------------------------------------------"
    ENDDO

    DO WHILE .T.
        ACCEPT " Digite o pre‡o unit rio (R$): " TO cInput
        nPreco := Val(cInput)
        IF nPreco > 0
            EXIT
        ENDIF
        ? " Pre‡o inv lido! Digite um valor maior que zero."
        ? "-------------------------------------------------"
    ENDDO

    // Adiciona o produto: {codigo, nome, quantidade, preco_unitario}
    AAdd(aEstoque, { nCodigo, Trim(cNome), nQtd, nPreco })

    ? "================================================="
    ? " Produto cadastrado com sucesso!"
    ? "================================================="
RETURN NIL

FUNCTION ListarProdutos(aEstoque)
    LOCAL nI

    ? "================================================="
    ? "              === Lista de Produtos ===          "
    ? "================================================="

    IF Len(aEstoque) == 0
        ? " Nenhum produto cadastrado no momento."
        ? "================================================="
        RETURN NIL
    ENDIF

    FOR nI := 1 TO Len(aEstoque)
        ? " C¢d: " + AllTrim(Str(aEstoque[nI][1])) + " | Produto: " + PadR(aEstoque[nI][2], 20)
        ? " Qtd: " + AllTrim(Str(aEstoque[nI][3])) + " | Pre‡o: R$ " + AllTrim(Str(aEstoque[nI][4], 10, 2))
        ? "-------------------------------------------------"
    NEXT
    ? "================================================="
RETURN NIL

FUNCTION EntradaEstoque(aEstoque)
    LOCAL nCodigo, nPos, nQtd
    LOCAL cInput

    ? "================================================="
    ? "            === Entrada de Estoque ===           "
    ? "================================================="

    IF Len(aEstoque) == 0
        ? " Nenhum produto cadastrado para entrada."
        ? "================================================="
        RETURN NIL
    ENDIF

    ACCEPT " Digite o c¢digo do produto: " TO cInput
    nCodigo := Val(cInput)
    nPos := BuscarProduto(aEstoque, nCodigo)

    IF nPos == 0
        ? " Produto nÆo encontrado!"
        ? "================================================="
        RETURN NIL
    ENDIF

    ? " Produto selecionado: " + aEstoque[nPos][2]
    ? " Quantidade atual   : " + AllTrim(Str(aEstoque[nPos][3]))
    ? "-------------------------------------------------"

    DO WHILE .T.
        ACCEPT " Digite a quantidade a adicionar: " TO cInput
        nQtd := Val(cInput)
        IF nQtd > 0 .AND. Val(cInput) == Int(nQtd)
            EXIT
        ENDIF
        ? " Quantidade inv lida! Digite um valor inteiro maior que zero."
    ENDDO

    aEstoque[nPos][3] += nQtd

    ? "================================================="
    ? " Estoque atualizado com sucesso!"
    ? " Nova quantidade: " + AllTrim(Str(aEstoque[nPos][3]))
    ? "================================================="
RETURN NIL

FUNCTION SaidaEstoque(aEstoque)
    LOCAL nCodigo, nPos, nQtd
    LOCAL cInput

    ? "================================================="
    ? "             === Sa¡da de Estoque ===            "
    ? "================================================="

    IF Len(aEstoque) == 0
        ? " Nenhum produto cadastrado para sa¡da."
        ? "================================================="
        RETURN NIL
    ENDIF

    ACCEPT " Digite o c¢digo do produto: " TO cInput
    nCodigo := Val(cInput)
    nPos := BuscarProduto(aEstoque, nCodigo)

    IF nPos == 0
        ? " Produto nÆo encontrado!"
        ? "================================================="
        RETURN NIL
    ENDIF

    ? " Produto selecionado: " + aEstoque[nPos][2]
    ? " Quantidade dispon¡vel: " + AllTrim(Str(aEstoque[nPos][3]))
    ? "-------------------------------------------------"

    DO WHILE .T.
        ACCEPT " Digite a quantidade para retirada: " TO cInput
        nQtd := Val(cInput)
        IF nQtd > 0 .AND. Val(cInput) == Int(nQtd)
            IF nQtd <= aEstoque[nPos][3]
                EXIT
            ELSE
                ? " Estoque insuficiente! Vocˆ s¢ possui " + AllTrim(Str(aEstoque[nPos][3])) + " unidades."
            ENDIF
        ELSE
            ? " Quantidade inv lida! Digite um valor inteiro maior que zero."
        ENDIF
    ENDDO

    aEstoque[nPos][3] -= nQtd

    ? "================================================="
    ? " Sa¡da registrada com sucesso!"
    ? " Quantidade restante: " + AllTrim(Str(aEstoque[nPos][3]))
    ? "================================================="
RETURN NIL

FUNCTION RelatorioEstoque(aEstoque)
    LOCAL nI, nTotalItem, nTotalGeral := 0

    ? "================================================="
    ? "          === Relat¢rio de Estoque ===           "
    ? "================================================="

    IF Len(aEstoque) == 0
        ? " Nenhum produto cadastrado no estoque."
        ? "================================================="
        RETURN NIL
    ENDIF

    FOR nI := 1 TO Len(aEstoque)
        nTotalItem := aEstoque[nI][3] * aEstoque[nI][4]
        nTotalGeral += nTotalItem

        ? " C¢d: " + AllTrim(Str(aEstoque[nI][1])) + " | Prod: " + PadR(aEstoque[nI][2], 15)
        ? " " + AllTrim(Str(aEstoque[nI][3])) + " un. x R$ " + AllTrim(Str(aEstoque[nI][4], 10, 2)) + ;
          " = R$ " + AllTrim(Str(nTotalItem, 12, 2))
        ? "-------------------------------------------------"
    NEXT

    ? " TOTAL GERAL EM ESTOQUE: R$ " + AllTrim(Str(nTotalGeral, 12, 2))
    ? "================================================="
RETURN NIL
