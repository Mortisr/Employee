create or replace package body ldms_pkg
as
    --
    -- Purpose : This package Body contains code for all related
    --           functions and procedures for LDMS Employees
    -- Version History
    -- version date       Name          Description
    -- ------- ---------- ------------- ------------------------
    -- 1.0     06/06/2024 Sridhar Morti initial version
    --

    function get_emp_details ( ip_employee_name in varchar2 )
        return number
    is

        cursor c_employee_details ( ip_employee_name in varchar2 )
        is
            select employee_id
              from ldms_employees
             where upper ( employee_name ) = upper ( ip_employee_name )
               and nvl ( end_date, sysdate ) >= sysdate;

        v_employee_id   number;
        v_error varchar2(50);

    begin
        open c_employee_details ( ip_employee_name );
        fetch c_employee_details into v_employee_id;

        if c_employee_details%notfound
        then
            v_error   := 'Employee details not found';
            close c_employee_details;
            return -1;
        end if;

        close c_employee_details;

        return v_employee_id;

    end get_emp_details;

    function get_department ( ip_department_name in varchar2 )
        return number
    is

        cursor c_department ( ip_department_name in varchar2 )
        is
            select department_id
              from ldms_departments
             where upper ( department_name ) = upper ( ip_department_name );

        v_department_id   number;
        v_error varchar2(50);

    begin

        open c_department ( ip_department_name );
        fetch c_department into v_department_id;

        if c_department%notfound
        then
            v_error   := 'Department does not exist in the system';
            close c_department;

            return -1;
        end if;

        close c_department;

        return v_department_id;

    end get_department;

    function create_employee ( p_employee_name     varchar2
                              ,p_job_title         varchar2
                              ,p_manager_name      varchar2
                              ,p_date_hired        date
                              ,p_end_date          date
                              ,p_salary            number
                              ,p_department_name   varchar2 )
        return varchar2
    is

        v_employee_id     number;
        v_manager_id      number;
        v_department_id   number;
        v_error           varchar2 ( 100 );

    begin
        if p_employee_name is null
        then
            v_error   := 'Employee Name can not be empty';
            return v_error;
        end if;

        if p_job_title is null
        then
            v_error   := 'Job Title can not be empty';
            return v_error;
        end if;

        if p_date_hired is null
        then
            v_error   := 'Date Hired can not be empty';
            return v_error;
        end if;

        if nvl ( p_salary, 0 ) = 0
        then
            v_error   := 'Salary can not be empty';
            return v_error;
        end if;

        if nvl ( p_salary, 0 ) < 0
        then
            v_error   := 'Salary can not be Negative';
            return v_error;
        end if;

        if p_department_name is null
        then
            v_error   := 'Department name can not be empty';
            return v_error;
        end if;

        -- Check if employee already exists otherwise create a new employee

        v_employee_id := get_emp_details(p_employee_name);

        if nvl(v_employee_id, -1) = -1 
        then 
           select ldms_employee_seq.nextval into v_employee_id from dual;
        else
            v_error   := 'Employee already exists in the system';
            return v_error;
        end if;

        -- Check if manager exists in the system

        v_manager_id := get_emp_details( p_manager_name );
        
        if nvl(v_manager_id, -1) = -1
        then
            v_error   := 'Manager does not exist in the system';
            return v_error;
        end if;
          
        -- Check if product type already exists otherwise create a new product type

        v_department_id := get_department( p_department_name );

        if nvl(v_department_id, -1) = -1
        then
            v_error   := 'Department does not exist in the system';
            return v_error;
        end if;

        --All validations successful. So create new employee

        insert into ldms_employees ( employee_id
                                    ,employee_name
                                    ,job_title
                                    ,manager_id
                                    ,date_hired
                                    ,end_date
                                    ,salary
                                    ,department_id )
             values ( v_employee_id
                     ,p_employee_name
                     ,p_job_title
                     ,v_manager_id
                     ,p_date_hired
                     ,p_end_date
                     ,p_salary
                     ,v_department_id );

        return ('SUCCESS');

    end create_employee;

    function change_department ( ip_employee_name     in varchar2
                                ,ip_department_name   in varchar2 )
        return varchar2
    is

        v_error           varchar2 ( 100 );
        v_employee_id     number;
        v_department_id   number;

    begin

        v_employee_id   := get_emp_details ( ip_employee_name );

        if v_employee_id <> -1
        then
            v_department_id   := get_department ( ip_department_name );
        end if;

        if v_department_id <> -1
        then
           update ldms_employees
              set department_id   = v_department_id
            where employee_id = v_employee_id;

           return 'SUCCESS';

        else
           return 'FAILED';
        end if;

    end change_department;

    function get_salary ( ip_employee_name in varchar2 )
        return number
    is

        cursor c_employee_details ( ip_employee_name in varchar2 )
        is
            select salary
              from ldms_employees
             where upper ( employee_name ) = upper ( ip_employee_name )
               and nvl ( end_date, sysdate ) >= sysdate;

        v_error    varchar2 ( 100 );
        v_salary   number;

    begin
        open c_employee_details ( ip_employee_name );
        fetch c_employee_details into v_salary;

        if c_employee_details%notfound
        then
            v_error   := 'Employee details not found';
            return -1;
        end if;

        close c_employee_details;
        return v_salary;

    end get_salary;

    function change_salary ( ip_employee_name   in varchar2
                            ,ip_percentage      in number )
        return varchar2
    is

        cursor c_employee_details ( ip_employee_name in varchar2 )
        is
            select employee_id, salary
              from ldms_employees
             where upper ( employee_name ) = upper ( ip_employee_name )
               and nvl ( end_date, sysdate ) >= sysdate;

        v_error         varchar2 ( 100 );
        v_employee_id   number;
        v_salary        number;

    begin
        v_employee_id   := get_emp_details ( ip_employee_name );
        v_salary        := get_salary ( ip_employee_name );

        if v_employee_id <> -1 and v_salary <> -1
        then
            update ldms_employees
               set salary   = v_salary + v_salary * ip_percentage / 100
             where employee_id = v_employee_id;
        end if;

        return 'SUCCESS';

    end change_salary;

end ldms_pkg;
/
