-- 
-- Purpose : This report displays employees data for 
--           a given department 
-- Version History
-- version date       Name          Description
-- ------- ---------- ------------- ------------------------
-- 1.0     06/06/2024 Sridhar Morti initial version
-- 

SET FEEDBACK OFF 
SPOOL Employees.txt
TTITLE “List of Employees” 
BTITLE “***** END OF REPORT *****” 

SELECT * 
FROM ldms_employees 
WHERE department_id = ( SELECT department_id
                        FROM   ldms_departments
                        WHERE  upper(department_name) = upper(&department_name)
              )
ORDER BY employee_name; 

SPOOL OFF                      