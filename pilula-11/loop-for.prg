FUNCTION Main()
    LOCAL aNumerosPrimos := {2, 3, 5, 7, 11, 13, 17, 19, 23, 29}
    LOCAL nSoma := 0
    LOCAL nNumero

    ? "Soma dos numeros primos de 0 a 30"

    FOR EACH nNumero IN aNumerosPrimos
        nSoma += nNumero
    NEXT
    ? "Soma:", nSoma

RETURN NIL