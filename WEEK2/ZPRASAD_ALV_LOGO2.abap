*&---------------------------------------------------------------------*
*& Report ZPRASAD_ALV_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprasad_alv_logo2 NO STANDARD PAGE HEADING  LINE-COUNT 20(3) LINE-SIZE 500 MESSAGE-ID zprasad_ust_msg.


INCLUDE zprasad_logo.
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
  PERFORM get_data.
  PERFORM get_data_from_vbak.

END-OF-SELECTION.

*PERFORM display_reuse_alv_display_list.
  PERFORM adding_of_logo.




*PERFORM display.

*FORM display .
*  loop at lt_tab into wa_tab.
*    write :
*    wa_tab-vbeln, wa_tab-erdat , wa_tab-erzet,wa_tab-ernam.
*   ENDLOOP.
*
*ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
***   for vbeln
  wa_fieldcat-col_pos = '1'.

  wa_fieldcat-fieldname = 'VBELN'.
  wa_fieldcat-seltext_l = 'Sales Document'.
  wa_fieldcat-tabname = 'LT_TAB'.
  WA_FIELDCAT-no_zero = 'X'.
  APPEND wa_fieldcat TO lt_fieldcat.
  CLEAR wa_fieldcat.

  "" for erdat

  wa_fieldcat-col_pos = '2'.
  wa_fieldcat-fieldname = 'ERDAT'.
  wa_fieldcat-tabname = 'LT_TAB'.
  wa_fieldcat-seltext_l = 'Record Created On'.
  APPEND wa_fieldcat TO lt_fieldcat.
  CLEAR wa_fieldcat.

  ""for erzet
  wa_fieldcat-fieldname = 'ERZET'.
  wa_fieldcat-col_pos = '3'.
  wa_fieldcat-tabname = 'LT_TAB'.
  wa_fieldcat-seltext_l = 'Entry time'.
  APPEND wa_fieldcat TO lt_fieldcat.
  CLEAR wa_fieldcat.

  "" for ernum

  wa_fieldcat-fieldname = 'ERNAM'.
  wa_fieldcat-col_pos = '4'.
  wa_fieldcat-tabname = 'LT_TAB'.
  wa_fieldcat-seltext_l = 'Name of Person Responsible for Creating the Object'.
  APPEND wa_fieldcat TO lt_fieldcat.
  CLEAR wa_fieldcat.




ENDFORM.

FORM get_data_from_vbak .

  SELECT vbeln erdat erzet ernam
    INTO TABLE lt_tab
    FROM vbak
  WHERE vbeln IN s_vbeln.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_reuse_alv_display_list
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*FORM display_reuse_alv_display_list .
*
*
*CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
*    EXPORTING
*      i_callback_program = 'ZPRASAD_ALV_REPORT '
*      it_fieldcat        = lt_fieldcat " filedcat table
*    TABLES
*      t_outtab           = lt_tab   " database table
*    EXCEPTIONS
*      program_error      = 1
*      OTHERS             = 2.
*  IF sy-subrc <> 0.
** Implement suitable error handling here
*  ENDIF.
*
*
*ENDFORM.

FORM adding_of_logo .
  DATA : LV_TITLE TYPE LVC_TITLE VALUE 'MATERIAL MAST DATA'.
  LT_LAYOUT-no_hline = 'X'.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK           = ' '
*     I_BYPASSING_BUFFER          = ' '
*     I_BUFFER_ACTIVE             = ' '
      i_callback_program          = SY-REPID
*     I_CALLBACK_PF_STATUS_SET    = ' '
*     I_CALLBACK_USER_COMMAND     = ' '
    I_CALLBACK_TOP_OF_PAGE      = 'UST_LOGO'
*      i_callback_html_top_of_page = 'ust_logo'
*     I_CALLBACK_HTML_END_OF_LIST = ' '
*      i_structure_name            = 'ls_tab'
*     I_BACKGROUND_ID             = ' '
*     I_GRID_TITLE                =
*     I_GRID_SETTINGS             =
*     IS_LAYOUT                   =
      it_fieldcat                 = LT_FIELDCAT
*     IT_EXCLUDING                =
*     IT_SPECIAL_GROUPS           =
*     IT_SORT                     =
*     IT_FILTER                   =
*     IS_SEL_HIDE                 =
*     I_DEFAULT                   = 'X'
*     I_SAVE                      = ' '
*     IS_VARIANT                  =
*     IT_EVENTS                   =
*     IT_EVENT_EXIT               =
*     IS_PRINT                    =
*     IS_REPREP_ID                =
*     I_SCREEN_START_COLUMN       = 0
*     I_SCREEN_START_LINE         = 0
*     I_SCREEN_END_COLUMN         = 0
*     I_SCREEN_END_LINE           = 0
*     I_HTML_HEIGHT_TOP           = 0
*     I_HTML_HEIGHT_END           = 0
*     IT_ALV_GRAPHICS             =
*     IT_HYPERLINK                =
*     IT_ADD_FIELDCAT             =
*     IT_EXCEPT_QINFO             =
*     IR_SALV_FULLSCREEN_ADAPTER  =
*     O_PREVIOUS_SRAL_HANDLER     =
*     O_COMMON_HUB                =
* IMPORTING
*     E_EXIT_CAUSED_BY_CALLER     =
*     ES_EXIT_CAUSED_BY_USER      =
    TABLES
      t_outtab                    = lt_tab
 EXCEPTIONS
     PROGRAM_ERROR               = 1
     OTHERS                      = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDFORM.
FORM UST_LOGO.
  data:
        lt_header TYPE slis_t_listheader,
        wa_header TYPE slis_listheader.
  wa_header-typ = 'H'.
  wa_header-info = 'ust'.
  wa_header-key = 'hyderabad'.
  APPEND wa_header to lt_header.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary       = LT_HEADER
    I_LOGO                   = 'ZPRASAD_LOGOIMG'
*     I_END_OF_LIST_GRID       =
*     I_ALV_FORM               =
            .


ENDFORM.