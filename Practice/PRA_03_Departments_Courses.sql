-- ======================================================================
-- Practice 03 — Departments & Students with FK Constraints; UniversityDB with CHECK/DEFAULT/IDENTITY, Courses
-- Database 1 Course
-- Note: the last two INSERTs intentionally violate CHECK/FK constraints as a test case - that's expected to fail.
-- ======================================================================


CREATE DATABASE DB_2;
USE DB_2;

CREATE TABLE Departments (
	
	DeptID		INT		PRIMARY KEY,
	DeptName	NVARCHAR(50)	NOT NULL,
	Location	VARCHAR(100)	NULL,
	HeadOfDep	NVARCHAR(50)	NOT NULL	
);

CREATE TABLE Students (

	StudentID	INT		PRIMARY KEY,
	FirstName	NVARCHAR(50)	NOT NULL,
	LastName	NVARCHAR(50)	NOT NULL,
	Email		VARCHAR(100)	NULL,
	Phone		VARCHAR(50)		NULL,
	GPA			DECIMAL(3, 2)	NOT NULL,
	EnrolmentDate	DATETIME	NOT NULL,
	DeptID		INT	NOT NULL,
	CONSTRAINT  FK_Student_Department	FOREIGN KEY(DeptID) REFERENCES Departments(DeptID)

);

----------------------------------------------------------------------------------------------------

CREATE DATABASE UniversityDB;
USE UniversityDB;

CREATE TABLE Departments(
    DeptID      INT PRIMARY KEY IDENTITY(1,1),
    DeptName    NVARCHAR(50) NOT NULL,
    Locations   VARCHAR(100) NOT NULL,
    HeadOfDept  NVARCHAR(100) NOT NULL
);

INSERT INTO Departments (DeptName, Locations, HeadOfDept)
VALUES
    ('CS', 'BUILDING C', 'DR. Smith'),
    ('IS', 'BUILDING A', 'DR. Jones'),
    ('AI', 'BUILDING B', 'DR. Osama');


SELECT * FROM Departments;


CREATE TABLE STUDENTS(

	StudentID	INT		PRIMARY KEY	IDENTITY(1,1),
	FirstName	NVARCHAR(50)	NOT	NULL,
	LastName	NVARCHAR(50)	NOT	NULL,
	Email		VARCHAR(100)	UNIQUE	NOT NULL,
	Phone		VARCHAR(20),
	GPA			DECIMAL(3,2)	CHECK(GPA >= 0.00 AND GPA <= 4.00),
	EnrollmentDate	DATETIME	DEFAULT	GETDATE(),
	DeptID		INT,
	
	CONSTRAINT FK_Students_Departments FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)

);

SELECT * FROM STUDENTS;

INSERT INTO STUDENTS (FirstName, LastName, Email, Phone, GPA, DeptID)
VALUES
    ('Ahmed',  'Hassan',  'ahmed@uni.edu',  '01012345678', 3.75, 1),
    ('Sara',   'Ali',     'sara@uni.edu',   '01198765432', 3.50, 1),
    ('Omar',   'Khalil',  'omar@uni.edu',   '01234567890', 2.90, 2),
    ('Layla',  'Nour',    'layla@uni.edu',  NULL,          3.80, 3),
    ('Karim',  'Zaki',    'karim@uni.edu',  '01087654321', 3.10, 2);


INSERT INTO STUDENTS (FirstName, LastName, Email, Phone, GPA, DeptID)
VALUES

('Eyad', 'Mohamed', 'eyad0758@gmail.com', '01016432120', 3.84, 2);

SELECT * FROM Students;


-- INSERT INTO Students (FirstName, LastName, Email, DepartmentID)
-- VALUES ('Ghost', 'Student', 'ghost@test.com', 99);

-- INSERT INTO Students
-- (FirstName, LastName, Email, GPA, DepartmentID)
-- VALUES ('Bad', 'Grade', 'b@t.com', 5.5, 1);


INSERT INTO Students (FirstName, LastName, Email, GPA, DeptID)
VALUES ('New', 'Student', 'new@test.com', 3.20, 3);

SELECT StudentID, FirstName, EnrollmentDate
FROM Students
WHERE Email = 'new@test.com';

---- ExerCise 1 ----

CREATE TABLE Courses (
	
	CourseId	INT		PRIMARY KEY IDENTITY(1,1),
	CourseName	NVARCHAR(50)	NOT NULL,
	Credits		TINYINT			CHECK(Credits >=1 AND Credits <= 6),
	DepartmentID	INT,

	CONSTRAINT	FK_Course_Department	FOREIGN KEY (DepartmentID) REFERENCES Departments(DeptID)
	
);

---- ExerCise 2 ----

INSERT INTO Courses(CourseName,Credits,DepartmentID)
VALUES 
('DataBase 1', 3, 1),
('Electrical Drawing', 2, 1),
('Socital Issues', 1, 3);

INSERT INTO Courses(CourseName,Credits,DepartmentID)
VALUES

('Neural Network', 8, 3),
('Health & Saftey', 8, 50);

