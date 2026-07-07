FUNCTION Main()
    LOCAL cNome := "Danillo Expedito"
    LOCAL nIdade := 25
    LOCAL dNasc
    
    SET DATE BRITISH
    SET CENTURY ON

    dNasc := CToD("10/09/2000")

    ? "Nome:" , cNome
    ? "Idade:" , nIdade
    ? "Data de Nascimento:" , dNasc
RETURN NIL