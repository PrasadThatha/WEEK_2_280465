
*&---------------------------------------------------------------------*
*& Include          ZDEFINATIONS11_TOP
*&---------------------------------------------------------------------*
TYPES : BEGIN OF ls_tab1,
          vbeln	TYPE vbeln_va,
          erdat TYPE  erdat,
          erzet	TYPE erzet,               "" frist table strcutre
          ernam	TYPE ernam,                 "" vbak structure
        END OF ls_tab1.

DATA :
  wa_tab1 TYPE ls_tab1,             "" wa for vbak
  lt_tab1 TYPE STANDARD TABLE OF ls_tab1.   " itab for the vbak

TYPES: BEGIN OF ls_tab2,
         vbeln TYPE  vbeln_va,
         posnr TYPE  posnr_va,
         matnr TYPE matnr,
         matwa TYPE matwa,
       END OF ls_tab2.

DATA :
  wa_tab2 TYPE ls_tab2,             "" wa for vbap
  lt_tab2 TYPE STANDARD TABLE OF ls_tab2.   " itab for the vbap

TYPES : BEGIN OF ls_final,
          vbeln TYPE vbeln_va,
          erdat TYPE  erdat,
          erzet	TYPE erzet,               "" final table strcutre
          ernam	TYPE ernam,
          posnr TYPE  posnr_va,
          matnr TYPE matnr,
          matwa TYPE matwa,
        END OF ls_final.
DATA :
  wa_final TYPE ls_final,             "" wa for final tab
  lt_final TYPE STANDARD TABLE OF ls_final.   " itab for the final tab