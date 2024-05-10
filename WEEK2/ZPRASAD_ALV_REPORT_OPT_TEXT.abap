*&---------------------------------------------------------------------*
*& Report ZPRASAD_ALV_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprasad_alv_report_opt_text NO STANDARD PAGE HEADING  LINE-COUNT 20(3) LINE-SIZE 500 MESSAGE-ID zprasad_ust_msg.


INCLUDE ZPRASAD_DEF_TOP3.
*INCLUDE ZPRASAD_DEF_TOP2.
*  INCLUDE zprasad_definations.


  SELECT-OPTIONS s_vbeln FOR lv_vbeln.


AT SELECTION-SCREEN ON s_vbeln.

  SELECT SINGLE vbeln
    INTO s_vbeln
    FROM vbak
  WHERE vbeln IN s_vbeln.

  IF sy-subrc = 0.
    MESSAGE s000.
  ELSE.
    MESSAGE w002.
  ENDIF.

START-OF-SELECTION.
 PERFORM get_data_alv_optimal_code using  '1' 'VBELN' 'Sales Document' 'LT_TAB'.
 PERFORM get_data_alv_optimal_code using '2' 'ERDAT' 'RECORD CREATED ON' 'LT_TAB'.
 PERFORM get_data_alv_optimal_code using '3' 'ERZET' 'ENTRY TIME' 'LT_TAB'.
 PERFORM get_data_alv_optimal_code using '4' 'ERNAM' 'Name of Person Responsible for Creating the Object' 'LT_TAB'.



  PERFORM get_data_from_vbak.

END-OF-SELECTION.

 PERFORM display_reuse_alv_display_list .

FORM get_data_alv_optimal_code USING P1 p_a p_b p_c .

  wa_fieldcat-col_pos = P1.
  wa_fieldcat-fieldname = p_a .
  wa_fieldcat-seltext_l = p_b.
  wa_fieldcat-tabname = p_c.
  APPEND wa_fieldcat to lt_fieldcat.
  clear wa_fieldcat .

ENDFORM.

FORM get_data_from_vbak .

  SELECT vbeln erdat erzet ernam
    INTO TABLE lt_tab
    FROM vbak
  WHERE vbeln IN s_vbeln.
ENDFORM.

FORM display_reuse_alv_display_list .


CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = 'ZPRASAD_ALV_REPORT '
      it_fieldcat        = lt_fieldcat " filedcat table
    TABLES
      t_outtab           = lt_tab   " database table
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDFORM.