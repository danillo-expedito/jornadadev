FUNCTION Main()
    LOCAL aNumeros := {}
    LOCAL nI, nVal, nSoma := 0, nMedia
    LOCAL cInput

    hb_cdpSelect("PT850")

    ? "================================================="
    ? "         === Estat¡sticas de 10 N£meros ===      "
    ? "================================================="
    ? " Digite 10 n£meros para an lise:"

    FOR nI := 1 TO 10
        ACCEPT " Digite o " + AllTrim(Str(nI)) + "§ n£mero: " TO cInput
        nVal := Val(cInput)
        AAdd(aNumeros, nVal)
        nSoma += nVal
    NEXT

    // Ordena o array em ordem crescente
    ASort(aNumeros)

    nMedia := nSoma / Len(aNumeros)

    ? "================================================="
    ? " N£meros em ordem crescente:"
    FOR nI := 1 TO Len(aNumeros)
        ? " [" + AllTrim(Str(nI)) + "] -> " + AllTrim(Str(aNumeros[nI]))
    NEXT

    ? "-------------------------------------------------"
    ? " Soma total : ", AllTrim(Str(nSoma))
    ? " M‚dia      : ", AllTrim(Str(nMedia, 10, 2))
    ? " Menor valor: ", AllTrim(Str(aNumeros[1]))
    ? " Maior valor: ", AllTrim(Str(aNumeros[Len(aNumeros)]))
    ? "================================================="
RETURN NIL
