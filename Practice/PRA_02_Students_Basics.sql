-- ======================================================================
-- Practice 02 — Students Table Basics: SELECT, WHERE, IN, BETWEEN, ORDER BY, GROUP BY
-- Database 1 Course
-- ======================================================================


CREATE DATABASE DB_1;

USE DB_1;

CREATE TABLE Students(

	Student_ID		INT		PRIMARY KEY,
	First_Name	NVARCHAR(50)	NOT NULL,
	Last_Name	NVARCHAR(50)	NOT NULL,
	Department	NVARCHAR(50)	NOT NULL,
	City		NVARCHAR(50)	NULL,
	GPA			DECIMAL(3,2)	NULL

);

INSERT INTO Students (Student_ID, First_Name, Last_Name, Department, City, GPA) VALUES 

	(132300082, 'Eyad', 'Mohamed', 'ECE', 'Benha', 3.84), 
	(132300178, 'Riyad', 'Tayel', 'MEC', 'Ashmon', 2.89),
	(2026001, 'Mona',   'Ali',   'CS', 'Cairo',    3.55),
    (2026002, 'Omar',   'Nabil', 'IS', 'Giza',     2.95),
    (2026003, 'Sara',   'Hany',  'CS', 'Cairo',    3.80),
    (2026004, 'Yousef', 'Adel',  'AI', 'Alex',     3.25),
    (2026005, 'Nour',   'Samir', 'CS', 'Mansoura', 2.70);




SELECT * FROM Students;

SELECT Student_ID, First_Name, Last_Name, Department FROM Students WHERE Department = 'ECE';

SELECT Student_ID, First_Name, Last_Name, Department, GPA FROM Students WHERE GPA >= 3.00 ORDER BY GPA DESC;

SELECT * FROM Students WHERE Department = 'CS' AND City = 'Cairo' AND GPA >= 3.50;

INSERT INTO Students
VALUES (2026006, 'Laila', 'Mostafa', 'IS', 'Cairo', 3.10);

SELECT Student_ID, First_Name, Last_Name, Department, GPA FROM Students WHERE Department IN ('CS', 'IS', 'ECE') AND GPA >= 3.5 ORDER BY Department, GPA Desc;

SELECT * FROM Students WHERE City = 'Giza';

SELECT * FROM Students WHERE GPA >= 2.50 AND GPA <= 3.50;

SELECT * FROM Students WHERE GPA BETWEEN 2.50 AND 3.50;

SELECT * FROM Students ORDER BY Last_Name ASC;

SELECT Department, COUNT(*) AS StudentCount FROM Students GROUP BY Department;