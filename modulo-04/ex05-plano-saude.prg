FUNCTION Main()
    LOCAL nIdade
    LOCAL nDepend
    LOCAL cInputIdade
    LOCAL cInputDepend
    LOCAL nValor
    LOCAL nTotal
    LOCAL nAdicional := 90

    hb_cdpSelect("PT850")

    ? "===================================================="
    ? "          === Contratar Plano de Sa£de ===          "
    ? "===================================================="

    ? " Precisamos confirmar algumas informa‡äes abaixo: "
    ACCEPT " Qual a sua idade? " TO cInputIdade
    nIdade := Val(cInputIdade)
    ACCEPT " Quantidade de dependentes? " TO cInputDepend
    nDepend := Val(cInputDepend)
    ? "===================================================="

    IF nIdade <= 0 .OR. nIdade != Int(nIdade)
        ? " Idade inv lida."
        RETURN NIL
    ENDIF

    DO CASE
        CASE nIdade <= 25
            nValor := 180
        CASE nIdade > 25 .AND. nIdade <= 40
            nValor := 260
        CASE nIdade > 40 .AND. nIdade <= 60
            nValor := 380
        OTHERWISE
            nValor := 520
    ENDCASE
    
    nTotal := nValor + (nDepend * nAdicional)

    ? " O valor total do plano de sa£de ‚: R$", AllTrim(Str(nTotal, 10, 2))

RETURN NIL