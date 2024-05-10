*&---------------------------------------------------------------------*
*& Report ZPRASAD_GETCURSUR_MAIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPRASAD_GETCURSUR_MAIN.
INCLUDE zprsad_get_cursur_def_top.

TABLES VBAK.
SELECT-OPTIONS s_vbeln FOR vbak-vbeln.

START-OF-SELECTION.

  SELECT vbeln erdat erzet ernam
    INTO TABLE lt_tab1
    FROM vbak
    WHERE vbeln IN s_vbeln.
end-of-SELECTION.

FORMAT HOTSPOT on.
loop at lt_tab1 into wa_tab1.
  WRITE : /
  wa_tab1-vbeln,
  wa_tab1-erdat,
  wa_tab1-erzet,
  wa_tab1-ernam.

  FORMAT HOTSPOT OFF.
ENDLOOP.

  AT LINE-SELECTION.
    GET CURSOR FIELD FNAME VALUE FVAL.
    CASE FNAME.
      WHEN 'WA_TAB1-VBELN'.
        SET PARAMETER ID 'AUD' FIELD FVAL.
        CALL  TRANSACTION 'VA03' AND SKIP FIRST SCREEN.

    ENDCASE.