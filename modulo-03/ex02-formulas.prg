#define PI 3.14159

FUNCTION Main()
    hb_cdpSelect("PT850")
    CalcularAreaCirculo()
    CalcularHipotenusa()
    CalcularIMC()
RETURN NIL

FUNCTION CalcularAreaCirculo()
    LOCAL nRaio
    LOCAL cInputRaio
    LOCAL nArea

    CLS
    QOut("=========================================")
    QOut(" === Calculando a  rea de um c¡rculo === ")
    QOut("=========================================")

    ACCEPT "Digite o raio do circulo: " TO cInputRaio
    nRaio := Val(cInputRaio)

    nArea := PI * nRaio^2
    QOut("=========================================")
    QOut("Raio do c¡rculo:", cInputRaio)
    QOut("A  rea do circulo ‚:", Str(nArea, 10, 2))
    QOut("=========================================")
    Pausa()
RETURN NIL

FUNCTION CalcularHipotenusa()
    LOCAL nA
    LOCAL nB
    LOCAL cInputA
    LOCAL cInputB
    LOCAL nHipotenusa

    CLS
    QOut("===========================================================")
    QOut(" === Calculando a hipotenusa de um triƒngulo retƒngulo === ")
    QOut("===========================================================")

    ACCEPT "Digite o valor do cateto A: " TO cInputA
    nA := Val(cInputA)

    ACCEPT "Digite o valor do cateto B: " TO cInputB
    nB := Val(cInputB)

    nHipotenusa := Sqrt(nA^2 + nB^2)
    QOut("===========================================================")
    QOut("O cateto A tem medida:", cInputA)
    QOut("O cateto B tem medida:", cInputB)
    QOut("O valor da hipotenusa ‚:", Str(nHipotenusa, 10, 2))
    QOut("===========================================================")
    Pausa()
RETURN NIL

FUNCTION CalcularIMC()
    LOCAL nPeso
    LOCAL nAltura
    LOCAL cInputPeso
    LOCAL cINputAltura
    LOCAL nIMC

    CLS
    QOut("===================================================")
    QOut("            === Calculadora de IMC ===             ")
    QOut("===================================================")

    ACCEPT "Digite o seu Peso(kg) (ex.: 75.5 ou 75): " TO cInputPeso
    nPeso := Val(cInputPeso)

    ACCEPT "Digite sua Altura(m) (ex.: 1.76 ou 176): " TO cInputAltura
    nAltura := TratarAltura(cInputAltura)

    IF nPeso <= 0 .OR. nAltura <= 0
        QOut("Erro: Peso ou altura inv lidos.")
    ENDIF

    nIMC := nPeso / (nAltura ** 2)
    QOut("===================================================")
    QOut("Sua altura informada: " + Transform(nAltura, "9.99") + " m")
    QOut("Seu peso: " + Transform(nPeso, "999.9") + " kg")
    QOut("Seu IMC ‚:", Str((nIMC), 10, 2 ))
    QOut("===================================================")
    Pausa()
RETURN NIL

STATIC FUNCTION TratarAltura(cInput)
    LOCAL cLimpo := ""
    LOCAL i, cChar, nAltNum

    FOR i := 1 TO Len(cInput)
        cChar := SubStr(cInput, i, 1)
        IF cChar $ "0123456789."
            cLimpo += cChar
        ELSEIF cChar == ","
            cLimpo += "." // Trocando virgula por ponto, padrao do Harbour
        ENDIF
    NEXT

    nAltNum := Val(cLimpo)

    IF nAltNum >= 3
        nAltNum := nAltNum / 100
    ENDIF

RETURN nAltNum

STATIC FUNCTION Pausa()
    QOut("Pressione qualquer tecla para continuar...")
    Inkey(0)
RETURN NIL