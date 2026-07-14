FUNCTION Main()
    LOCAL cNome := "Danillo Santos"
    LOCAL cCidade := "ITU - SP"
    LOCAL cCurso := "Harbour/ADVPL"
    LOCAL cTitulo := "      FICHA DE APRESENTA€ÇO      "
    LOCAL cTabulacao := Replicate( "=", Len( cTitulo ))

    hb_cdpSelect("PT850")

    QOut(cTabulacao)
    QOut(cTitulo)
    QOut(cTabulacao)
    QOut(" Nome   : " + cNome)
    QOut(" Cidade : " + cCidade)
    QOut(" Curso  : " + cCurso)
    QOut(cTabulacao)
RETURN NIL