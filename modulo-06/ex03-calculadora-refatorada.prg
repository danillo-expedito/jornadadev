FUNCTION Main()
    LOCAL nNum1, nNum2
    LOCAL cOperacao
    LOCAL xResultado

    hb_cdpSelect("PT850")

    ? "================================================="
    ? "           === Calculadora Modular ===           "
    ? "================================================="

    DO WHILE .T.
        nNum1 := LerNumero(" Digite o primeiro n£mero: ")
        nNum2 := LerNumero(" Digite o segundo n£mero: ")
        cOperacao := LerOperacao()

        xResultado := Calcular(nNum1, nNum2, cOperacao)

        MostrarResultado(nNum1, nNum2, cOperacao, xResultado)

        IF ! QuererContinuar()
            EXIT
        ENDIF
    ENDDO

    ? "================================================="
    ? " Calculadora encerrada. AtÇ logo!"
    ? "================================================="
RETURN NIL

FUNCTION LerNumero(cMensagem)
    LOCAL cInput := ""
    ACCEPT cMensagem TO cInput
RETURN Val(cInput)

FUNCTION LerOperacao()
    LOCAL cOp := ""
    DO WHILE .T.
        ACCEPT " Digite a operaá∆o (+, -, *, /): " TO cOp
        cOp := AllTrim(cOp)
        IF cOp == "+" .OR. cOp == "-" .OR. cOp == "*" .OR. cOp == "/"
            EXIT
        ENDIF
        ? " Operaá∆o inv†lida! Digite apenas +, -, * ou /."
        ? "-------------------------------------------------"
    ENDDO
RETURN cOp

FUNCTION Calcular(n1, n2, cOp)
    LOCAL xRes := .F.

    DO CASE
        CASE cOp == "+"
            xRes := n1 + n2
        CASE cOp == "-"
            xRes := n1 - n2
        CASE cOp == "*"
            xRes := n1 * n2
        CASE cOp == "/"
            IF n2 == 0
                xRes := .F.
            ELSE
                xRes := n1 / n2
            ENDIF
    ENDCASE
RETURN xRes

FUNCTION MostrarResultado(n1, n2, cOp, xRes)
    ? "-------------------------------------------------"
    IF ValType(xRes) == "L" .AND. xRes == .F.
        ? " Erro: Divis∆o por zero n∆o Ç permitida!"
    ELSE
        ? " Resultado:", AllTrim(Str(n1)), cOp, AllTrim(Str(n2)), "=", AllTrim(Str(xRes, 10, 2))
    ENDIF
    ? "================================================="
RETURN NIL

FUNCTION QuererContinuar()
    LOCAL cResp := ""
    ACCEPT " Deseja realizar outro c†lculo? (S/N): " TO cResp
RETURN Upper(AllTrim(cResp)) == "S"
