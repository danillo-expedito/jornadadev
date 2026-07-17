FUNCTION Main()
    LOCAL cNome
    LOCAL nIdade
    LOCAL dNasc
    LOCAL nPreco := 1200.00
    LOCAL nDesconto := 0
    LOCAL nTotal
    LOCAL cInputNasc

    SET DATE BRITISH
    hb_cdpSelect("PT850")

    QOut("===================================================")
    QOut("               Programa de descontos               ")
    QOut("===================================================")
    QOut("Para validar o desconto, siga as instru‡äes abaixo: ")
    ACCEPT "Digite o seu nome: " TO cNome
    ACCEPT "Digite a sua data de nascimento (DD/MM/AAAA): " TO cInputNasc
    dNasc := CToD(cInputNasc)

    nIdade := Int((Date() - dNasc) / 365)

    IF nIdade > 60
        nDesconto := nPreco * 0.125
    ENDIF

    nTotal := nPreco - nDesconto
    QOut("===================================================")
    QOut("    Cliente: " + cNome)
    QOut("    Idade: " + Str(nIdade))
    QOut("    Pre‡o do produto: " + Str(nPreco, 10, 2))
    QOut("    Desconto: " + Str(nDesconto, 10, 2))
    QOut("    Total: " + Str(nTotal, 10, 2))
    QOut("===================================================")

RETURN NIL