FUNCTION Main()
    LOCAL nSaldo := 1000
    LOCAL nValorItem1 := 1299
    LOCAL nValorItem2 := 500

    IF nSaldo >= nValorItem1
        ? "Voce pode comprar o item 1."
    ELSEIF nSaldo >= nValorItem2
        ? "Voce pode comprar o item 2."
    ELSE
        ? "Voce não pode comprar nenhum item."
    ENDIF
RETURN NIL