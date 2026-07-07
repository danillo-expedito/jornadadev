FUNCTION Main()
    LOCAL lTemPrevisaoDeChuva := .T.
    LOCAL lEstaChovendo := .F.

    IF lTemPrevisaoDeChuva .OR. lEstaChovendo
        ? "Levar guarda-chuva."
    ELSE
        ? "Não levar guarda-chuva."
    ENDIF
RETURN NIL