FUNCTION Main()
    LOCAL nQtdAlunos := 0
    LOCAL cInputQtd, cNome, cInputNota
    LOCAL aAlunos := {}
    LOCAL nI, nJ, nNota, nSoma, nMedia
    LOCAL aAlunoAtual

    hb_cdpSelect("PT850")

    ? "================================================="
    ? "         === Sistema de Notas (Array) ===        "
    ? "================================================="

    DO WHILE nQtdAlunos <= 0
        ACCEPT " Quantos alunos deseja cadastrar? " TO cInputQtd
        nQtdAlunos := Val(cInputQtd)
        IF nQtdAlunos <= 0
            ? " Quantidade inv lida! Digite um n£mero maior que zero."
            ? "-------------------------------------------------"
        ENDIF
    ENDDO

    FOR nI := 1 TO nQtdAlunos
        ? "-------------------------------------------------"
        ? " Cadastrando aluno", nI, "de", nQtdAlunos

        DO WHILE .T.
            ACCEPT " Nome do aluno: " TO cNome
            IF Len(Trim(cNome)) > 0
                EXIT
            ENDIF
            ? " Nome inv lido! O nome nÆo pode ser vazio."
        ENDDO

        aAlunoAtual := { Trim(cNome) }

        FOR nJ := 1 TO 4
            DO WHILE .T.
                ACCEPT " Digite a nota " + AllTrim(Str(nJ)) + " (0 a 10): " TO cInputNota
                nNota := Val(cInputNota)
                IF nNota >= 0 .AND. nNota <= 10
                    EXIT
                ENDIF
                ? " Nota inv lida! Digite um valor entre 0 e 10."
            ENDDO
            AAdd(aAlunoAtual, nNota)
        NEXT

        AAdd(aAlunos, aAlunoAtual)
    NEXT

    ? "================================================="
    ? "              === RESULTADOS ===                 "
    ? "================================================="
    ? " ALUNOS APROVADOS (M‚dia >= 7.0):"
    FOR nI := 1 TO Len(aAlunos)
        nSoma := aAlunos[nI][2] + aAlunos[nI][3] + aAlunos[nI][4] + aAlunos[nI][5]
        nMedia := nSoma / 4
        IF nMedia >= 7.0
            ? " -", PadR(aAlunos[nI][1], 20), "| M‚dia:", AllTrim(Str(nMedia, 10, 2))
        ENDIF
    NEXT

    ? "-------------------------------------------------"
    ? " ALUNOS REPROVADOS (M‚dia < 7.0):"
    FOR nI := 1 TO Len(aAlunos)
        nSoma := aAlunos[nI][2] + aAlunos[nI][3] + aAlunos[nI][4] + aAlunos[nI][5]
        nMedia := nSoma / 4
        IF nMedia < 7.0
            ? " -", PadR(aAlunos[nI][1], 20), "| M‚dia:", AllTrim(Str(nMedia, 10, 2))
        ENDIF
    NEXT
    ? "================================================="
RETURN NIL
