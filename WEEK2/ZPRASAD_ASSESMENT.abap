*&---------------------------------------------------------------------*
*& Report ZPRASAD_ASSESMENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPRASAD_ASSESMENT.

types:begin of ls_tab,
  stu_id type zprasadstu_id,
  stu_name type zprasadstu_name,
  stu_mobile TYPE zprasadstu_mobile,
  course_id TYPE zprasadcourse_id,
  course_name TYPE zprasadcourse_name,
  END OF ls_tab.

  data :  lt_tab TYPE   STANDARD TABLE OF ls_tab ,
        wa_tab TYPE ls_tab.

  select stu_id stu_name stu_mobile course_id course_name
    into table lt_tab
    from zprasad_dbview1.

  loop at lt_tab into wa_tab.
    WRITE :/ wa_tab-stu_id,
    wa_tab-stu_name,
    wa_tab-stu_mobile,
    wa_tab-course_id.
   ENDLOOP.
   WRITE 'end'.