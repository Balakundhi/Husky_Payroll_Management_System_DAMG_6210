SET SERVEROUTPUT ON;

BEGIN
    -- Attempt to drop each view if it exists
    FOR v IN (SELECT 'VIEW_DEPARTMENT' AS view_name FROM dual
              UNION ALL
              SELECT 'VIEW_SUPERVISOR' FROM dual
              UNION ALL
              SELECT 'VIEW_JOBS' FROM dual
              UNION ALL
              SELECT 'VIEW_STUDENT_JOBS' FROM dual
              UNION ALL
              SELECT 'VIEW_STUDENTS' FROM dual
              UNION ALL
              SELECT 'VIEW_ATTENDANCE' FROM dual
              UNION ALL
              SELECT 'VIEW_PAYROLL' FROM dual
              UNION ALL
              SELECT 'CURRENT_SALARY' FROM dual
              UNION ALL
              SELECT 'VIEW_PAYROLL_DETAILS' FROM dual)
    LOOP
        BEGIN
            EXECUTE IMMEDIATE 'DROP VIEW ' || v.view_name;
            DBMS_OUTPUT.PUT_LINE(v.view_name || ' view dropped.');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(v.view_name || ' view does not exist. Continuing.');
        END;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
        
END;
/

CREATE VIEW VIEW_DEPARTMENT AS SELECT * FROM DEPARTMENT;
CREATE VIEW VIEW_SUPERVISOR AS SELECT * FROM SUPERVISOR;
CREATE VIEW VIEW_JOBS AS SELECT * FROM JOBS;
CREATE VIEW VIEW_STUDENTS AS SELECT * FROM STUDENTS;
CREATE VIEW VIEW_STUDENT_JOBS AS SELECT * FROM STUDENT_JOBS;
CREATE VIEW VIEW_ATTENDANCE AS SELECT * FROM ATTENDANCE;
CREATE VIEW VIEW_PAYROLL AS SELECT * FROM PAYROLL;
CREATE VIEW CURRENT_SALARY AS
SELECT p.NU_ID, p.JOB_ID, j.HOURLY_WAGE, p.START_DATE, p.END_DATE, (p.HOURS_WORKED * j.HOURLY_WAGE) AS SALARY
FROM PAYROLL p
JOIN JOBS j
ON p.JOB_ID = j.JOB_ID
WHERE p.START_DATE <= SYSDATE AND p.END_DATE >= SYSDATE;
--CREATING A VIEW FOR ALL THE PAYROLL ENTRIES
CREATE VIEW VIEW_PAYROLL_DETAILS AS
SELECT
    s.STUDENT_FIRST_NAME,
    s.STUDENT_LAST_NAME,
    p.NU_ID,
    p.START_DATE,
    p.END_DATE,
    SUM(p.HOURS_WORKED) AS HOURS_WORKED,
    SUM(p.GROSS_PAY) AS GROSS_PAY
FROM
    PAYROLL p
JOIN
    STUDENTS s ON p.NU_ID = s.NU_ID
GROUP BY
    p.START_DATE,
    p.END_DATE,
    p.NU_ID,
    s.STUDENT_FIRST_NAME,
    s.STUDENT_LAST_NAME,
    s.STUDENT_EMAIL,
    s.STUDENT_MOBILE_NUMBER,
    s.STUDENT_ADDRESS,
    s.HIRE_DATE,
    s.BANK_ACCOUNT_NUMBER
ORDER BY
    p.START_DATE DESC;


CREATE OR REPLACE PROCEDURE INSERT_ATTENDANCE(V_DATE DATE, V_LOG_IN TIMESTAMP, V_LOG_OFF TIMESTAMP, V_NU_ID NUMBER, V_JOB_ID VARCHAR2) IS
BEGIN
    INSERT INTO VIEW_ATTENDANCE(ATTENDANCE_DATE,LOG_IN,LOG_OFF,NU_ID,JOB_ID)
    VALUES(to_date(V_DATE, 'DD-MON-YY'), TO_TIMESTAMP(V_LOG_IN, 'DD-MON-YY HH.MI.SS.FF9 AM'), TO_TIMESTAMP(V_LOG_OFF, 'DD-MON-YY HH.MI.SS.FF9 AM'), V_NU_ID, V_JOB_ID);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_ATTENDANCE(
    V_ATTENDANCE_ID NUMBER,
    V_DATE DATE,
    V_LOG_IN TIMESTAMP,
    V_LOG_OFF TIMESTAMP,
    V_NU_ID NUMBER,
    V_JOB_ID VARCHAR2
) IS
BEGIN
    UPDATE VIEW_ATTENDANCE
    SET
        ATTENDANCE_DATE = V_DATE,
        LOG_IN = V_LOG_IN,
        LOG_OFF = V_LOG_OFF,
        NU_ID = V_NU_ID,
        JOB_ID = V_JOB_ID
    WHERE ATTENDANCE_ID = V_ATTENDANCE_ID;
    COMMIT;
END;
/


CREATE OR REPLACE PROCEDURE DELETE_ATTENDANCE(V_ATTENDANCE_ID NUMBER) IS
BEGIN
    DELETE FROM VIEW_ATTENDANCE
    WHERE ATTENDANCE_ID = V_ATTENDANCE_ID;
    COMMIT;
END;
/

--SET SERVEROUTPUT ON;
--CREATING A VIEW FOR ALL THE PAYROLL ENTRIES
--SELECT * FROM VIEW_PAYROLL_DETAILS;



SET SERVEROUTPUT ON;
--CREATING A STORED FUNCTION TO DISPLAY A WEEKLY STUB OF A STUDENT IN SPECIFIC MONTH
CREATE OR REPLACE PROCEDURE GET_PAYROLL_DETAILS (
    p_NU_ID IN NUMBER,
    p_month IN VARCHAR2
) IS
BEGIN
    FOR rec IN (
        SELECT
            p.NU_ID,
            s.STUDENT_FIRST_NAME,
            s.STUDENT_LAST_NAME,
            j.JOB_NAME,
            d.DEPARTMENT_NAME,
            p.START_DATE,
            p.END_DATE,
            SUM(p.HOURS_WORKED) AS HOURS_WORKED,
            SUM(p.GROSS_PAY) AS GROSS_PAY
        FROM
            PAYROLL p
        JOIN
            STUDENTS s ON p.NU_ID = s.NU_ID
        JOIN
            ATTENDANCE a ON p.ATTENDANCE_ID = a.ATTENDANCE_ID
        JOIN
            STUDENT_JOBS sj ON a.NU_ID = sj.NU_ID AND a.JOB_ID = sj.JOB_ID
        JOIN
            JOBS j ON sj.JOB_ID = j.JOB_ID
        JOIN
            SUPERVISOR sp ON j.EMPLOYEE_ID = sp.EMPLOYEE_ID
        JOIN
            DEPARTMENT d ON sp.DEPARTMENT_ID = d.DEPARTMENT_ID
        WHERE
            p.NU_ID = p_NU_ID
            AND TO_CHAR(p.END_DATE, 'MON') = p_month
        GROUP BY
            p.START_DATE,
            p.END_DATE,
            p.NU_ID,
            s.STUDENT_FIRST_NAME,
            s.STUDENT_LAST_NAME,
            j.JOB_NAME,
            d.DEPARTMENT_NAME
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('NU_ID: ' || rec.NU_ID);
        DBMS_OUTPUT.PUT_LINE('First Name: ' || rec.STUDENT_FIRST_NAME);
        DBMS_OUTPUT.PUT_LINE('Last Name: ' || rec.STUDENT_LAST_NAME);
        DBMS_OUTPUT.PUT_LINE('Job Name: ' || rec.JOB_NAME);
        DBMS_OUTPUT.PUT_LINE('Department Name: ' || rec.DEPARTMENT_NAME);
        DBMS_OUTPUT.PUT_LINE('Start Date: ' || rec.START_DATE);
        DBMS_OUTPUT.PUT_LINE('End Date: ' || rec.END_DATE);
        DBMS_OUTPUT.PUT_LINE('Total Hours Worked: ' || rec.HOURS_WORKED);
        DBMS_OUTPUT.PUT_LINE('Total Gross Pay: ' || rec.GROSS_PAY);
        DBMS_OUTPUT.PUT_LINE('------------------------');
    END LOOP;
END GET_PAYROLL_DETAILS;
/


--EXEC GET_PAYROLL_DETAILS(6479036,'NOV');
--EXEC GET_PAYROLL_DETAILS(5837122,'DEC');

--select * from attendance;



--DISPLAY A LIST OF ALL VACANT JOBS
CREATE OR REPLACE PROCEDURE VACANT_JOBS IS
BEGIN
    FOR rec IN (
        SELECT
            j.JOB_ID,
            j.JOB_NAME,
            j.BAND,
            j.HOURLY_WAGE,
            j.CONTRACT_START_DATE,
            j.CONTRACT_END_DATE,
            j.EMPLOYEE_ID
        FROM
            JOBS j
        LEFT JOIN
            STUDENT_JOBS sj ON j.JOB_ID = sj.JOB_ID
        WHERE
            sj.NU_ID IS NULL
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Job ID: ' || rec.JOB_ID);
        DBMS_OUTPUT.PUT_LINE('Job Name: ' || rec.JOB_NAME);
        DBMS_OUTPUT.PUT_LINE('Band: ' || rec.BAND);
        DBMS_OUTPUT.PUT_LINE('Hourly Wage: ' || rec.HOURLY_WAGE);
        DBMS_OUTPUT.PUT_LINE('Contract Start Date: ' || rec.CONTRACT_START_DATE);
        DBMS_OUTPUT.PUT_LINE('Contract End Date: ' || rec.CONTRACT_END_DATE);
        DBMS_OUTPUT.PUT_LINE('------------------------');
    END LOOP;
END VACANT_JOBS;
/

--EXEC GET_JOBS_WITH_NULL_NU_ID;



--A STORED PROCEDURE TO DISPLAY A SPECIFIC JOB PROFILE. TAKES JOB_ID AS PARAMETER
CREATE OR REPLACE PROCEDURE GET_JOB_PROFILE (
    p_job_id IN VARCHAR2
) IS
    v_job_name JOBS.JOB_NAME%TYPE;
    v_band JOBS.BAND%TYPE;
    v_hourly_wage JOBS.HOURLY_WAGE%TYPE;
    v_contract_start_date JOBS.CONTRACT_START_DATE%TYPE;
    v_contract_end_date JOBS.CONTRACT_END_DATE%TYPE;
    v_supervisor_name SUPERVISOR.FIRST_NAME%TYPE;
    v_department_name DEPARTMENT.DEPARTMENT_NAME%TYPE;
    v_department_address DEPARTMENT.ADDRESS%TYPE;
BEGIN
    -- Retrieve job details
    SELECT
        j.JOB_NAME,
        j.BAND,
        j.HOURLY_WAGE,
        j.CONTRACT_START_DATE,
        j.CONTRACT_END_DATE,
        s.FIRST_NAME || ' ' || s.LAST_NAME,
        d.DEPARTMENT_NAME,
        d.ADDRESS
    INTO
        v_job_name,
        v_band,
        v_hourly_wage,
        v_contract_start_date,
        v_contract_end_date,
        v_supervisor_name,
        v_department_name,
        v_department_address
    FROM
        JOBS j
    JOIN
        SUPERVISOR s ON j.EMPLOYEE_ID = s.EMPLOYEE_ID
    JOIN
        DEPARTMENT d ON s.DEPARTMENT_ID = d.DEPARTMENT_ID
    WHERE
        j.JOB_ID = p_job_id;

    -- Display job profile
    DBMS_OUTPUT.PUT_LINE('Job ID: ' || p_job_id);
    DBMS_OUTPUT.PUT_LINE('Job Name: ' || v_job_name);
    DBMS_OUTPUT.PUT_LINE('Band: ' || v_band);
    DBMS_OUTPUT.PUT_LINE('Hourly Wage: ' || v_hourly_wage);
    DBMS_OUTPUT.PUT_LINE('Contract Start Date: ' || v_contract_start_date);
    DBMS_OUTPUT.PUT_LINE('Contract End Date: ' || v_contract_end_date);
    DBMS_OUTPUT.PUT_LINE('Supervisor: ' || v_supervisor_name);
    DBMS_OUTPUT.PUT_LINE('Department: ' || v_department_name);
    DBMS_OUTPUT.PUT_LINE('Department Address: ' || v_department_address);
END GET_JOB_PROFILE;
/

--EXEC GET_JOB_PROFILE('J0011');
