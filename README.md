# Husky_Payroll_Management_System_DAMG_6210

Project title and introduction
The title of the project is ‘Husky Payroll Management System’. This is a project primarily deals with the payroll system for the students who are on part-time jobs. We have designed a comprehensive database that stores all the required details pertaining to the student, supervisor, and the job.


Objectives of the project
The primary objective of this project is to accurately calculate the employee salaries and maintain a centralized database of employee information, and generate relevant reports for management.


Assumptions
To replicate the exact real-world problem as an academic project requires a lot of time and resources. So, to make it possible, we assumed that every job has a daily four-hour shift during weekdays i.e., five working days. And since tax rules are similar for both local and international students, citizenship information is irrelevant to this project.



Scripts to be executed in the following order

1. ADMIN_SUPERVISOR_USER_CREATION  : This script creates the main user of our project.

2. PROJECT_3_Team12_Table_Creation : Creation of all the tables and Sequences

3. VIEWS : Creation of all the views. More views will be created in the next phase

4. SECONDARY_USERS : Creation of two more users and granting access to them.

5. DML_INSERTING_RECORDS : This will insert all the records of tables except ATTENDANCE and PAYROLL.

6. ATTENDANCE_MARKING_DML : This will insert all the records in ATTENDANCE Table

7. PAYROLL_DML : All the Payroll related records are inserted through this script

8. DELETION_IF_NEEDED : This can be ignored. It will be used only in case of any major errors. ( This is used to rollback if any error occurs and then follow the execution of scripts from the beginning).
