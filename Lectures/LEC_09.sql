-- ======================================================================
-- Lecture 09 — Joins (INNER / LEFT / RIGHT / FULL) & Multi-Table Joins
-- Database 1 Course
-- ======================================================================


CREATE DATABASE DB9;

USE DB9;

CREATE TABLE Department(

	DepartNo	INT		PRIMARY KEY,
	DepartName	NVARCHAR(50)

);

CREATE TABLE Student(

	SCode	INT		PRIMARY KEY,
	SFName	NVARCHAR(100),
	SLName	NVARCHAR(100),
	SGender	VARCHAR(50),
	SPhone	INT,
	DepartNo INT REFERENCES	Department(DepartNo)

);

CREATE TABLE Course(

	CCode	INT		PRIMARY KEY,
	CTitle	NVARCHAR(100),
	CPrerequisite	NVARCHAR(200),
	CLec	VARCHAR(100),
	CTutorial	VARCHAR(100),
	CLab	VARCHAR(100)
);

CREATE TABLE Regestration(

	SCode	INT		REFERENCES	Student(SCode),
	CCode	INT		REFERENCES	Course(CCode),
	Semester	NVARCHAR(100),
	Grade		DECIMAL(3,2),
	PRIMARY KEY(SCode, CCode)

);


INSERT INTO Department (DepartNo, DepartName) VALUES 
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'Biology'),
(5, 'English'),
(6, 'Mechanical Engineering'),
(7, 'Electrical Engineering'),
(8, 'Economics');


INSERT INTO Student (SCode, SFName, SLName, SGender, SPhone, DepartNo) VALUES 
(1, 'Alice', 'Smith', 'Female', 111, 1),
(2, 'Bob', 'Johnson', 'Male', 222, 2),
(3, 'Carol', 'Lee', 'Female', 333, 1),
(4, 'David', 'Kim', 'Male', 444, 3),
(5, 'Eve', 'Martinez', 'Female', 555, 4),
(6, 'Frank', 'Brown', 'Male', 666, 5),
(7, 'Grace', 'Davis', 'Female', 777, 6),
(8, 'Henry', 'Wilson', 'Male', 888, 7),
(9, 'ALI', 'AHMED', 'Male', 999, NULL),
(10, 'OMAR', 'ALI', 'Male', 000, NULL);


INSERT INTO Course (CCode, CTitle, CPrerequisite, CLec, CTutorial, CLab) VALUES 
(201, 'Data Structures', 'Programming 101', '3 hours', '1 hour', '2 hours'),
(202, 'Microprocessors', 'Digital Logic', '3 hours', '1 hour', '1 hour'),
(203, 'Machine Learning', 'Linear Algebra', '3 hours', 'None', '2 hours'),
(204, 'Control Systems', 'Calculus', '2 hours', '2 hours', '1 hour'),
(205, 'Database Systems', 'None', '3 hours', '1 hour', '2 hours'),
(206, 'Operating Systems', 'Computer Architecture', '3 hours', '1 hour', 'None'),
(207, 'Economics', NULL, '2 hours', 'None', 'None'),
(208, 'Artificial Intelligence', 'Data Structures', '3 hours', '1 hour', '2 hours');



INSERT INTO Regestration (SCode, CCode, Semester, Grade) VALUES 
-- طالب 1 (Alice) مسجلة في مادتين
(1, 201, 'Fall 2025', 3.90),
(1, 205, 'Fall 2025', 4.00),

-- طالب 2 (Bob) مسجل في مادة
(2, 202, 'Fall 2025', 3.50),

-- طالب 3 (Carol) مسجلة في مادة
(3, 201, 'Fall 2025', 3.20),

-- طالب 4 (David) مسجل في مادتين
(4, 203, 'Spring 2026', 3.80),
(4, 208, 'Spring 2026', 3.60),

-- طالب 5 (Eve) مسجلة في مادة
(5, 204, 'Fall 2025', 2.80),

-- طالب 9 (ALI AHMED) رغم إنه ملوش قسم بس مسجل في مادة
(9, 205, 'Spring 2026', 3.00),

-- طالب 10 (OMAR ALI) ملوش قسم ومسجل في مادة
(10, 207, 'Spring 2026', 3.40);


-- Queries


-- 1
SELECT SFName + ' ' + SLName AS StudentFullName, DepartName
FROM Student, Department
WHERE   Student.DepartNo=Department.DepartNo AND SGender Like 'F%';


SELECT SFName + ' ' + SLName AS StudentFullName, DepartName
FROM Student INNER JOIN Department
ON Student.DepartNo=Department.DepartNo 
WHERE SGender Like 'F%';

-- Left Join
SELECT SFName + ' ' + SLName AS StudentFullName, DepartName
FROM Student S LEFT JOIN Department D
ON S.DepartNo=D.DepartNo 

-- Right Join
SELECT SFName + ' ' + SLName AS StudentFullName , DepartName
FROM Student S RIGHT JOIN Department D
ON S.departNo = D.departNo

-- FULL Join
SELECT SFName + ' ' + SLName AS StudentFullName , DepartName
FROM Student S FULL JOIN Department D
ON S.departNo = D.departNo


-- join more than two table
SELECT SFName + ' ' + SLName AS StudentFullName, CTitle, DepartName, Grade
FROM Student S JOIN Department D ON S.DepartNo = D.DepartNo
JOIN Regestration R ON S.SCode = R.SCode
JOIN Course C ON R.CCode = C.CCode
WHERE Grade >= 3.00;

