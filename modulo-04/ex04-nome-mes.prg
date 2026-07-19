FUNCTION Main()
    LOCAL nMes := 0
    LOCAL cInputMes
    LOCAL aMeses := { "Janeiro", "Fevereiro", "Mar‡o", "Abril", "Maio", ;
    "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro" }

    hb_cdpSELECT("PT850")

    ? "============================================="
    ? "            === N£mero do mˆs ===            "
    ? "============================================="

    DO WHILE nMes < 1 .OR. nMes > Len(aMeses) .OR. nMes != Int(nMes)
        ACCEPT " Digite o n£mero referente ao mˆs: " TO cInputMes
        nMes := Val(cInputMes)

        IF nMes < 1 .OR. nMes > Len(aMeses) .OR. nMes != Int(nMes)
            ? " Mˆs inv lido (Digite um n£mero inteiro entre 1 e 12)"
            ? "============================================="

        ENDIF
    ENDDO

    ? " O n£mero", nMes, "‚ referente ao mˆs: ", aMeses[nMes]
    ? "============================================="
RETURN NIL