FUNCTION Main()
    LOCAL cNome := "Danillo Santos"
    LOCAL cCidade := "ITU - SP"
    LOCAL cCurso := "Harbour/ADVPL"
    LOCAL cTitulo := "      FICHA DE APRESENTA€ÇO      "
    LOCAL dDate := Date()
    LOCAL cTime := Time()
    LOCAL cTabulacao := Replicate( "=", Len( cTitulo ))

    hb_cdpSelect("PT850")
    SET DATE BRITISH

    QOut(cTabulacao)
    QOut(cTitulo)
    QOut(cTabulacao)
    QOut(" Nome   : " + cNome)
    QOut(" Cidade : " + cCidade)
    QOut(" Curso  : " + cCurso)
    QOut(" Data/Hora: " + DToC(dDate) + " " + cTime)
    QOut(cTabulacao)
RETURN NIL