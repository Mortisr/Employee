-- 
-- Purpose : This script creates test records for LDMS 
--           Employees
-- Version History
-- version date       Name          Description
-- ------- ---------- ------------- ------------------------
-- 1.0     06/06/2024 Sridhar Morti initial version
-- 
-- Insert into LDMS_EMPLOYEES

set define off

SET SERVEROUT ON
DECLARE
  v_error VARCHAR2(100);
BEGIN

   v_emp := 'John Smith';
   ldms_pkg.create_employee ( v_emp
                              ,'CEO'
                              ,NULL
                              ,'01-Jan-95'
                              ,NULL
                              ,100000
                              ,'Management' );

   v_emp := 'Jimmy Willis';
   ldms_pkg.create_employee ( v_emp
                              ,'Manager'
                              ,'John Smith'
                              ,'23-Sep-03'
                              ,NULL
                              ,52500
                              ,'Sales' );

   v_emp := 'Roxy Jones';
   ldms_pkg.create_employee ( v_emp
                              ,'Salesperson'
                              ,'Jimmy Willis'
                              ,'11-Feb-17'
                              ,NULL
                              ,35000
                              ,'Sales' );

   v_emp := 'Selwyn Field';
   ldms_pkg.create_employee ( v_emp
                              ,'Salesperson'
                              ,'Roxy Jones'
                              ,'20-May-15'
                              ,NULL
                              ,32000
                              ,'Sales' );

   v_emp := 'David Hallett';
   ldms_pkg.create_employee ( v_emp
                              ,'Engineer'
                              ,NULL
                              ,'17-Apr-18'
                              ,NULL
                              ,40000
                              ,'Engineering' );

   v_emp := 'Sarah Phelps';
   ldms_pkg.create_employee ( v_emp
                              ,'Manager'
                              ,'John Smith'
                              ,'21-Mar-15'
                              ,NULL
                              ,45000
                              ,'Engineering' );

   update ldms_employees
   set    manager_id = ldms_pkg.get_emp_details('Sarah Phelps')
   where  employee_id = ldms_pkg.get_emp_details('David Hallett');

   v_emp := 'Louise Harper';
   ldms_pkg.create_employee ( v_emp
                              ,'Engineer'
                              ,'Sarah Phelps'
                              ,'01-Jan-13'
                              ,NULL
                              ,47000
                              ,'Engineering' );

   v_emp := 'Tina Hart';
   ldms_pkg.create_employee ( v_emp
                              ,'Engineer'
                              ,NULL
                              ,'28-Jul-14'
                              ,NULL
                              ,45000
                              ,'Research & Development' );

   v_emp := 'Gus Jones';
   ldms_pkg.create_employee ( v_emp
                              ,'Manager'
                              ,'John Smith'
                              ,'15-May-18'
                              ,NULL
                              ,50000
                              ,'Research & Development' );

   update ldms_employees
   set    manager_id = ldms_pkg.get_emp_details('Gus Jones')
   where  employee_id = ldms_pkg.get_emp_details('Tina Hart');

   v_emp := 'Mildred Hall';
   ldms_pkg.create_employee ( v_emp
                              ,'Secretary'
                              ,'John Smith'
                              ,'12-Oct-96'
                              ,NULL
                              ,35000
                              ,'Management' );

EXCEPTION

   dbms_output.put_line( 'Employee '||v_emp||' not created.' );

END;
/

set define on
