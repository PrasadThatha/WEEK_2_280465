*&---------------------------------------------------------------------*
*& Report ZPRASAD_SELECTION_SCR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprasad_selection_validate NO STANDARD PAGE HEADING LINE-COUNT 20(3) LINE-SIZE 500 MESSAGE-ID zprasad_ust_msg.

LOAD-OF-PROGRAM.
  TYPES :BEGIN OF ls_tab,
           order_id   TYPE  zprasadorder_id,
           cust_id    TYPE  zprasadcust_id,
           order_date TYPE  zprasadorder_date,
         END OF ls_tab.

  DATA : lt_tab TYPE STANDARD TABLE OF ls_tab,
         wa_tab TYPE ls_tab,
         lv_id  TYPE zprasadorder_id.
  SELECTION-SCREEN :BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-001 .
    SELECT-OPTIONS : s_id FOR lv_id OBLIGATORY.

  SELECTION-SCREEN : END OF BLOCK b2.

  SELECTION-SCREEN :BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-002 .
    PARAMETERS : rad11 RADIOBUTTON GROUP rad3 USER-COMMAND flag DEFAULT 'X',
                 rad12 RADIOBUTTON GROUP rad3.

  SELECTION-SCREEN :END OF BLOCK b3.

  SELECTION-SCREEN :BEGIN OF BLOCK b4 WITH FRAME TITLE TEXT-002 .
    PARAMETERS : order_id TYPE zprasadorder_id MODIF ID m1,
                 cust_id  TYPE zprasadcust_id MODIF ID m2.
  SELECTION-SCREEN :END OF BLOCK b4.


AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.
    IF rad11 = 'X' AND
    screen-group1 = 'M2'.
      screen-active = 0.
    ELSEIF rad12 = 'X' AND
      screen-group1 = 'M1'.
      screen-active = 0.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.





START-OF-SELECTION.
  SELECT order_id cust_id order_date
    INTO TABLE lt_tab
    FROM zprasad_order
  WHERE order_id  IN s_id.

END-OF-SELECTION.

  LOOP AT lt_tab INTO wa_tab.
    WRITE : /
      wa_tab-order_id ,
   20 wa_tab-cust_id ,
   40 wa_tab-order_date.
  ENDLOOP.

TOP-OF-PAGE.
  ULINE.
  WRITE : /
   'order_id' ,
   20 'cust_id' ,
   40 'order_date'.
  ULINE.