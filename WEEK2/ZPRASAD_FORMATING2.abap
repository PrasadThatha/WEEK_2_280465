*&---------------------------------------------------------------------*
*& Report ZPRASAD_FORMATING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPRASAD_FORMATING NO STANDARD PAGE HEADING LINE-COUNT 20(3)
LINE-SIZE 500 MESSAGE-ID zprasad_ust_msg.
INCLUDE zprasad_def_top.






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
  WRITE :/ wa_tab-EBELN,
20 wa_tab-BSTYP,
40 wa_tab-BSART,
60 wa_tab-STATU,
80 wa_tab-AEDAT,
100 wa_tab-TXZ01.
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