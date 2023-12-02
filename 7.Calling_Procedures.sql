-- Call to Add_Department procedures
EXEC RECORDS_PACKAGE.Add_Department('NEU01', 'Snell Library', 'Snell Library');
EXEC RECORDS_PACKAGE.Add_Department('NEU02', 'CSC', 'Curry Student Centre');
EXEC RECORDS_PACKAGE.Add_Department('NEU03', 'OGS', 'Richards Hall');
EXEC RECORDS_PACKAGE.Add_Department('NEU04', 'Dunkins', 'Hayden Hall');
EXEC RECORDS_PACKAGE.Add_Department('NEU05', 'NRS', 'Cullinane Hall');
EXEC RECORDS_PACKAGE.Add_Department('NEU06', 'Admissions', 'Snell Engineering Centre');


-- Call to Add_Supervisor procedures
EXEC RECORDS_PACKAGE.Add_Supervisor('SUP01', 'Michael', 'Brown', 'michael.brown@northeast.edu', 2025550201, 'NEU01');
EXEC RECORDS_PACKAGE.Add_Supervisor('SUP02', 'Laura', 'Wilson', 'laura.wilson@northeast.edu', 2025550202, 'NEU02');
EXEC RECORDS_PACKAGE.Add_Supervisor('SUP03', 'Brian', 'Davis', 'brian.davis@northeast.edu', 2025550203, 'NEU03');
EXEC RECORDS_PACKAGE.Add_Supervisor('SUP04', 'Jessica', 'Taylor', 'jessica.taylor@northeast.edu', 2025550204, 'NEU04');
EXEC RECORDS_PACKAGE.Add_Supervisor('SUP05', 'James', 'Anderson', 'james.anderson@northeast.edu', 2025550205, 'NEU05');
EXEC RECORDS_PACKAGE.Add_Supervisor('SUP06', 'Sarah', 'Martinez', 'sarah.martinez@northeast.edu', 2025550206, 'NEU06');


-- Call to Add_Job procedures
EXEC RECORDS_PACKAGE.Add_Job('J0011', 'Library Assistant', 'A',TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'SUP01');
EXEC RECORDS_PACKAGE.Add_Job('J0012', 'Library Assistant', 'A',TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'SUP01');
EXEC RECORDS_PACKAGE.Add_Job('J0021', 'Receptionist', 'B', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'SUP02');
EXEC RECORDS_PACKAGE.Add_Job('J0022', 'Receptionist', 'B', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'SUP02');
EXEC RECORDS_PACKAGE.Add_Job('J0031', 'GSM Mentor', 'B',TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'SUP03');
EXEC RECORDS_PACKAGE.Add_Job('J0041', 'Crew Member', 'A', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'SUP04');
EXEC RECORDS_PACKAGE.Add_Job('J0051', 'RSO', 'C',TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'SUP05');
EXEC RECORDS_PACKAGE.Add_Job('J0052', 'RSO', 'C',TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'SUP05');
EXEC RECORDS_PACKAGE.Add_Job('J0053', 'RSO', 'C',TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'SUP05');
EXEC RECORDS_PACKAGE.Add_Job('J0061', 'FCE', 'C',TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'SUP06');
EXEC RECORDS_PACKAGE.Add_Job('J0062', 'FCE', 'C',TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'SUP06');
EXEC RECORDS_PACKAGE.Add_Job('J0063', 'FCE', 'C',TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'SUP06');


-- Call to Add_Student procedures
EXEC RECORDS_PACKAGE.Add_Student(6479036, 'Arjun', 'Patel', 'arjun.patel@northeast.edu', 2025550189, '123 Beacon St, Boston, MA', TO_DATE('2023-11-01', 'YYYY-MM-DD'), 123456789101);
EXEC RECORDS_PACKAGE.Add_Student(1538793, 'Priya', 'Gupta', 'priya.gupta@northeast.edu', 2025550143, '456 Newbury St, Boston, MA', TO_DATE('2023-11-01', 'YYYY-MM-DD'), 234567891012);
EXEC RECORDS_PACKAGE.Add_Student(9714722, 'Ravi', 'Kumar', 'ravi.kumar@northeast.edu', 2025550167, '789 Tremont St, Boston, MA', TO_DATE('2023-11-01', 'YYYY-MM-DD'), 345678910123);
EXEC RECORDS_PACKAGE.Add_Student(5837122, 'Anjali', 'Singh', 'anjali.singh@northeast.edu', 2025550198, '321 Dorchester Ave, Boston, MA', TO_DATE('2023-11-01', 'YYYY-MM-DD'), 456789101234);
EXEC RECORDS_PACKAGE.Add_Student(3278356, 'Nikhil', 'Sharma', 'nikhil.sharma@northeast.edu', 2025550125, '654 Boylston St, Boston, MA', TO_DATE('2023-11-01', 'YYYY-MM-DD'), 567891012345);
EXEC RECORDS_PACKAGE.Add_Student(1201969, 'Deepika', 'Joshi', 'deepika.joshi@northeast.edu', 2025550171, '987 Commonwealth Ave, Boston, MA', TO_DATE('2023-11-01', 'YYYY-MM-DD'), 678910123456);
EXEC RECORDS_PACKAGE.Add_Student(1885843, 'Vivek', 'Mehta', 'vivek.mehta@northeast.edu', 2025550139, '159 State St, Boston, MA', TO_DATE('2023-11-01', 'YYYY-MM-DD'), 789101234567);
EXEC RECORDS_PACKAGE.Add_Student(5621792, 'Neha', 'Iyer', 'neha.iyer@northeast.edu', 2025550156, '432 Charles St, Boston, MA', TO_DATE('2023-11-01', 'YYYY-MM-DD'), 891012345678);
EXEC RECORDS_PACKAGE.Add_Student(6374702, 'Suresh', 'Reddy', 'suresh.reddy@northeast.edu', 2025550112, '213 Hanover St, Boston, MA', TO_DATE('2023-11-01', 'YYYY-MM-DD'), 910123456789);
EXEC RECORDS_PACKAGE.Add_Student(2051359, 'Kavita', 'Nair', 'kavita.nair@northeast.edu', 2025550184, '678 Massachusetts Ave, Boston, MA', TO_DATE('2023-10-01', 'YYYY-MM-DD'), 101234567890);


-- Call to Add_Student_Job procedures
EXEC RECORDS_PACKAGE.Add_Student_Job(6479036, 'J0011');
EXEC RECORDS_PACKAGE.Add_Student_Job(1538793, 'J0021');
EXEC RECORDS_PACKAGE.Add_Student_Job(9714722, 'J0031');
EXEC RECORDS_PACKAGE.Add_Student_Job(5837122, 'J0041');
EXEC RECORDS_PACKAGE.Add_Student_Job(3278356, 'J0051');
EXEC RECORDS_PACKAGE.Add_Student_Job(1201969, 'J0061');
EXEC RECORDS_PACKAGE.Add_Student_Job(1885843, 'J0012');
EXEC RECORDS_PACKAGE.Add_Student_Job(5621792, 'J0052');
EXEC RECORDS_PACKAGE.Add_Student_Job(6374702, 'J0053');
EXEC RECORDS_PACKAGE.Add_Student_Job(2051359, 'J0062');