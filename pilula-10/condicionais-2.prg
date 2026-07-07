FUNCTION Main()
    LOCAL aNotasAluno1 := {7, 8, 8.5}
    LOCAL aNotasAluno2 := {5, 6, 7}

    LOCAL nMediaAluno1 := (aNotasAluno1[1] + aNotasAluno1[2] + aNotasAluno1[3]) / 3
    LOCAL nMediaAluno2 := (aNotasAluno2[1] + aNotasAluno2[2] + aNotasAluno2[3]) / 3

    IF nMediaAluno1 >= 7
        ? "Aluno 1 aprovado com media:", nMediaAluno1
    ELSE
        ? "Aluno 1 reprovado com media:" , nMediaAluno1
    ENDIF

    IF nMediaAluno2 >= 7
        ? "Aluno 2 aprovado com media:" , nMediaAluno2
    ELSE
        ? "Aluno 2 reprovado com media:" , nMediaAluno2
    ENDIF
RETURN NIL