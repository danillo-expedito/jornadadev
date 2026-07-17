FUNCTION Main()
    LOCAL cPalavra1 := "Paralelepipedo"
    LOCAL cPalavra2 := "Para"

    hb_cdpSelect("PT850")

    QOut(" A diferen‡a entre '=' e '==', ‚ que o operador = compara apenas o in¡cio da string, enquanto o '==' busca compara‡Æo exata")

    QOut("'Paralelepipedo' = 'Para'?")
    QOut(cPalavra1 = cPalavra2)
    QOut("=========================")
    QOut("'Paralelepipedo' == 'Para'?")
    Qout(cPalavra1 == cPalavra2)
RETURN NIL