FUNCTION Main()
    LOCAL nInicio := Seconds()
    LOCAL cHoraAtual

    hb_cdpSelect("PT850")

    ? "================================================="
    ? "             === Rel¢gio Digital ===             "
    ? "================================================="
    ? " Exibindo a hora por aprox. 30 segundos..."
    ? " Pressione qualquer tecla para encerrar antes."
    ? "================================================="

    DO WHILE (Seconds() - nInicio) < 30
        cHoraAtual := ObterHora()
        ExibirHora(FormatarHora(cHoraAtual))
        
        // Aguarda 1 segundo (se o usuÃ¡rio pressionar algo, encerra)
        IF Inkey(1) != 0
            EXIT
        ENDIF
    ENDDO

    ? "================================================="
    ? " Rel¢gio encerrado!"
    ? "================================================="
RETURN NIL

FUNCTION ObterHora()
RETURN Time()

FUNCTION FormatarHora(cHora)
RETURN " [ Rel¢gio ] -> " + cHora

FUNCTION ExibirHora(cHora)
    QOut(cHora)
RETURN NIL
