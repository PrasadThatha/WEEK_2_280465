*&---------------------------------------------------------------------*
*& Report ZPRASAD_OOPS_METHODS_PARA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPRASAD_OOPS_METHODS_PARA.
data :LT_TAB TYPE ZPRASAD_CUST_VIEW_TT,
      lv_custid type zprasadcust_id,
      OBJ TYPE REF TO ZCL_PRASAD_METHODS_PAR.
      CREATE OBJECT OBJ.
SELECT-OPTIONS s_CUSTID FOR LV_CUSTID.

OBJ->e_get_customer_data(
  EXPORTING
    i_cust1 =  S_CUSTID-LOW                " CUSTOMER LINE TYPE
    i_cust2 =  S_CUSTID-HIGH                " customer id
  IMPORTING
    e_tab   =     LT_TAB             " CUSTOMER LINE TYPE
).

CL_DEMO_OUTPUT=>display(
 data    = LT_TAB                 " Text or Data
 name    = 'CUSTOMER DATA'             " Name
*  exclude =                  " Exclude structure components
*  include =                  " Include structure components
).