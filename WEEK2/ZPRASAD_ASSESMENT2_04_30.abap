*&---------------------------------------------------------------------*
*& Report ZPRASAD_ASSESMENT2_04_30
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPRASAD_ASSESMENT2_04_30.
TYPES : BEGIN OF LS_TAB,
  MATNR TYPE MATNR,
  MBRSH TYPE MBRSH,
  MTART TYPE MTART,
  MATKL TYPE mATKL,
  MARTX TYPE MAkTX,
  END OF LS_TAB.

  data : lt_tab TYPE STANDARD TABLE OF ls_tab,
        wa_tab type ls_tab,
        lv_matnr TYPE matnr.

  PARAMETERS lv_date type ersda.
  SELECT-OPTIONS s_matnr for lv_matnr.

  SELECT mara~matnr mara~mbrsh mara~mtart mara~matkl makt~maktx
    into TABLE lt_tab
    FROM mara INNER JOIN makt
    on mara~matnr eq makt~matnr
   where ersda eq lv_date and mara~matnr in s_matnr.


    loop at lt_tab into wa_tab.
      write :/ wa_tab-matnr,
      wa_tab-mbrsh,
      wa_tab-mtart,
      wa_tab-matkl,
      wa_tab-martx.
      ENDLOOP.