*&---------------------------------------------------------------------*
*& Report ZPRASAD_ALV_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprasad_alv_hieseq NO STANDARD PAGE HEADING  LINE-COUNT 20(3) LINE-SIZE 500 MESSAGE-ID zprasad_ust_msg.

TYPES : BEGIN OF ty_vbak,
          prasad(1),
          vbeln     TYPE vbeln_va,
          erdat	    TYPE erdat,
          erzet	    TYPE erzet,
          ernam	    TYPE ernam,
        END OF ty_vbak,

        BEGIN OF ty_vbap,
          vbeln	TYPE vbeln_va,
          posnr TYPE posnr_va,
          matnr TYPE matnr,
        END OF ty_vbap.


DATA :lt_vbak     TYPE TABLE OF ty_vbak, " itab  for vbak
      wa_vbak     TYPE ty_vbak,  " wa for vbak
      lv_cnt      TYPE i VALUE 1,


      lt_vbap     TYPE TABLE OF ty_vbap, " itab for vbap
      wa_vbap     TYPE ty_vbap,  " wa for vbap

      wa_fieldcat TYPE slis_fieldcat_alv,  " wa fileld cat
      lt_fieldcat TYPE slis_t_fieldcat_alv, " table filedcat

      it_key      TYPE slis_keyinfo_alv,
      layout      TYPE slis_layout_alv.


TABLES vbak.

SELECT-OPTIONS s_vbeln FOR vbak-vbeln.

START-OF-SELECTION .

  PERFORM get_data_from_database_vbak.
  PERFORM append_data_to_fieldcat_vbak USING 'VBELN' 'LT_VBAK' 'VBAK' .
  PERFORM append_data_to_fieldcat_vbak USING 'ERDAT' 'LT_VBAK' 'VBAK'.
  PERFORM append_data_to_fieldcat_vbak USING 'ERZET' 'LT_VBAK' 'VBAK'.
  PERFORM append_data_to_fieldcat_vbak USING 'ERNAM'  'LT_VBAK' 'VBAK'.

  lv_cnt = 1.
  PERFORM append_data_to_fieldcat_vbap USING 'VBELN' 'LT_VBAP' 'VBAP' .
  PERFORM append_data_to_fieldcat_vbap USING 'POSNR' 'LT_VBAP' 'VBAP'.
  PERFORM append_data_to_fieldcat_vbap USING 'MATNR' 'LT_VBAP' 'VBAP'.

  PERFORM display_hierarchyseq.

END-OF-SELECTION.


FORM get_data_from_database_VBAK .

  SELECT vbeln erdat erzet ernam
    INTO CORRESPONDING FIELDS OF TABLE lt_vbak
    FROM vbak
    WHERE vbeln IN s_vbeln.

  SELECT vbeln posnr matnr
    INTO TABLE lt_vbap
    FROM vbap
    WHERE vbeln IN s_vbeln.

ENDFORM.

FORM append_data_to_fieldcat_VBAK USING p_a p_b p_c .

  wa_fieldcat-col_pos = lv_cnt.
  wa_fieldcat-fieldname = p_a.
  wa_fieldcat-tabname = p_b.
  wa_fieldcat-ref_tabname = p_c .
  APPEND wa_fieldcat TO lt_fieldcat.
  CLEAR wa_fieldcat.
  lv_cnt = lv_cnt + 1.

ENDFORM.


FORM append_data_to_fieldcat_vbap  USING p_a p_b p_c .
  wa_fieldcat-col_pos = lv_cnt.
  wa_fieldcat-fieldname = p_a.
  wa_fieldcat-tabname = p_B.
  wa_fieldcat-ref_tabname = P_C .

  APPEND wa_fieldcat TO lt_fieldcat.
  CLEAR wa_fieldcat.
  lv_cnt = lv_cnt + 1.

ENDFORM.

FORM display_hierarchyseq .

  it_key-header01 = 'VBELN'.
  layout-expand_fieldname = 'PRASAD'.
  CALL FUNCTION 'REUSE_ALV_HIERSEQ_LIST_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      is_layout          = layout
      it_fieldcat        = lt_fieldcat
      i_tabname_header   = 'LT_VBAK'
      i_tabname_item     = 'LT_VBAP'
      is_keyinfo         = it_key
    TABLES
      t_outtab_header    = lt_vbak
      t_outtab_item      = lt_vbap
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDFORM.