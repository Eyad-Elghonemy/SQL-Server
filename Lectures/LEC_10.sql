-- ======================================================================
-- Lecture 10 — Joins Practice (Car Rental) + Aggregate Functions (SUM, COUNT, MIN, MAX, AVG, GROUP BY, HAVING)
-- Database 1 Course
-- ======================================================================


CREATE DATABASE LEC_10;
USE LEC_10

CREATE TABLE Department(

	BranchID	INT		PRIMARY KEY,
	BranchName	VARCHAR(100)	NOT NULL,
	Locaation	VARCHAR(150)
);

CREATE TABLE Vehicle(

	VehicleID	INT		PRIMARY KEY,
	Modeel		VARCHAR(100)	NOT NULL,
	Make		VARCHAR(100)	NOT NULL,
	year		DATE,
	Status		VARCHAR(50)	NOT NULL,
	BranchID	INT		REFERENCES Department(BranchID)
);

CREATE TABLE Client(

	ClientID	INT		PRIMARY KEY,
	FullName	VARCHAR(200)	NOT NULL,
	NationalID	VARCHAR(200)    NOT NULL,
	Phone		INT,
	Email		VARCHAR(150)	UNIQUE,
	Address     VARCHAR(255),
	LicenseNo	VARCHAR(150)	UNIQUE	
);

CREATE TABLE Rental(

	Rental_No	INT		PRIMARY KEY,
	ClientID	INT	REFERENCES Client(ClientID),
	VehicleID	INT	REFERENCES Vehicle(VehicleID),
	Start_Date	DATE	NOT NULL,
	End_Date	DATE	NOT NULL,
	Insurance_No	VARCHAR(150)	UNIQUE,
	Total_Amount	DECIMAL(8,2)
);

INSERT INTO Department (BranchID, BranchName, Locaation) VALUES 
(1, 'Main Branch', 'Cairo'),
(2, 'Airport Branch', 'Alexandria'),
(4, 'Downtown', NULL); 

INSERT INTO Vehicle (VehicleID, Modeel, Make, Year, Status, BranchID) VALUES 
(101, 'Camry', 'Toyota', '1-1-2023', 'Available', 1),
(102, 'Sunny', 'Nissan', '1-1-2022', 'Rented', 1),
(103, 'Elantra', 'Hyundai', '1-1-2024', 'Maintenance', 2),
(104, 'Tucson', 'Hyundai', '1-1-2023', 'Available', NULL); 

INSERT INTO Client (ClientID, FullName, NationalID, Phone, Email, Address, LicenseNo) VALUES 
(501, 'Ahmed Mohamed', '2900101', 010111, 'ahmed@mail.com', 'Cairo, Egypt', 'L-123'),
(502, 'Sara Hassan', '2950202', 011222, 'sara@mail.com', 'Alex, Egypt', 'L-456'),
(504, 'Khaled Zeyad', '2920404', 015444, NULL, NULL, 'L-000'); 

INSERT INTO Rental (Rental_No, ClientID, VehicleID, Start_Date, End_Date, Insurance_No, Total_Amount) VALUES 
(1001, 501, 102, '2026-05-01', '2026-05-05', 'INS-99', 500.00),
(1002, 502, 101, '2026-05-02', '2026-05-04', 'INS-88', 300.00);


-- Queries
-- 1- Display the rentals accompanied by the customer's name and the car model
SELECT R.Rental_No, C.FullName, V.Modeel
FROM Rental R join Client C ON R.ClientID = C.ClientID
JOIN Vehicle V ON R.VehicleID = V.VehicleID;

-- 2- Display the customers who rented cars from the Cairo branch
SELECT C.FullName, D.BranchName
FROM Rental R
JOIN Client C ON R.ClientID = C.ClientID
JOIN Vehicle V ON V.VehicleID = R.VehicleID
JOIN Department D ON V.BranchID = D.BranchID
WHERE D.BranchName = 'Main Branch';

-- 3 Display the cars located in the Cairo branch
SELECT V.*
FROM Vehicle V JOIN Department D
ON V.BranchID = D.BranchID
WHERE D.BranchName = 'Main Branch';





---- LEC 10 

CREATE DATABASE LEC_10_2;
USE LEC_10_2;

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
-- 1 Write an SQL query using to list pairs of students who live at the same address
SELECT S1.SFName + ' ' + s1.SLName AS Student1,
S2.SFName + ' ' + s2.SLName AS Student2,
S1.DepartNo
FROM Student S1 JOIN Student S2 
ON S1.DepartNo = S2.DepartNo
AND S1.SCode < S2.SCode;

-- 2 Write an SQL query using SELF JOIN to display each course along with its prerequisite course title.
SELECT C1.CTitle As Course, C2.CTitle AS Prerequisite
FROM Course C1 LEFT JOIN Course C2
ON C1.CPrerequisite = C2.CTitle;

-- Aggregate Functions

-- SUM, AVG (Numerical)
-- COUNT, MIN, MAX (Numerical, Categorical)

-- SUM, COUNT

SELECT COUNT(S.SCode) AS TotalStudent, SUM(S.SCode) AS TotalCodes
FROM Student S
WHERE S.SGender = 'Male';


-- MIN, MAX, COUNT  
SELECT MIN(S.DepartNo) AS MinDepartment, 
MAX(S.DepartNo) AS MaxDepartment,
AVG(S.DepartNo) AS AvgDepartment
FROM Student S

------------------------------ UPPER DB
SELECT R.Rental_No, COUNT(R.ClientID) AS TotalClients, SUM(Total_Amount) AS TotalRentAmount, C.FullName
FROM Rental R JOIN Client C
ON R.ClientID = C.ClientID
GROUP BY R.Rental_No, C.FullName
HAVING COUNT(R.Rental_No) >= 1
ORDER BY R.Rental_No;

-- Write an SQL query to display the number of students in each department

SELECT D.DepartName, COUNT(S.SCode) AS TotalStudents
FROM Department D JOIN Student S
ON D.DepartNo = S.DepartNo
GROUP BY D.DepartName;

-- Write an SQL query to display the number of courses registered by each student
SELECT S.SFName + ' ' + S.SLName, COUNT(R.CCode) AS TotalCourses
FROM Regestration R JOIN Student S
ON R.SCode = S.SCode
GROUP BY S.SFName, S.SLName;

-- Write an SQL query to display each student’s full name, department name, and the number of courses ,they have registered
SELECT S.SFName + ' ' + S.SLName, D.DepartName,COUNT(R.CCode) AS TotalCourses
FROM Regestration R JOIN Student S 
ON R.SCode = S.SCode
JOIN Department D
ON S.DepartNo = D.DepartNo
GROUP BY S.SFName, S.SLName, D.DepartName;

-- Regist > 1
SELECT S.SFName + ' ' + S.SLName, D.DepartName,COUNT(R.CCode) AS TotalCourses
FROM Regestration R JOIN Student S 
ON R.SCode = S.SCode
JOIN Department D
ON S.DepartNo = D.DepartNo
GROUP BY S.SFName, S.SLName, D.DepartName
HAVING COUNT(R.CCode) > 1 AND D.DepartName = 'Computer Science';