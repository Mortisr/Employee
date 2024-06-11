-- 
-- Purpose : This script creates test records for LDMS 
--           departments
-- Version History
-- version date       Name          Description
-- ------- ---------- ------------- ------------------------
-- 1.0     06/06/2024 Sridhar Morti initial version
-- 
-- Insert into LDMS_DEPARTMENTS

set define off

INSERT INTO ldms_departments
(department_id, department_name, location)
VALUES
(ldms_department_seq.nextval, 'Management', 'London' )
/

INSERT INTO ldms_departments
(department_id, department_name, location)
VALUES
(ldms_department_seq.nextval, 'Engineering', 'Cardiff' )
/

INSERT INTO ldms_departments
(department_id, department_name, location)
VALUES
(ldms_department_seq.nextval, 'Research & Development', 'Edinburgh' )
/

INSERT INTO ldms_departments
(department_id, department_name, location)
VALUES
(ldms_department_seq.nextval, 'Sales', 'Belfast' )
/

set define on
