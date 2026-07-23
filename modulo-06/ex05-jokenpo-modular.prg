FUNCTION Main()
    LOCAL cJogadaUser, cJogadaCPU
    LOCAL cResultado
    LOCAL cContinuar

    hb_cdpSelect("PT850")

    ? "================================================="
    ? "              === Jogo Jokenpì ===               "
    ? "================================================="

    DO WHILE .T.
        cJogadaUser := LerEValidarJogada()
        cJogadaCPU  := SortearJogadaCPU()

        ? "-------------------------------------------------"
        ? " Sua jogada : ", cJogadaUser
        ? " Jogada CPU : ", cJogadaCPU
        ? "-------------------------------------------------"

        cResultado := DefinirVencedor(cJogadaUser, cJogadaCPU)

        IF cResultado == "Empate"
            ? " Resultado  : Deu EMPATE!"
        ELSEIF cResultado == "Jogador"
            ? " Resultado  : PARABêNS! Vocà venceu!"
        ELSE
            ? " Resultado  : QUE PENA! O computador venceu!"
        ENDIF
        ? "================================================="

        ACCEPT " Deseja jogar novamente? (S/N): " TO cContinuar
        IF Upper(AllTrim(cContinuar)) != "S"
            EXIT
        ENDIF
        ? "================================================="
    ENDDO

    ? " Obrigado por jogar!"
    ? "================================================="
RETURN NIL

FUNCTION LerEValidarJogada()
    LOCAL cInput := ""
    DO WHILE .T.
        ? " Escolha sua jogada:"
        ? " [1] Pedra | [2] Papel | [3] Tesoura"
        ACCEPT " Opá∆o: " TO cInput
        cInput := AllTrim(cInput)

        IF ValidarJogada(cInput)
            EXIT
        ENDIF
        ? " Opá∆o inv†lida! Digite apenas 1, 2 ou 3."
        ? "-------------------------------------------------"
    ENDDO

    DO CASE
        CASE cInput == "1"; RETURN "Pedra"
        CASE cInput == "2"; RETURN "Papel"
        CASE cInput == "3"; RETURN "Tesoura"
    ENDCASE
RETURN ""

FUNCTION ValidarJogada(cJogada)
RETURN (cJogada == "1" .OR. cJogada == "2" .OR. cJogada == "3")

FUNCTION SortearJogadaCPU()
    LOCAL nSorteio := HB_RandomInt(1, 3)
    LOCAL aOpcoes := {"Pedra", "Papel", "Tesoura"}
RETURN aOpcoes[nSorteio]

FUNCTION DefinirVencedor(cUser, cCPU)
    IF cUser == cCPU
        RETURN "Empate"
    ENDIF

    IF (cUser == "Pedra" .AND. cCPU == "Tesoura") .OR. ;
       (cUser == "Papel" .AND. cCPU == "Pedra") .OR. ;
       (cUser == "Tesoura" .AND. cCPU == "Papel")
        RETURN "Jogador"
    ENDIF
RETURN "CPU"
