FUNCTION Main()
    LOCAL nA
    LOCAL nB
    LOCAL cInputA
    LOCAL cInputB
    LOCAL nMaior
    LOCAL nMenor

    hb_cdpSelect("PT850")

    ? "================================"
    ACCEPT "Digite o primeiro valor: " TO cInputA
    nA := Val(cInputA)
    ACCEPT "Digite o segundo valor:  " TO cInputB
    nB := Val(cInputB)

    ? "================================"
    IF nB == nA
        ? "Os valores sÆo iguais."
        RETURN NIL
    ENDIF

    nMaior := IIF(nB > nA, nB, nA)
    nMenor := IIF(nB > nA, nA, nB)

    ? "O maior n£mero dentre os valores ‚: " + AllTrim(Str(nMaior))
    ? "O menor n£mero dentre os valores ‚: " + AllTrim(Str(nMenor))

RETURN NIL