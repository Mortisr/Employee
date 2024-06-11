-- 
-- Purpose : This report displays total salary of employees for 
--           a given department 
-- Version History
-- version date       Name          Description
-- ------- ---------- ------------- ------------------------
-- 1.0     06/06/2024 Sridhar Morti initial version
-- 
SET FEEDBACK OFF 
SPOOL Total_Salary.txt
TTITLE “Total Salary for a department” 
BTITLE “***** END OF REPORT *****” 

SELECT SUM(salary) 
FROM ldms_employees 
WHERE department_id = ( SELECT department_id
                        FROM   ldms_departments
                        WHERE  upper(department_name) = upper(&department_name)
                       )
; 

SPOOL OFF                      