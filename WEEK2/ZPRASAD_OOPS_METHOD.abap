
*&---------------------------------------------------------------------*
*& Report ZPRASAD_OOPS_METHOD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPRASAD_OOPS_METHOD.
***DATA : I TYPE REF TO ZCL_ZPRASAD_CLS_METH.
***CREATE OBJECT I.
***
***START-OF-SELECTION.
***CALL METHOD I->i_m1.
***I->i_m2( ).
***ZCL_ZPRASAD_CLS_METH=>i_m1( ).

*CLASS C1 DEFINITION.
*  PUBLIC SECTION .
*  DATA : I TYPE I.
*  CLASS-DATA I2 TYPE I.
*  METHODS M1.
*ENDCLASS.
*
*CLASS C1 IMPLEMENTATION.
*  METHOD M1.
*    DATA I_SUM TYPE I.
*    I_SUM = I + I2.
*    WRITE I_SUM.
*  ENDMETHOD.
*ENDCLASS.
*
*
*
*START-OF-SELECTION .
*DATA I TYPE REF TO C1.
*CREATE OBJECT I.
*
*I->I = 100.
*I->i2 = 200.
*I->m1( ).
*
*WRITE C1=>i2.

DATA : A TYPE C
      ,
      B TYPE I.
A = 100.
WRITE A.
A = B.
WRITE A.
WRITE B.
WRITE B TO A .