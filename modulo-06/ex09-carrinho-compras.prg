FUNCTION Main()
    LOCAL aCarrinho := {}
    LOCAL cNomeProd, cInputPreco, cContinuar
    LOCAL nPreco, nTotal := 0
    LOCAL nI

    hb_cdpSelect("PT850")

    ? "================================================="
    ? "         === Mini-Carrinho de Compras ===        "
    ? "================================================="

    DO WHILE .T.
        DO WHILE .T.
            ACCEPT " Digite o nome do produto: " TO cNomeProd
            IF Len(Trim(cNomeProd)) > 0
                EXIT
            ENDIF
            ? " Nome do produto nÆo pode ser vazio!"
        ENDDO

        DO WHILE .T.
            ACCEPT " Digite o pre‡o do produto (R$): " TO cInputPreco
            nPreco := Val(cInputPreco)
            IF nPreco > 0
                EXIT
            ENDIF
            ? " Pre‡o inv lido! Digite um valor maior que zero."
        ENDDO

        AAdd(aCarrinho, { Trim(cNomeProd), nPreco })

        ? " Produto adicionado com sucesso!"
        ? "-------------------------------------------------"
        ACCEPT " Deseja adicionar outro produto? (S/N): " TO cContinuar
        IF Upper(AllTrim(cContinuar)) != "S"
            EXIT
        ENDIF
        ? "-------------------------------------------------"
    ENDDO

    ? "================================================="
    ? "             === RESUMO DO PEDIDO ===            "
    ? "================================================="
    FOR nI := 1 TO Len(aCarrinho)
        ? " " + AllTrim(Str(nI)) + ".", PadR(aCarrinho[nI][1], 25), ;
          "R$", AllTrim(Str(aCarrinho[nI][2], 10, 2))
        nTotal += aCarrinho[nI][2]
    NEXT
    ? "-------------------------------------------------"
    ? " TOTAL DA COMPRA: R$", AllTrim(Str(nTotal, 10, 2))
    ? "================================================="
RETURN NIL

