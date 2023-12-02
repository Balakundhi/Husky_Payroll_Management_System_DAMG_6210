-- Package Specification
CREATE OR REPLACE PACKAGE RECORDS_PACKAGE AS

    PROCEDURE Add_Department(
        department_id VARCHAR,
        department_name VARCHAR,
        address VARCHAR
    );

    PROCEDURE Add_Supervisor(
        employee_id VARCHAR2,
        first_name VARCHAR2,
        last_name VARCHAR2,
        email VARCHAR2,
        mobile_number NUMBER,
        department_id VARCHAR2
    );

    PROCEDURE Add_Job(
        job_id VARCHAR,
        job_name VARCHAR2,
        band CHAR,
        --hourly_wage NUMBER,
        contract_start_date DATE,
        contract_end_date DATE,
        employee_id VARCHAR2
    );

    PROCEDURE Add_Student(
        student_id NUMBER,
        first_name VARCHAR2,
        last_name VARCHAR2,
        email VARCHAR2,
        mobile_number NUMBER,
        address VARCHAR2,
        admission_date DATE,
        ssn NUMBER
    );

    PROCEDURE Add_Student_Job(
        nu_id NUMBER,
        job_id VARCHAR2
    );

END RECORDS_PACKAGE;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY RECORDS_PACKAGE AS

    PROCEDURE Add_Department(
        department_id VARCHAR,
        department_name VARCHAR,
        address VARCHAR
    ) AS
    BEGIN
        INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, ADDRESS) 
        VALUES (department_id, department_name, address);
        DBMS_OUTPUT.PUT_LINE('Records in Department Table Added');
        COMMIT;
    END Add_Department;

    PROCEDURE Add_Supervisor(
        employee_id VARCHAR2,
        first_name VARCHAR2,
        last_name VARCHAR2,
        email VARCHAR2,
        mobile_number NUMBER,
        department_id VARCHAR2
    ) AS
    BEGIN
        INSERT INTO SUPERVISOR (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, MOBILE_NUMBER, DEPARTMENT_ID) 
        VALUES (employee_id, first_name, last_name, email, mobile_number, department_id);
        DBMS_OUTPUT.PUT_LINE('Records in Supervisor Table Added');
        COMMIT;
    END Add_Supervisor;

    PROCEDURE Add_Job(
        job_id VARCHAR,
        job_name VARCHAR2,
        band CHAR,
        --hourly_wage NUMBER,
        contract_start_date DATE,
        contract_end_date DATE,
        employee_id VARCHAR2
    ) AS
    BEGIN
        INSERT INTO JOBS (JOB_ID, JOB_NAME, BAND, CONTRACT_START_DATE, CONTRACT_END_DATE, EMPLOYEE_ID) 
        VALUES (job_id, job_name, band, contract_start_date, contract_end_date, employee_id);
        DBMS_OUTPUT.PUT_LINE('Records in Job Table Added');
        COMMIT;
    END Add_Job;

    PROCEDURE Add_Student(
        student_id NUMBER,
        first_name VARCHAR2,
        last_name VARCHAR2,
        email VARCHAR2,
        mobile_number NUMBER,
        address VARCHAR2,
        admission_date DATE,
        ssn NUMBER
    ) AS
    BEGIN
        INSERT INTO STUDENTS 
        VALUES (student_id, first_name, last_name, email, mobile_number, address, admission_date, ssn);
        DBMS_OUTPUT.PUT_LINE('Records in Student Table Added');
        COMMIT;
    END Add_Student;

    PROCEDURE Add_Student_Job(
        nu_id NUMBER,
        job_id VARCHAR2
    ) AS
    BEGIN
        INSERT INTO STUDENT_JOBS (NU_ID, JOB_ID) 
        VALUES (nu_id, job_id);
        DBMS_OUTPUT.PUT_LINE('Records in Student-Job Added');
        COMMIT;
    END Add_Student_Job;

END RECORDS_PACKAGE;
/


