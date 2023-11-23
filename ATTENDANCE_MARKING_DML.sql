CREATE OR REPLACE PROCEDURE ADD_ATTENDANCE(
    PI_NU_ID STUDENTS.NU_ID%TYPE,
    PI_JOB_ID JOBS.JOB_ID%TYPE,
    PI_START_DATE DATE,
    PI_END_DATE DATE)
AS
BEGIN
    -- First, delete existing attendance records for this student and job within the date range
    EXECUTE IMMEDIATE 'DELETE FROM ATTENDANCE WHERE NU_ID = :1 AND JOB_ID = :2 AND ATTENDANCE_DATE BETWEEN :3 AND :4'
    USING PI_NU_ID, PI_JOB_ID, PI_START_DATE, PI_END_DATE;

    -- Loop from the start date to the end date
    FOR current_day IN (SELECT PI_START_DATE + LEVEL - 1 AS ATTENDANCE_DAY, LEVEL AS DAY_INDEX
                        FROM dual
                        CONNECT BY LEVEL <= PI_END_DATE - PI_START_DATE + 1)
    LOOP
        -- Determine the shift time based on the day index (odd or even)
        IF MOD(current_day.DAY_INDEX, 2) = 0 THEN
            -- Insert an attendance record for each day with 9 AM to 2 PM shift
            INSERT INTO ATTENDANCE (ATTENDANCE_DATE, LOG_IN, LOG_OFF, NU_ID, JOB_ID)
            VALUES (current_day.ATTENDANCE_DAY, 
                    current_day.ATTENDANCE_DAY + INTERVAL '9' HOUR,
                    current_day.ATTENDANCE_DAY + INTERVAL '14' HOUR,
                    PI_NU_ID, 
                    PI_JOB_ID);
        ELSE
            -- Insert an attendance record for each day with 2 PM to 7 PM shift
            INSERT INTO ATTENDANCE (ATTENDANCE_DATE, LOG_IN, LOG_OFF, NU_ID, JOB_ID)
            VALUES (current_day.ATTENDANCE_DAY, 
                    current_day.ATTENDANCE_DAY + INTERVAL '14' HOUR,
                    current_day.ATTENDANCE_DAY + INTERVAL '19' HOUR,
                    PI_NU_ID, 
                    PI_JOB_ID);
        END IF;
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Attendance records updated for student ID: ' || PI_NU_ID);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        ROLLBACK;
END ADD_ATTENDANCE;
/

BEGIN
  ADD_ATTENDANCE(006479036, 'J001', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TRUNC(SYSDATE));
  ADD_ATTENDANCE(001538793, 'J002', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TRUNC(SYSDATE));
  ADD_ATTENDANCE(009714722, 'J003', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TRUNC(SYSDATE));
  ADD_ATTENDANCE(005837122, 'J004', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TRUNC(SYSDATE));
  ADD_ATTENDANCE(003278356, 'J005', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TRUNC(SYSDATE));
  ADD_ATTENDANCE(001201969, 'J006', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TRUNC(SYSDATE));
  ADD_ATTENDANCE(001885843, 'J001', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TRUNC(SYSDATE));
  ADD_ATTENDANCE(005621792, 'J005', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TRUNC(SYSDATE));
  ADD_ATTENDANCE(006374702, 'J005', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TRUNC(SYSDATE));
  ADD_ATTENDANCE(002051359, 'J006', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TRUNC(SYSDATE));
END;
/
