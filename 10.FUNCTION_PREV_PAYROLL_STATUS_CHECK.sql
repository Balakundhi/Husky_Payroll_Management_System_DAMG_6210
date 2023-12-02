CREATE OR REPLACE FUNCTION PREV_PAYROLL_STATUS_CHECK(
    p_nu_id IN PAYROLL.NU_ID%TYPE,
    p_job_id IN PAYROLL.JOB_ID%TYPE
) RETURN VARCHAR2
IS
    v_prev_status PAYROLL.PREV_PAYROLL_STATUS%TYPE;
BEGIN
    -- Attempt to retrieve the previous payroll status for the given NU_ID and JOB_ID
    SELECT PREV_PAYROLL_STATUS INTO v_prev_status
    FROM PAYROLL
    WHERE NU_ID = p_nu_id AND JOB_ID = p_job_id
    AND ROWNUM = 1; 

    -- Check if the status is 'N' and return the  message
    IF v_prev_status = 'N' THEN
        RETURN 'Contact your supervisor for previous settlement';
    ELSE
        RETURN v_prev_status; 
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'No record found';
    WHEN TOO_MANY_ROWS THEN
        RETURN 'Multiple records found'; 
    WHEN OTHERS THEN
        RETURN 'An error occurred'; 
END;
/

SELECT PREV_PAYROLL_STATUS_CHECK(1201969, 'J0061') FROM DUAL;








