
alter session set current_schema=APP_ADMIN;
SET SERVEROUTPUT ON;

--STUDENT_USER can get to see job profile.
EXEC APP_ADMIN.GET_JOB_PROFILE('J0011');

--A STUDENT_USER with NU_ID = 5837122 can get to see entire payroll details of specific month
EXEC APP_ADMIN.GET_PAYROLL_DETAILS(5837122,'NOV');

-- A STUDENT_USER can get to see if there are any Vacant Jobs
EXEC APP_ADMIN.VACANT_JOBS;





