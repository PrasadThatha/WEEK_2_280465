*&---------------------------------------------------------------------*
*& Report ZPRASAD_EZPRASAD_LOCK_OB
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPRASAD_EZPRASAD_LOCK_OB.
PARAMETERS p_matnr type matnr.

BREAK-POINT.

CALL FUNCTION 'ENQUEUE_EZPRASAD_LOCK_OB'
 EXPORTING
   MODE_MARA            = 'E'
   MANDT                = SY-MANDT
   MATNR                = p_matnr
*   X_MATNR              = ' '
*   _SCOPE               = '2'
*   _WAIT                = ' '
*   _COLLECT             = ' '
* EXCEPTIONS
*   FOREIGN_LOCK         = 1
*   SYSTEM_FAILURE       = 2
*   OTHERS               = 3
          .
IF sy-subrc eq 0.
  MESSAGE s000(zprasad_ust_msg).
else.
  MESSAGE w001(zprasad_ust_msg).
ENDIF.