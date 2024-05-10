*&---------------------------------------------------------------------*
*& Report ZPRASAD_OOPS_IMP_EXP_CHAN_RETU
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprasad_oops_imp_exp_chan_retu.

*
*class c1 DEFINITION.
*  PUBLIC SECTION.
*  data : i_var type i value 100. " instance attribute
*  CLASS-DATA:   i_var2 type i value 200. " static
*  methods : sum.
*ENDCLASS.
*
*CLASS c1 IMPLEMENTATION. " class c1  implementation
*  METHOD sum.
*    data : sum TYPE i.
*    sum = i_var + i_var2.
*    WRITE sum.
*    ENDMETHOD.
*ENDCLASS.
*
*
*START-OF-SELECTION.
*
*write c1=>i_var2.  "" no need of obj because it is a static attribute.
*
* data : i_obj1 TYPE REF TO c1.
* CREATE OBJECT i_obj1.
*
* WRITE: / i_obj1->i_var,
*          i_obj1->i_var2.
* i_obj1->sum( ).



*
*CLASS c1 DEFINITION.
*  PUBLIC SECTION.
*  DATA : i_var TYPE i.
*  METHODS add IMPORTING i_input1 TYPE i i_input2 TYPE i.
*ENDCLASS.
*
*CLASS c1 IMPLEMENTATION.
*  METHOD add.
*    DATA sum TYPE i.
*    sum = i_input1 + i_input2.
*    WRITE sum.
*  ENDMETHOD.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA : i_obj TYPE REF TO c1.
*  CREATE OBJECT i_obj.
*
*  call METHOD i_obj->add EXPORTING i_input1 = 20 i_input2 = 30. " frist way same variable name in the above
*  call METHOD i_obj->add( i_input1 = 20  i_input2 = 30 ). " use call method keyword
**  call METHOD i_obj->add
*  i_obj->add( i_input1 = 20  i_input2 = 30 ). "" clear the dought here.
*






**#3
*PARAMETERS p_num TYPE i.
*
*
*CLASS c1 DEFINITION.
*  PUBLIC SECTION.
*  methods : m1 IMPORTING i_input1 TYPE i  " is the ref type ...???? HOW
*                   value(i_input2) type i.
*ENDCLASS.
*
*CLASS c1 IMPLEMENTATION.
*  METHOD m1.
*    i_input2 = p_num.
*    WRITE i_input2.
*
*  ENDMETHOD.
* ENDCLASS.
*
* START-OF-SELECTION.
*
* DATA i_obj TYPE REF TO c1.
* CREATE OBJECT i_obj.
*
* call METHOD i_obj->m1 EXPORTING i_input1 = 10
*                                  i_input2 = p_num.




***********#4 calling method using exporting changing importing..

*CLASS  C1 DEFINITION.
*
*  PUBLIC SECTION.
*  DATA : I_SAL TYPE P DECIMALS 2,
*         I_TAX TYPE P DECIMALS 2.
*  METHODS : FINANCE IMPORTING I_GRADE TYPE C
*                    EXPORTING I_TAX TYPE P
*                    CHANGING I_SAL TYPE P.
*ENDCLASS.
*
*CLASS C1 IMPLEMENTATION.
* METHOD FINANCE.
*    CASE I_GRADE.
*      WHEN 'A'.
*        I_TAX = I_SAL * '0.2'.
*       WHEN 'B'.
*        I_TAX = I_SAL * '0.4'.
*      WHEN 'C'.
*        I_TAX = I_SAL * '0.6'.
*
*
*    ENDCASE.
*    I_SAL = I_SAL - I_TAX.
*
*
*  ENDMETHOD.
*ENDCLASS.
*
*START-OF-SELECTION.
*DATA : I_OBJ TYPE REF TO C1.
*CREATE OBJECT I_OBJ.
*
* DATA : LV_SAL TYPE P DECIMALS 3 VALUE 30000,
*       LV_ITAX TYPE P  DECIMALS 3 VALUE 0.
*
* WRITE : / 'BEFORE CALLING THE PROGRAM THE SALARY  AND THE TAX IS ' , LV_SAL , LV_ITAX.
*
*I_OBJ->finance(
*  EXPORTING
*    i_grade = 'A'
*  IMPORTING
*    i_tax   = LV_ITAX
*  CHANGING
*    i_sal   = LV_SAL
*).
*WRITE : / 'AFTER CALLING THE PROGRAM THE SALARY  AND THE TAX IS ' , LV_SAL , LV_ITAX.
*
*


*# 5
*
*CLASS c1 DEFINITION.
*  PUBLIC SECTION.
*  METHOds m1 IMPORTING i_input1 type i
*                       i_input2 TYPE i
*             EXPORTING I_INPUT3 TYPE I
*             RETURNING VALUE(result)  TYPE i.
*ENDCLASS.
*
*
*CLASS c1 IMPLEMENTATION.
*  method m1.
*    result = i_input1 + i_input2.
*    I_INPUT3 = i_input1 + i_input2.
*  ENDMETHOD.
*ENDCLASS.
*
*
*START-OF-SELECTION.
*
*
*data : i_obj TYPE REF TO c1,
*      lv_input TYPE i VALUE 100,
*      LV_INPUT2 TYPE I VALUE 200,
*      LV_CHECK TYPE I,
*      LV_RES TYPE I.
*CREATE OBJECT I_OBJ.
*
*I_OBJ->m1(
*  EXPORTING
*    i_input1 = LV_INPUT
*    i_input2 = LV_INPUT2
*  IMPORTING
*    i_input3 = LV_CHECK
*  RECEIVING
*    result   = LV_RES
*).
*
*WRITE : LV_RES ,LV_CHECK.
*
*LV_RES = I_OBJ->m1( I_INPUT1 = 10 I_INPUT2 = 20 ).
*
*MOVE I_OBJ->m1( I_INPUT1 = 10 I_INPUT2 = 20 ) TO LV_RES.
*
*WRITE : LV_RES ,LV_CHECK.


*#6

CLASS C1 DEFINITION.
  PUBLIC SECTION.
  CLASS-DATA : I_INPUT1 TYPE I . " STATIC ATTRIBUTE
   DATA I_INPUT2 TYPE I . " NON-STATIC ATTRIBUTE.
  METHODS ST_M1.          " " STATIC METHOD
  CLASS-METHODS I_M1.      " NON-STATIC METHOD

ENDCLASS.

CLASS C1 IMPLEMENTATION.
  METHOD ST_M1.
    WRITE : 'THIS IS METHOD STATIC'.
  ENDMETHOD.
  METHOD I_M1.
    WRITE : ' THIS IS METHOD INSTANCE'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
DATA: I_OBJ TYPE REF TO C1.
CREATE OBJECT I_OBJ.

  C1=>i_input1 = 1000.
  C1=>i_m1( ).
  I_OBJ->i_input1 = 300.