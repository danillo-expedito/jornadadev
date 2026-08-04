FUNCTION Main()
    LOCAL nA := 10
    LOCAL nB := 0
    LOCAL nResult
    LOCAL oErro
    LOCAL bAntigo

    hb_cdpSelect("PT850")

    bAntigo := ErrorBlock({|oErro| Break(oErro)})

    BEGIN SEQUENCE
        nResult := nA / nB
        QOut("Resultado: " + Str(nResult))
    RECOVER USING oErro
        QOut("Erro capturado: " + oErro:Description + " (opera‡Æo: " + oErro:Operation + ")")
    END SEQUENCE

    ErrorBlock(bAntigo)

    QOut("O Programa continua de p‚")
RETURN NIL