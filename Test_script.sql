-- 
-- Purpose : This is Test script for LDMS Employees 
-- Version History
-- version date       Name          Description
-- ------- ---------- ------------- ------------------------
-- 1.0     06/06/2024 Sridhar Morti initial version
-- 

SET serverout ON

declare
    v_error        varchar2 ( 100 );
    v_salary       number;
    v_new_salary   number;
begin

    -- Scenario 1 - Employee Name can not be empty
    v_error        := ldms_pkg.create_employee ( ''
                                                ,'Manager'
                                                ,'John Smith'
                                                ,'23-SEP-03'
                                                ,52500
                                                ,'Sales' );

    if v_error = 'Employee Name can not be empty'
    then
        dbms_output.put_line (
            'Test Scenario 1 is Successful. Employee Name can not be empty' );
    else
        dbms_output.put_line (
            'Test Scenario 1 failed. Employee Name can not be empty' );
    end if;

    -- Scenario 2 - Job Title can not be empty
    v_error        := ldms_pkg.create_employee ( 'Jimmy Willis'
                                                ,''
                                                ,'John Smith'
                                                ,'23-SEP-03'
                                                ,52500
                                                ,'Sales' );

    if v_error = 'Job Title can not be empty'
    then
        dbms_output.put_line (
            'Test Scenario 2 is Successful. Job Title can not be empty' );
    else
        dbms_output.put_line (
            'Test Scenario 2 failed. Job Title can not be empty' );
    end if;

    -- Scenario 3 - Date Hired can not be empty
    v_error        := ldms_pkg.create_employee ( 'Jimmy Willis'
                                                ,'Manager'
                                                ,'John Smith'
                                                ,to_date ( null )
                                                ,52500
                                                ,'Sales' );

    if v_error = 'Date Hired can not be empty'
    then
        dbms_output.put_line (
            'Test Scenario 3 is Successful. Date Hired can not be empty' );
    else
        dbms_output.put_line (
            'Test Scenario 3 failed. Date Hired can not be empty' );
    end if;

    -- Scenario 4 - Salary can not be empty
    v_error        := ldms_pkg.create_employee ( 'Jimmy Willis'
                                                ,'Manager'
                                                ,'John Smith'
                                                ,'23-SEP-03'
                                                ,null
                                                ,'Sales' );

    if v_error = 'Salary can not be empty'
    then
        dbms_output.put_line (
            'Test Scenario 4 is Successful. Salary can not be empty' );
    else
        dbms_output.put_line (
            'Test Scenario 4 failed. Salary can not be empty' );
    end if;

    -- Scenario 5 - Salary can not be Negative
    v_error        := ldms_pkg.create_employee ( 'Jimmy Willis'
                                                ,'Manager'
                                                ,'John Smith'
                                                ,'23-SEP-03'
                                                ,-52500
                                                ,'Sales' );

    if v_error = 'Salary can not be Negative'
    then
        dbms_output.put_line (
            'Test Scenario 5 is Successful. Salary can not be Negative' );
    else
        dbms_output.put_line (
            'Test Scenario 5 failed. Salary can not be Negative' );
    end if;

    -- Scenario 6 - Department name can not be empty

    v_error        := ldms_pkg.create_employee ( 'Jimmy Willis'
                                                ,'Manager'
                                                ,'John Smith'
                                                ,'23-SEP-03'
                                                ,52500
                                                ,'' );

    if v_error = 'Department name can not be empty'
    then
        dbms_output.put_line (
            'Test Scenario 6 is Successful. Department name can not be empty' );
    else
        dbms_output.put_line (
            'Test Scenario 6 failed. Department name can not be empty' );
    end if;

    -- Scenario 7 - Employee already exists in the system

    v_error        := ldms_pkg.create_employee ( 'Jimmy Willis'
                                                ,'Manager'
                                                ,'John Smith'
                                                ,'23-SEP-03'
                                                ,52500
                                                ,'Sales' );

    if v_error = 'Employee already exists in the system'
    then
        dbms_output.put_line (
            'Test Scenario 7 is Successful. Employee already exists in the system' );
    else
        dbms_output.put_line (
            'Test Scenario 7 failed. Employee does not exist in the system' );
    end if;

    -- Scenario 8 - Manager does not exist in the system
    v_error        := ldms_pkg.create_employee ( 'Neelima Morti'
                                                ,'Manager'
                                                ,'Sridhar Morti'
                                                ,'23-SEP-03'
                                                ,52500
                                                ,'Sales' );

    if v_error = 'Manager does not exist in the system'
    then
        dbms_output.put_line (
            'Test Scenario 8 is failed. Manager does not exist in the system' );
    else
        dbms_output.put_line (
            'Test Scenario 8 successful. Manager exists in the system' );
    end if;

    -- Scenario 9 - Department does not exist in the system

    v_error        := ldms_pkg.create_employee ( 'Neelima Morti'
                                                ,'Manager'
                                                ,'John Smith'
                                                ,'23-SEP-03'
                                                ,52500
                                                ,'New Sales' );

    if v_error = 'Department does not exist in the system'
    then
        dbms_output.put_line (
            'Test Scenario 9 is failed. Department does not exist in the system' );
    else
        dbms_output.put_line (
            'Test Scenario 9 successful. Department exists in the system' );
    end if;

    -- Scenario 10 - Create an employee Successfully

    v_error        := ldms_pkg.create_employee ( 'Neelima Morti'
                                                ,'Manager'
                                                ,'John Smith'
                                                ,'23-SEP-03'
                                                ,52500
                                                ,'Sales' );

    if v_error = 'SUCCESS'
    then
        dbms_output.put_line (
            'Test Scenario 10 is Successful. Employee is created successfully' );
    else
        dbms_output.put_line (
            'Test Scenario 10 failed. Employee creation failed' );
    end if;

    -- Scenario 11 - Get Salary

    v_salary       := ldms_pkg.get_salary ( 'Neelima Morti' );
 
    if v_salary = 52500
    then
        dbms_output.put_line (
            'Test Scenario 11 is Successful. Get Salary function tested successfully' );
    else
        dbms_output.put_line (
            'Test Scenario 11 failed. Get Salary function failed to return correct salary' );
    end if;

    -- Scenario 12 - Change Salary
    v_error        := ldms_pkg.change_salary ( 'Neelima Morti', 10 );

    -- Scenario 12 - fetch new salary

    v_new_salary   := ldms_pkg.get_salary ( 'Neelima Morti' );

    if v_new_salary = v_salary + v_salary * 10 / 100
    then
        dbms_output.put_line (
            'Test Scenario 12 is Successful. Change Salary function tested successfully' );
    else
        dbms_output.put_line (
            'Test Scenario 12 failed. Change Salary function failed to change salary correctly' );
    end if;

    -- Scenario 13 - Change Department was Successful

    v_error        :=
        ldms_pkg.change_department ( 'Neelima Morti', 'Engineering' );

    if v_error = 'SUCCESS'
    then
        dbms_output.put_line (
            'Test Scenario 13 is Successful. Change Department was successful' );
    else
        dbms_output.put_line (
            'Test Scenario 13 failed. Change Department Failed' );
    end if;

end;
/
