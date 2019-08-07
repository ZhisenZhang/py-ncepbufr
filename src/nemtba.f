      SUBROUTINE NEMTBA(LUN,NEMO,MTYP,MSBT,INOD)

C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C
C SUBPROGRAM:    NEMTBA
C   PRGMMR: WOOLLEN          ORG: NP20       DATE: 1994-01-06
C
C ABSTRACT: THIS SUBROUTINE SEARCHES FOR MNEMONIC NEMO WITHIN THE
C  INTERNAL TABLE A ARRAYS HOLDING THE DICTIONARY TABLE (ARRAYS IN
C  MODULE TABABD) AND, IF FOUND, RETURNS INFORMATION ABOUT THAT
C  MNEMONIC FROM WITHIN THESE ARRAYS.  IT IS IDENTICAL TO BUFR ARCHIVE
C  LIBRARY SUBROUTINE NEMTBAX EXCEPT THAT, IF NEMO IS NOT FOUND, THIS
C  SUBROUTINE MAKES AN APPROPRIATE CALL TO BUFR ARCHIVE LIBRARY
C  SUBROUTINE BORT.
C
C PROGRAM HISTORY LOG:
C 1994-01-06  J. WOOLLEN -- ORIGINAL AUTHOR
C 1995-06-28  J. WOOLLEN -- INCREASED THE SIZE OF INTERNAL BUFR TABLE
C                           ARRAYS IN ORDER TO HANDLE BIGGER FILES
C 1998-07-08  J. WOOLLEN -- REPLACED CALL TO CRAY LIBRARY ROUTINE
C                           "ABORT" WITH CALL TO NEW INTERNAL BUFRLIB
C                           ROUTINE "BORT"
C 1999-11-18  J. WOOLLEN -- THE NUMBER OF BUFR FILES WHICH CAN BE
C                           OPENED AT ONE TIME INCREASED FROM 10 TO 32
C                           (NECESSARY IN ORDER TO PROCESS MULTIPLE
C                           BUFR FILES UNDER THE MPI)
C 2003-11-04  J. ATOR    -- ADDED DOCUMENTATION
C 2003-11-04  S. BENDER  -- ADDED REMARKS/BUFRLIB ROUTINE
C                           INTERDEPENDENCIES
C 2003-11-04  D. KEYSER  -- UNIFIED/PORTABLE FOR WRF; ADDED HISTORY
C                           DOCUMENTATION; OUTPUTS MORE COMPLETE
C                           DIAGNOSTIC INFO WHEN ROUTINE TERMINATES
C                           ABNORMALLY
C 2009-05-07  J. ATOR    -- USE NEMTBAX
C
C USAGE:    CALL NEMTBA (LUN, NEMO, MTYP, MSBT, INOD)
C   INPUT ARGUMENT LIST:
C     LUN      - INTEGER: I/O STREAM INDEX INTO INTERNAL MEMORY ARRAYS
C     NEMO     - CHARACTER*(*): TABLE A MNEMONIC TO SEARCH FOR
C
C   OUTPUT ARGUMENT LIST:
C     MTYP     - INTEGER: MESSAGE TYPE CORRESPONDING TO NEMO
C     MSBT     - INTEGER: MESSAGE SUBTYPE CORRESPONDING TO NEMO
C     INOD     - INTEGER: POSITIONAL INDEX OF NEMO WITHIN INTERNAL
C                JUMP/LINK TABLE
C
C REMARKS:
C    THIS ROUTINE CALLS:        BORT     NEMTBAX
C    THIS ROUTINE IS CALLED BY: CMSGINI  COPYMG   CPYMEM   LCMGDF
C                               MSGINI   OPENMB   OPENMG 
C                               Normally not called by any application
C                               programs.
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 77
C   MACHINE:  PORTABLE TO ALL PLATFORMS
C
C$$$

      INCLUDE 'bufrlib.prm'

      CHARACTER*(*) NEMO
      CHARACTER*128 BORT_STR

C-----------------------------------------------------------------------
C-----------------------------------------------------------------------

C  LOOK FOR NEMO IN TABLE A
C  ------------------------

      CALL NEMTBAX(LUN,NEMO,MTYP,MSBT,INOD)
      IF(INOD.EQ.0) GOTO 900

C  EXITS
C  -----

      RETURN
900   WRITE(BORT_STR,'("BUFRLIB: NEMTBA - CAN''T FIND MNEMONIC ",A)')
     . NEMO
      CALL BORT(BORT_STR)
      END
