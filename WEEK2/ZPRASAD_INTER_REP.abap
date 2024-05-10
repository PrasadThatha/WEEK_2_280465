*&---------------------------------------------------------------------*
*& Report ZPRASAD_FORMATING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPRASAD_FORMATING NO STANDARD PAGE HEADING LINE-COUNT 20(3)
LINE-SIZE 500 MESSAGE-ID zprasad_ust_msg.
INCLUDE ZPRASAD_DEF_TOP1.
*INCLUDE zprasad_def_top.

SELECT-OPTIONS s_ebeln for lv_eblin OBLIGATORY.

INITIALIZATION.
clear : lt_tab, wa_tab.
s_ebeln-low ='1'.
s_ebeln-high = '100000000'.
APPEND s_ebeln.

at SELECTION-SCREEN on s_ebeln.
  select SINGLE ebeln
    into lv_eblin
    FROM ekko
    where ebeln in  s_ebeln.

    if sy-subrc eq 0.
      MESSAGE i000.
    ELSe.
      MESSAGE w002.
    ENDIF.
START-OF-SELECTION.
PERFORM ksub.
end-of-SELECTION.


   loop at lt_tab into wa_tab.
  WRITE :/ wa_tab-EBELN HOTSPOT,
20 wa_tab-BSTYP,
40 wa_tab-BSART,
60 wa_tab-STATU,
80 wa_tab-AEDAT,
100 wa_tab-TXZ01.
  HIDE WA_TAB-EBELN.
ENDLOOP.
lv_count = sy-linct - sy-linno.
skip lv_count.

TOP-OF-PAGE.
uline.
WRITE : / 'product id',
          20'produt name ',
         40'product mangement',
         60 'pdoduct range',
         80 'price',
         100 'price'.
uline.

end-of-PAGE.
WRITE :/ 'current list page no:' , sy-pagno,
        'Date: ', sy-datum,
        'Time:', sy-uzeit.

AT LINE-SELECTION.
  CASE SY-LSIND.
    WHEN 1 .
      SELECT EBELN BUKRS BSTYP
        INTO TABLE LT_TAB2
        FROM EKKO
        WHERE EBELN EQ WA_TAB-EBELN.

     LOOP AT LT_TAB2 INTO WA_TAB2.
       WRITE : /
          WA_TAB2-EBELN  HOTSPOT ,
          20 WA_TAB2-BUKRS ,
          40 WA_TAB2-BSTYP.
       HIDE WA_TAB2-EBELN  .
     ENDLOOP.

     WHEN 2.

        SELECT  AEDAT  TXZ01 EBELP  EBELN
        INTO TABLE LT_TAB3
        FROM EKPO
        WHERE EBELN EQ WA_TAB2-EBELN.


       LOOP AT LT_TAB3 INTO WA_TAB3.

           WRITE : /
              wa_tab3-aedat,
              20 wa_tab3-txz01,
              40 wa_tab3-ebelp,
              60 wa_tab3-ebeln.
       endloop.

  ENDCASE.
  SET PF-STATUS 'ZPRASAD_MENUBAR'.


  TOP-OF-PAGE DURING LINE-SELECTION.
  CASE SY-LSIND.
    WHEN 1.
      WRITE : 'CURRENT LINE INDEX ',SY-LSIND.
    WRITE : / 'PRODUCT ID ' ,20  'PRODUCT NAME ' ,40 'PRODUCT COST'.
        ULINE.
     WHEN 2.
      WRITE : 'CURRENT LINE INDEX ',SY-LSIND.
    WRITE : / 'PRODUCT ID ' ,20  'PRODUCT NAME ' ,40 'PRODUCT COST',60 'product relese date '.
        ULINE.


  ENDCASE.




FORM ksub .

 SELECT ekko~ebeln
    ekko~bstyp
    ekko~bsart
    ekpo~statu
    ekpo~aedat
    ekpo~txz01
    into table lt_tab
    from ekko INNER JOIN ekpo
    on ekko~ebeln eq ekpo~ebeln
    where ekko~ebeln BETWEEN s_ebeln-low and s_ebeln-high.

ENDFORM.