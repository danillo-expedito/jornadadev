SET PROCEDURE TO matematica.prg

FUNCTION Main()
    LOCAL nNumFat := 5
    LOCAL nNumPrimo1 := 7
    LOCAL nNumPrimo2 := 10
    LOCAL nA := 12
    LOCAL nB := 18

    hb_cdpSelect("PT850")

    ? "================================================="
    ? "      === Teste da Biblioteca Matem tica ===     "
    ? "================================================="

    ? " 1) Testando FatorialN(" + AllTrim(Str(nNumFat)) + "):"
    ? "    Resultado:", FatorialN(nNumFat)
    ? "-------------------------------------------------"

    ? " 2) Testando EhPrimo:"
    ? "    O n£mero " + AllTrim(Str(nNumPrimo1)) + " ‚ primo?", IF(EhPrimo(nNumPrimo1), "Sim (.T.)", "NÆo (.F.)")
    ? "    O n£mero " + AllTrim(Str(nNumPrimo2)) + " ‚ primo?", IF(EhPrimo(nNumPrimo2), "Sim (.T.)", "NÆo (.F.)")
    ? "-------------------------------------------------"

    ? " 3) Testando MDC(" + AllTrim(Str(nA)) + ", " + AllTrim(Str(nB)) + "):"
    ? "    Resultado:", MDC(nA, nB)
    ? "-------------------------------------------------"

    ? " 4) Testando MMC(" + AllTrim(Str(nA)) + ", " + AllTrim(Str(nB)) + "):"
    ? "    Resultado:", MMC(nA, nB)
    ? "================================================="
RETURN NIL
