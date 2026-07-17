FUNCTION Main()
    LOCAL nQtBimestres := 4
    LOCAL aNotas := Array(nQtBimestres)
    LOCAL nSomaNotas := 0
    LOCAL nPeso := 1
    LOCAL nSomaPesos := 0
    LOCAL nMedia := 0
    LOCAL cTemp := ""
    LOCAL i
    LOCAL nNota

    hb_cdpSelect("PT850")

    QOut("============================================")
    QOut("      === Calcular m‚dia ponderada ===      ")
    QOut("============================================")
    QOut("Digite as notas abaixo: ")

    // Tentei a abordadem de ACCEPT ... TO aNotas[i] mas depois de alguns pesquisas descobri que nao ha essa possibilidade.
    // Nesse caso, criei uma variavel 'temporaria' para armazenar o input do usuario e depois passar para dentro do array.
    FOR i := 1 TO nQtBimestres
        ACCEPT "Digite a nota do " + AllTrim(Str(i)) + "§ Bimestre: " TO cTemp
        aNotas[i] := Val(cTemp)
    NEXT

    FOR EACH nNota IN aNotas
        nSomaNotas += (nNota * nPeso)
        
        nSomaPesos += nPeso
        nPeso++
    NEXT

    nMedia := nSomaNotas / nSomaPesos
    QOut("============================================")
    QOut("A soma das notas com pesos: " + AllTrim(Str(nSomaNotas)))
    QOut("A soma dos pesos..........: " + AllTrim(Str(nSomaPesos)))
    QOut("Sua M‚dia Ponderada final.: " + Transform(nMedia, "99.99"))
    QOut("============================================")
    Pausa()
RETURN NIL

STATIC FUNCTION Pausa()
    QOut("Aperte qualquer tecla para sair...")
    Inkey(0)
RETURN NIL