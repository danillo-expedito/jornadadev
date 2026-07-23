FUNCTION FatorialN(nN)
    LOCAL nFat := 1
    LOCAL nI

    IF nN < 0
        RETURN 0
    ENDIF

    FOR nI := 1 TO nN
        nFat := nFat * nI
    NEXT
RETURN nFat

FUNCTION EhPrimo(nN)
    LOCAL nI
    LOCAL nDivisores := 0

    IF nN <= 1
        RETURN .F.
    ENDIF

    FOR nI := 1 TO nN
        IF nN % nI == 0
            nDivisores++
        ENDIF
    NEXT
RETURN (nDivisores == 2)

FUNCTION MDC(nA, nB)
    LOCAL nResto

    DO WHILE nB != 0
        nResto := nA % nB
        nA := nB
        nB := nResto
    ENDDO
RETURN nA

FUNCTION MMC(nA, nB)
    IF nA == 0 .OR. nB == 0
        RETURN 0
    ENDIF
RETURN Abs(nA * nB) / MDC(nA, nB)
