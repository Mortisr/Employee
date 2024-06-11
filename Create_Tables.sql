drop sequence ldms_employee_seq
/

create sequence ldms_employee_seq minvalue 90001
                                  maxvalue 999999999999999999999999999
                                  start with 90001
                                  increment by 1
                                  cache 20
/

drop sequence ldms_department_seq
/

create sequence ldms_department_seq minvalue 1
                                    maxvalue 999999999999999999999999999
                                    start with 1
                                    increment by 1
                                    cache 20
/

drop table ldms_departments
/

create table ldms_departments
(
    department_id      number ( 5 ) not null primary key
   ,department_name    varchar2 ( 50 ) not null
   ,location           varchar2 ( 50 ) not null
)
/

drop table ldms_employees
/

create table ldms_employees
(
    employee_id      number ( 10 ) not null primary key
   ,employee_name    varchar2 ( 50 ) not null
   ,job_title        varchar2 ( 50 ) not null
   ,manager_id       number ( 10 )
   ,date_hired       date not null
   ,end_date         date
   ,salary           number ( 10 ) not null
   ,department_id    number ( 5 ) not null
   ,constraint manager_fk foreign key ( manager_id )
        references ldms_employees ( employee_id ) on delete set null
   ,constraint department_fk foreign key ( department_id )
        references ldms_departments ( department_id ) on delete set null
)
/
