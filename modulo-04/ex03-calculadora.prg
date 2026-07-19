FUNCTION Main()
	LOCAL nA
    LOCAL nB
    LOCAL cOp
    LOCAL cInputA
    LOCAL cInputB

    hb_cdpSelect("PT850")

    ? "==================================="
    ? "        === Calculadora ===        "
    ? "==================================="

    ACCEPT " Digite o primeiro Valor: " TO cInputA
    nA := Val(cInputA)

    ACCEPT " Operaá∆o (+, -, *, /, ^, R): " TO cOp
    IF Upper(cOp) != "R"
        ACCEPT " Digite o segundo Valor: " TO cInputB
        nB := Val(cInputB)
    ENDIF
    ? "==================================="

    DO CASE
    	CASE cOp == "+"
			? " Resultado: ", nA, cOp, nB, "=", AllTrim(Str(nA + nB, 10, 2))
       	CASE cOp == "-"
			? " Resultado: ", nA, cOp, nB, "=", AllTrim(Str(nA - nB, 10, 2))
       	CASE cOp == "*"
			? " Resultado: ", nA, cOp, nB, "=", AllTrim(Str(nA * nB, 10, 2))
       	CASE cOp == "/"
			IF nB == 0
				? "Erro: divis∆o por zero!"
			ELSE
				? " Resultado: ", nA, cOp, nB, "=", AllTrim(Str(nA / nB, 10, 2))
			ENDIF
        CASE cOp == "^"
			? " Resultado: ", nA, cOp, nB, "=", AllTrim(Str(nA ^ nB, 10, 2))
        CASE cOp == "R" .OR. cOp == "r"
			? " Resultado: Raiz quadrada de", nA, "=", AllTrim(Str(Sqrt(nA), 10, 2))
		OTHERWISE
			? "Operaá∆o inv†lida: " + cOp
		ENDCASE
    ? "==================================="

RETURN NIL