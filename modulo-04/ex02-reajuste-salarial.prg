FUNCTION Main()
    LOCAL nSalario
    LOCAL cInputS
    LOCAL nReajuste
    LOCAL nSalarioReajustado

    ? "============================================"
    ? "  === Calculadora de Reajuste Salarial ===  "
    ? "=========================================="

    ACCEPT "Digite o seu sal rio atual (ex.: 3500): " TO cInputS
    nSalario := Val(cInputS)

    IF nSalario < 1000
        nReajuste := nSalario * 0.15
    ELSEIF nSalario >= 1000 .AND. nSalario < 2000
        nReajuste := nSalario * 0.12
    ELSEIF nSalario >= 2000 .AND. nSalario <= 4000
        nReajuste := nSalario * 0.08
    ELSE
        nReajuste := nSalario * 0.05
    ENDIF

    nSalarioReajustado := nSalario + nReajuste

    ? "============================================"
    ? "O Sal rio teve reajuste no valor de:", ;
        AllTrim(Str(nReajuste))
    ? "O valor do novo sal rio ‚:", ;
        AllTrim(Str(nSalarioReajustado))
    ? "============================================"
RETURN NIL