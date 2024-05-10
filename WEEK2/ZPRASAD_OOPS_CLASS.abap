*&---------------------------------------------------------------------*
*& Report ZPRASAD_OOPS_CLASS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprasad_oops_class.
****data :
****      i_obj TYPE REF TO ZCL_ZPRASAD_CLS.
****CREATE OBJECT i_obj.
****WRITE : /
**** I_OBJ->i_var1,
****ZCL_ZPRASAD_CLS=>i_var2.

*
*
*CLASS c1 DEFINITION.
*  PUBLIC SECTION.
*    DATA : I_VAR1 TYPE I VALUE 200.
*    CLASS-DATA  I_VAR2 TYPE I VALUE 300.
* endclass.
*
* DATA : VAR TYPE REF TO C1.
* CREATE OBJECT VAR.
* START-OF-SELECTION.
* WRITE : /
*  VAR->i_var1,
*  C1=>i_var2.
* END-OF-SELECTION.