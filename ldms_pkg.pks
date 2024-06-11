create or replace package ldms_pkg
as
    --
    -- Purpose : This package specification contains all related
    --           functions and procedures for LDMS Employees
    -- Version History
    -- version date       Name          Description
    -- ------- ---------- ------------- ------------------------
    -- 1.0     05/06/2024 Sridhar Morti initial version
    --
    function create_employee ( p_employee_name     varchar2
                              ,p_job_title         varchar2
                              ,p_manager_name      varchar2
                              ,p_date_hired        date
                              ,p_end_date          date
                              ,p_salary            number
                              ,p_department_name   varchar2 )
        return varchar2;

    function change_salary ( ip_employee_name   in varchar2
                            ,ip_percentage      in number )
        return varchar2;

    function change_department ( ip_employee_name     in varchar2
                                ,ip_department_name   in varchar2 )
        return varchar2;

    function get_salary ( ip_employee_name in varchar2 )
        return number;

end ldms_pkg;
/
