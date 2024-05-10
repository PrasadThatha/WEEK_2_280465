*&---------------------------------------------------------------------*
*& Report ZPRASAD_CLASSICAL_REP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprasad_classical_rep.

DATA : lt_tab   TYPE zprasad_tabletype_finalupdate,
       wa_tab   TYPE zprasad_linetype_final,
       lv_eblin TYPE ebeln,
       lv_count TYPE i.
TYPES :BEGIN OF ls_tab,
         ebeln  TYPE ebeln,
         ebelp  TYPE ebelp,
       END OF ls_tab.

DATA: LT_TAB2 TYPE LS_TAB,
      WA_TAB2

select-options s_ebeln for lv_eblin OBLIGATORY.

INITIALIZATION.
  CLEAR : lt_tab, wa_tab.
  s_ebeln-low ='1'.
  s_ebeln-high = '100000000'.
  APPEND s_ebeln.

AT SELECTION-SCREEN ON s_ebeln.
  SELECT SINGLE ebeln
    INTO lv_eblin
    FROM ekko
    WHERE ebeln IN  s_ebeln.

  IF sy-subrc EQ 0.
    MESSAGE i000(zprasad_ust_msg).
  ELSE.
    MESSAGE w002(zprasad_ust_msg).
  ENDIF.

START-OF-SELECTION.

  SELECT ekko~ebeln
     ekko~bstyp
     ekko~bsart
     ekpo~statu
     ekpo~aedat
     ekpo~txz01
     INTO TABLE lt_tab
     FROM ekko INNER JOIN ekpo
     ON ekko~ebeln EQ ekpo~ebeln
  WHERE ekko~ebeln BETWEEN s_ebeln-low AND s_ebeln-high.

END-OF-SELECTION.

  LOOP AT lt_tab INTO wa_tab.
    WRITE :/ wa_tab-ebeln HOTSPOT,
  20 wa_tab-bstyp,
  40 wa_tab-bsart,
  60 wa_tab-statu,
  80 wa_tab-aedat,
  100 wa_tab-txz01.
    HIDE wa_tab-ebeln.
  ENDLOOP.
  lv_count = sy-linct - sy-linno.
  SKIP lv_count.

AT LINE-SELECTION.
  CASE sy-LSiND.
    WHEN 1.
      SELECT ebeln ebelp
        INTO TABLE

top-of-page.
        ULINE.
        WRITE : / 'product id',
                  20'produt name ',
                 40'product mangement',
                 60 'pdoduct range',
                 80 'price',
                 100 'price'.
        ULINE.

END-OF-PAGE.
  WRITE :/ 'current list page no:' , sy-pagno,
          'Date: ', sy-datum,
          'Time:', sy-uzeit.