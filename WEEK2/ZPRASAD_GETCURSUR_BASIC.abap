*&---------------------------------------------------------------------*
*& Report ZPRASAD_GETCURSUR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPRASAD_GETCURSUR.
INCLUDE ZPRASAD_GET_CURSUR_TOPP.
*INCLUDE ZPRASAD_GET_CURSUR_TOP.

START-OF-SELECTION.

WRITE 'PRASAD THATHA '.



FORMAT HOTSPOT ON.
WRITE : /
F1,
F2,
F3.
FORMAT HOTSPOT OFF.

AT LINE-SELECTION .
  GET CURSOR FIELD FNAME .

  CASE FNAME .
    WHEN 'F1' .
      WRITE 'THIS IS F1 FIELD1'.

    WHEN  'F2'.
      WRITE 'THIS IS F1 FIELD2'.
    WHEN 'F3'.
      WRITE 'THIS IS F1 FIELD3'.
  ENDCASE.