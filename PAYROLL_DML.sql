SET SERVEROUTPUT ON;

DECLARE
    v_hours_worked NUMBER := 20;  -- Fixed hours worked
    v_gross_pay NUMBER;
    v_hourly_wage NUMBER;
BEGIN
    -- First, clean up existing data from PAYROLL
    DELETE FROM PAYROLL;
    DBMS_OUTPUT.PUT_LINE('Existing payroll records deleted.');

    -- Then, insert new records
    FOR rec IN (SELECT a.ATTENDANCE_ID, a.NU_ID, a.JOB_ID, a.ATTENDANCE_DATE, j.BAND, j.HOURLY_WAGE
                FROM ATTENDANCE a
                INNER JOIN JOBS j ON a.JOB_ID = j.JOB_ID)
    LOOP
        -- Using the HOURLY_WAGE directly from the cursor variable 'rec'
        v_hourly_wage := rec.HOURLY_WAGE;
        v_gross_pay := v_hours_worked * v_hourly_wage; -- Calculate the gross pay

        -- Insert record into PAYROLL
        INSERT INTO PAYROLL (
            START_DATE, 
            END_DATE, 
            HOURS_WORKED, 
            GROSS_PAY, 
            PREV_PAYROLL_STATUS, 
            ATTENDANCE_ID, 
            NU_ID, 
            JOB_ID, 
            ATTENDANCE_DATE
        ) VALUES (
            TRUNC(SYSDATE, 'MM'),  -- Start of the current month
            TRUNC(SYSDATE),  -- Current day
            v_hours_worked,
            v_gross_pay,
            'Y',  -- Assuming 'Y' means Yes for PREV_PAYROLL_STATUS
            rec.ATTENDANCE_ID,
            rec.NU_ID,
            rec.JOB_ID,
            rec.ATTENDANCE_DATE
        );
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Payroll records added successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/


