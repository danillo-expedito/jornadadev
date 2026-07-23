FUNCTION Main()
    LOCAL aNumeros := {}
    LOCAL nI, nVal
    LOCAL cInput

    hb_cdpSelect("PT850")

    ? "================================================="
    ? "           === Bubble Sort Manual ===            "
    ? "================================================="
    ? " Digite 10 n£meros para ordenar:"

    FOR nI := 1 TO 10
        ACCEPT " Digite o " + AllTrim(Str(nI)) + "§ n£mero: " TO cInput
        nVal := Val(cInput)
        AAdd(aNumeros, nVal)
    NEXT

    ? "-------------------------------------------------"
    ? " Array original: "
    ExibirArray(aNumeros)

    BubbleSort(aNumeros)

    ? "-------------------------------------------------"
    ? " Array ordenado (crescente): "
    ExibirArray(aNumeros)
    ? "================================================="
RETURN NIL

FUNCTION BubbleSort(aVetor)
    LOCAL nI, nJ
    LOCAL nTam := Len(aVetor)
    LOCAL nTemp

    FOR nI := 1 TO nTam - 1
        FOR nJ := 1 TO nTam - nI
            IF aVetor[nJ] > aVetor[nJ + 1]
                // Troca os elementos vizinhos
                nTemp := aVetor[nJ]
                aVetor[nJ] := aVetor[nJ + 1]
                aVetor[nJ + 1] := nTemp
            ENDIF
        NEXT
    NEXT
RETURN NIL

FUNCTION ExibirArray(aVetor)
    LOCAL nI
    LOCAL cTexto := ""
    FOR nI := 1 TO Len(aVetor)
        cTexto += AllTrim(Str(aVetor[nI]))
        IF nI < Len(aVetor)
            cTexto += ", "
        ENDIF
    NEXT
    ? " [" + cTexto + "]"
RETURN NIL
