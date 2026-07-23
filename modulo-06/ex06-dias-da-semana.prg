FUNCTION Main()
    LOCAL nDia := 0
    LOCAL cInputDia
    LOCAL aDias := { "Domingo", "Segunda-feira", "Ter‡a-feira", "Quarta-feira", ;
                     "Quinta-feira", "Sexta-feira", "S bado" }

    hb_cdpSelect("PT850")

    ? "============================================="
    ? "            === Dia da Semana ===            "
    ? "============================================="

    DO WHILE nDia < 1 .OR. nDia > Len(aDias) .OR. nDia != Int(nDia)
        ACCEPT " Digite o n£mero referente ao dia (1 a 7): " TO cInputDia
        nDia := Val(cInputDia)

        IF nDia < 1 .OR. nDia > Len(aDias) .OR. nDia != Int(nDia)
            ? " Dia inv lido (Digite um n£mero inteiro entre 1 e 7)"
            ? "---------------------------------------------"
        ENDIF
    ENDDO

    ? " O n£mero", nDia, "‚ referente a: ", aDias[nDia]
    ? "============================================="
RETURN NIL
