ALTER SESSION SET CURRENT_SCHEMA = APP_ADMIN;
SET SERVEROUTPUT ON;
SELECT * FROM APP_ADMIN.VIEW_ATTENDANCE;



--NA_SUPERVISOR can insert attendance record
EXEC APP_ADMIN.INSERT_ATTENDANCE('02-NOV-23', '02-NOV-23 02.00.00.000000000 PM', '02-NOV-23 07.00.00.000000000 PM', 6479036, 'J0011');


--NA_SUPERVISOR can update attendance record
EXEC APP_ADMIN.UPDATE_ATTENDANCE(141,'02-NOV-23', '02-NOV-23 01.00.00.000000000 PM', '02-NOV-23 06.00.00.000000000 PM', 6479036, 'J0011');

--NA_SUPERVISOR can delete attendance record
EXEC APP_ADMIN.DELETE_ATTENDANCE(141);

