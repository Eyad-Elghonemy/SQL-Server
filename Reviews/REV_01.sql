-- ======================================================================
-- Review 01 — Comprehensive Review: Constraints, ALTER TABLE, DDL/DML across multiple schemas (University, Hospital, Streaming Platform, Company)
-- Database 1 Course
-- ======================================================================


CREATE DATABASE REV_1Practical;
USE REV_1Practical;

CREATE TABLE Student(

	StudentID	INT PRIMARY KEY,
	SFname		NVARCHAR(100) NOT NULL,
	SLName		NVARCHAR(100) NOT NULL,
	Department	NVARCHAR(50)  NOT NULL,
	City		NVARCHAR(50)  NULL,
	GPA			DECIMAL(3,2)	CHECK(GPA>=0.00 AND GPA<=4.00)

);

INSERT INTO Student(StudentID,SFname,SLName,Department,City,GPA) VALUES
	(2026001, 'Mona',   'Ali',   'CS', 'Cairo',    3.55),
    (2026002, 'Omar',   'Nabil', 'IS', 'Giza',     2.95),
    (2026003, 'Sara',   'Hany',  'CS', 'Cairo',    3.80),
    (2026004, 'Yousef', 'Adel',  'AI', 'Alex',     3.25),
    (2026005, 'Nour',   'Samir', 'CS', 'Mansoura', 2.70);


-- Query 1:
SELECT S.SFname + ' ' + S.SLName AS StudentName, S.Department, S.City, S.GPA
FROM Student S
WHERE S.GPA BETWEEN 2.00 AND 3.00 AND S.Department IN ('CS', 'AI', 'IS')
ORDER BY S.GPA DESC;

-- Query 2: Count how many students are in each department.
SELECT COUNT(S.StudentID) AS TotalStudents, S.Department
FROM Student S
GROUP BY S.Department

----------------------------------------------------------------
CREATE TABLE Department(

	DeptID		INT	PRIMARY KEY	IDENTITY(1,1),
	DeptName	NVARCHAR(100) NOT NULL,
	Location    VARCHAR(100),
	HeadOfDept  NVARCHAR(100)

);

INSERT INTO Department(DeptName, Location, HeadOfDept)
VALUES
    ('Computer Science',          'Building C', 'Dr. Smith'),
    ('Information Systems',       'Building A', 'Dr. Jones'),
    ('Artificial Intelligence',   'Building B', 'Dr. Hassan');


-- Verify:
SELECT * FROM Department;



CREATE TABLE Students (
    StudentID       INT             PRIMARY KEY IDENTITY(1,1),
    FirstName       NVARCHAR(50)    NOT NULL,
    LastName        NVARCHAR(50)    NOT NULL,
    Email           VARCHAR(100)    UNIQUE NOT NULL,      -- must be unique
    Phone           VARCHAR(20),                          -- optional
    GPA             DECIMAL(3,2)    CHECK (GPA >= 0.0 AND GPA <= 4.0),
    EnrollmentDate  DATETIME        DEFAULT GETDATE(),    -- auto-fills today
    DeptID    INT,

    CONSTRAINT fk_dep  FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
    
);


INSERT INTO Students (FirstName, LastName, Email, Phone, GPA, DeptID)
VALUES
    ('Ahmed',  'Hassan',  'ahmed@uni.edu',  '01012345678', 3.75, 1),
    ('Sara',   'Ali',     'sara@uni.edu',   '01198765432', 3.50, 1),
    ('Omar',   'Khalil',  'omar@uni.edu',   '01234567890', 2.90, 2),
    ('Layla',  'Nour',    'layla@uni.edu',  NULL,          3.80, 3),
    ('Karim',  'Zaki',    'karim@uni.edu',  '01087654321', 3.10, 2);


SELECT * FROM Students;

CREATE TABLE Course(
    CourseID    INT PRIMARY KEY IDENTITY(1,1),
    CourseName  NVARCHAR(100)   NOT NULL,
    Credits     INT CHECK(Credits BETWEEN 1 AND 6),
    DeptID      INT
    CONSTRAINT  fk_dep2 FOREIGN KEY (DeptID) REFERENCES Department(DeptID)

);

-----------------------
DROP TABLE Course;
DROP TABLE Department;
DROP TABLE Student;
DROP TABLE Students;
-----------------------

CREATE TABLE Department(

	DeptID		INT	PRIMARY KEY	IDENTITY(1,1),
	DeptName	NVARCHAR(100) NOT NULL,
	Location    VARCHAR(100),
	HeadOfDept  NVARCHAR(100)

);

CREATE TABLE Student(

	StudentID	INT PRIMARY KEY,
	SFname		NVARCHAR(100) NOT NULL,
	SLName		NVARCHAR(100) NOT NULL,
	Email		VARCHAR(50)  UNIQUE,
	GPA			DECIMAL(3,2)	CHECK(GPA>=0.00 AND GPA<=4.00),
    Phone       INT,
    DeptID      INT     REFERENCES  Department(DeptID)

);

CREATE TABLE Courses(
    
    CCode   INT     PRIMARY KEY,
    CName   VARCHAR(100)    NOT NULL,
    CCredits    INT,
    DeptID      INT     REFERENCES  Department(DeptID)
);

CREATE TABLE Registeration(

    StudentID   INT     REFERENCES Student(StudentID),
    CCode       INT     REFERENCES Courses(CCode),
    Semester    VARCHAR(20),
    Grade       VARCHAR(5),
    PRIMARY KEY(StudentID, CCode)
);


----------------------------------
DROP TABLE Courses;
DROP TABLE Department;
DROP TABLE Student;
DROP TABLE Registeration;
----------------------------------

CREATE TABLE Department(

	DeptID		INT	PRIMARY KEY	IDENTITY(1,1),
	DeptName	NVARCHAR(100) NOT NULL,
	Floor       VARCHAR(100),
	Phone       INT

);

CREATE TABLE Doctor(

	DoctorID	INT PRIMARY KEY,
	DFname		NVARCHAR(100) NOT NULL,
	DLName		NVARCHAR(100) NOT NULL,
	Specialization		VARCHAR(50)  UNIQUE,
    Phone       INT,
    DeptID      INT     REFERENCES  Department(DeptID)

);

CREATE TABLE Patients (
    PatientID   INT          PRIMARY KEY,
    PatientName VARCHAR(100) NOT NULL,
    DateOfBirth DATE,
    Phone       VARCHAR(20)
);

CREATE TABLE Appointments (
    DoctorID  INT FOREIGN KEY REFERENCES Doctor(DoctorID),
    PatientID INT FOREIGN KEY REFERENCES Patients(PatientID),
    AppDate   DATE,
    AppTime   TIME,
    Diagnosis VARCHAR(500),
    PRIMARY KEY (DoctorID, PatientID, AppDate)
);

----------------------------------
DROP TABLE Department;
DROP TABLE Patients;
DROP TABLE Appointments;
DROP TABLE Doctor;
----------------------------------

CREATE TABLE Department (
    DeptID    INT           PRIMARY KEY,   -- Key attribute (underlined oval)
    DeptName  VARCHAR(100)  NOT NULL,
    Location  VARCHAR(100)
);

CREATE TABLE Student (
    StudentID    INT           PRIMARY KEY,
    FirstName    VARCHAR(50)   NOT NULL,
    LastName     VARCHAR(50)   NOT NULL,
    DateOfBirth  DATE,                      -- Age is DERIVED → not stored
    Email        VARCHAR(100)  UNIQUE,
    DeptID       INT           REFERENCES Department(DeptID)
                                               -- FK to Dept (many students → one dept)
);

CREATE TABLE Course (
    CourseID    INT           PRIMARY KEY,
    CourseName  VARCHAR(100)  NOT NULL,
    Credits     INT           DEFAULT 3,
    DeptID      INT           REFERENCES Department(DeptID)
                                              -- Course offered by one department
);

CREATE TABLE Enrollment (
    StudentID    INT   REFERENCES Student(StudentID),
    CourseID     INT   REFERENCES Course(CourseID),
    EnrollDate   DATE  DEFAULT GETDATE(),  -- attribute ON the relationship
    Grade        CHAR(2),
    PRIMARY KEY (StudentID, CourseID)         -- composite PK from both FKs
);

CREATE TABLE StudentPhone (
    StudentID  INT         REFERENCES Student(StudentID),
    Phone      VARCHAR(20) NOT NULL,
    PRIMARY KEY (StudentID, Phone)   -- one student can have many phones
);

INSERT INTO Department (DeptID, DeptName, Location) VALUES
    (1, 'Computer Science',  'Building A, Floor 3'),
    (2, 'Mathematics',        'Building B, Floor 1'),
    (3, 'Electrical Eng.',    'Engineering Block'),
    (4, 'Business',           'Management Tower');

    INSERT INTO Student (StudentID, FirstName, LastName, DateOfBirth, Email, DeptID) VALUES
    (101, 'Sara',   'Ahmed',  '2002-03-14', 'sara@uni.edu',   1),
    (102, 'Omar',   'Hassan', '2001-07-22', 'omar@uni.edu',   1),
    (103, 'Layla',  'Nour',   '2003-01-05', 'layla@uni.edu',  2),
    (104, 'Karim',  'Saad',   '2000-11-30', 'karim@uni.edu',  3),
    (105, 'Nada',   'Fathy',  '2002-06-18', 'nada@uni.edu',   2),
    (106, 'Youssef','Ali',    '2001-09-09', 'youssef@uni.edu',4);

    INSERT INTO Course (CourseID, CourseName, Credits, DeptID) VALUES
    (10, 'Database Systems',     3, 1),
    (20, 'Algorithms',            3, 1),
    (30, 'Calculus I',            4, 2),
    (40, 'Digital Circuits',      3, 3),
    (50, 'Intro to Business',    2, 4);

    INSERT INTO Enrollment (StudentID, CourseID, EnrollDate, Grade) VALUES
    (101, 10, '2025-09-01', 'A'),   -- Sara  → Database Systems
    (101, 20, '2025-09-01', 'B+'),  -- Sara  → Algorithms
    (102, 10, '2025-09-01', 'B'),   -- Omar  → Database Systems
    (102, 20, '2025-09-01', 'A-'),  -- Omar  → Algorithms
    (103, 30, '2025-09-02', 'A+'),  -- Layla → Calculus I
    (104, 40, '2025-09-01', 'C+'),  -- Karim → Digital Circuits
    (105, 30, '2025-09-02', 'B'),   -- Nada  → Calculus I
    (105, 10, '2025-09-02', NULL),  -- Nada  → Database Systems (no grade yet)
    (106, 50, '2025-09-03', 'A');  -- Youssef → Intro to Business

    INSERT INTO StudentPhone (StudentID, Phone) VALUES
    (101, '010-1234-5678'),   -- Sara has 2 phone numbers
    (101, '011-9876-5432'),
    (102, '012-5555-0001'),
    (103, '010-7777-3333'),   -- Layla has 2 phone numbers
    (103, '015-4444-2222'),
    (104, '011-1111-8888');   -- Karim has 1


    -- Queries
    SELECT * FROM Student

    SELECT FirstName + ' ' + LastName AS StudentName,
    DateOfBirth,
    DATEDIFF(YEAR, DateOfBirth, GETDATE()) AS Age
    FROM Student
    ORDER BY Age DESC;

    SELECT FirstName + ' ' + LastName AS StudentName,
    D.DeptName
    FROM Student S JOIN Department D
    ON S.DeptID = D.DeptID
    WHERE D.DeptName = 'Computer Science'

    SELECT FirstName + ' ' + LastName AS StudentName,
    D.DeptName, E.Grade
    FROM Student S JOIN Enrollment E
    ON S.StudentID = E.StudentID
    JOIN Department D
    ON S.DeptID = D.DeptID
    WHERE E.Grade IN ('A+', 'A-', 'A');


    SELECT COUNT(S.StudentID) AS TotalStudents, D.DeptName 
    FROM Student S JOIN Department D
    ON S.DeptID = D.DeptID
    GROUP BY D.DeptName, D.DeptID
    ORDER BY D.DeptID;

    SELECT S.FirstName + ' ' + S.LastName AS Student,
    C.CourseName
    FROM Student S JOIN Enrollment E
    ON S.StudentID = E.StudentID
    JOIN Course C 
    ON C.CourseID = E.CourseID

    SELECT COUNT(DISTINCT S.StudentID) AS TotalStudents,
    COUNT(DISTINCT C.CourseID) AS TotalCourses,
    D.DeptName
    FROM Enrollment E JOIN Course C
    ON E.CourseID = C.CourseID
    JOIN Student S
    ON E.StudentID = S.StudentID
    JOIN Department D
    ON S.DeptID = D.DeptID
    GROUP BY D.DeptName

DROP TABLE IF EXISTS StudentPhone;
DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Department;

-----------------------------------------------

CREATE TABLE Department(
    DeptID  INT     PRIMARY KEY,
    DeptName    VARCHAR(100) NOT NULL,
    Location    VARCHAR(100)
);

CREATE TABLE Employee (

    EmpID       INT     PRIMARY KEY,
    EmpName     VARCHAR(100) NOT NULL,
    Salary      DECIMAL(10, 2),
    HireDate    DATE,
    DeptID      INT     REFERENCES  Department(DeptID)
);

CREATE TABLE Project(
    ProID   INT     PRIMARY KEY,
    ProName     VARCHAR(100) NOT NULL,
    Budget      DECIMAL(12, 2)
);

CREATE TABLE Works_On(
    EmpID       INT     REFERENCES Employee(EmpID),
    ProID       INT     REFERENCES Project(ProID),
    Hours       DECIMAL(5,1),
    PRIMARY KEY (EmpID, ProID)
);

--- DDL
-- Add Column
ALTER TABLE Employee 
ADD Email VARCHAR(100);

-- Drop Column
ALTER TABLE Department
DROP COLUMN Location;

-- 3 Modify Column (Change Data Type)
ALTER TABLE Department
ALTER COLUMN DeptName  VARCHAR(200) NOT NULL;

-- 4 Add Constraint
ALTER TABLE Employee 
ADD CONSTRAINT chk_salary CHECK(Salary>0);

-- 5 Drop Constraint
ALTER TABLE Employee
DROP CONSTRAINT chk_salary;

-- 6 Rename Table
EXEC sp_rename 'Works_On', 'Assignment';

ALTER TABLE Department
ADD Location VARCHAR(200);

-- DML 
-- 1 Insert
INSERT INTO Department (DeptID, DeptName, Location)
VALUES (10, 'Engineering', 'Building A');

INSERT INTO Department (DeptID, DeptName, Location)
VALUES (20, 'Marketing', 'Building B');

INSERT INTO Department (DeptID, DeptName, Location)
VALUES (30, 'Finance', 'Building C');

---------------------------------------

INSERT INTO Employee (EmpID, EmpName, Salary, HireDate, DeptID)
VALUES (1, 'Ahmed', 5000, '2023-01-15', 10);

INSERT INTO Employee (EmpID, EmpName, Salary, HireDate, DeptID)
VALUES (2, 'Sara', 6000, '2022-06-01', 10);

INSERT INTO Employee (EmpID, EmpName, Salary, HireDate, DeptID)
VALUES (3, 'Omar', 4500, '2024-03-10', 20);

INSERT INTO Employee (EmpID, EmpName, Salary, HireDate, DeptID)
VALUES (4, 'Mona', 7000, '2021-09-20', 30);

--------------------------------------------

INSERT INTO Project (ProID, ProName, Budget)
VALUES (100, 'Website Redesign', 50000);

INSERT INTO Project (ProID, ProName, Budget)
VALUES (200, 'Mobile App', 120000);

INSERT INTO Project (ProID, ProName, Budget)
VALUES (300, 'Data Pipeline', 80000);

----------------------------------------------

INSERT INTO Assignment (EmpID, ProID, Hours)
VALUES (1, 100, 20);  -- Ahmed → Website Redesign

INSERT INTO Assignment (EmpID, ProID, Hours)
VALUES (1, 200, 15);  -- Ahmed → Mobile App

INSERT INTO Assignment (EmpID, ProID, Hours)
VALUES (2, 100, 30);  -- Sara → Website Redesign

INSERT INTO Assignment (EmpID, ProID, Hours)
VALUES (3, 200, 25);  -- Omar → Mobile App

INSERT INTO Assignment (EmpID, ProID, Hours)
VALUES (4, 300, 40);  -- Mona → Data Pipeline

---------------------------------------------------

-- 2 Update

UPDATE Employee
SET Salary = 5500
WHERE EmpID = 1;

UPDATE Employee
SET DeptID = 10
WHERE EmpID = 3;


-- 3 Delete
DELETE FROM Employee
WHERE EmpID = 4;


CREATE TABLE Employe (
    
    EmpID   INT PRIMARY KEY,
    EmpName VARCHAR(100) NOT NULL,
    Salary  DECIMAL(10,2),
    HireDate    DATE,
    DeptID      INT     REFERENCES  Department(DeptID)
        ON DELETE SET NULL
        ON UPDATE CASCADE

);

-----------------------------------------------
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Assignment;
DROP TABLE IF EXISTS Employe;
-----------------------------------------------

CREATE TABLE SubscriptionPlan(

    PlanID  INT PRIMARY KEY,
    PlanName    VARCHAR(50)    NOT NULL,
    Quality     VARCHAR(10),    
    Price       DECIMAL(8,2)   NOT NULL
);

CREATE TABLE Creator(

    CreatorID  INT PRIMARY KEY,
    CreatorName    VARCHAR(100)    NOT NULL,
    Country        VARCHAR(100),
    JoinDate       DATE
);

CREATE TABLE [User](

    UserID  INT PRIMARY KEY,
    FullName    VARCHAR(100)    NOT NULL,
    Email       VARCHAR(100)    UNIQUE,
    JoinDate DATE,
    PlanID      INT     REFERENCES  SubscriptionPlan(PlanID)
);


CREATE TABLE Video(

    VideoID      INT PRIMARY KEY,
    VideoTitle   VARCHAR(100)    NOT NULL,
    Duration     INT,
    Genere       VARCHAR(100)    NOT NULL,
    ReleaseYear  INT,
    CreatorID    INT    REFERENCES  Creator(CreatorID)
);


CREATE TABLE Wathed(

    UserID      INT REFERENCES [User](UserID),
    VideoID     INT REFERENCES  Video(VideoID),
    Progress    INT,
    WatchedAt       DATETIME,
    PRIMARY KEY(UserID, VideoID)
);


--- ALTER
ALTER TABLE SubscriptionPlan ADD MaxDevices INT;

ALTER TABLE SubscriptionPlan ALTER COLUMN MaxDevices INT NOT NULL;


ALTER TABLE [User] ADD Phone NVARCHAR(100);

-- INSER
INSERT INTO SubscriptionPlan (PlanID, PlanName, Price, Quality, MaxDevices)
VALUES
  (1, 'Basic', 4.99, 'SD', 1),
  (2, 'Standard', 8.99, 'HD', 2),
  (3, 'Premium', 14.99, '4K', 4);

  ---------------------

INSERT INTO Creator (CreatorID, CreatorName, Country, JoinDate)
VALUES
  (1, 'TechReview', 'EG', '2022-03-15'),
  (2, 'CinemaScope', 'US', '2021-08-01');

  ----------------------

INSERT INTO Video (VideoID, VideoTitle, Duration, Genere, ReleaseYear, CreatorID)
VALUES
  (1, 'Intro to SQL', 45, 'Education', 2023, 1),
  (2, 'Database Design 101', 60, 'Education', 2023, 1),
  (3, 'Cairo After Dark', 110, 'Drama', 2022, 2),
  (4, 'The Desert Code', 95, 'Thriller', 2024, 2);

  ---------------------------------------

INSERT INTO [User] (UserID, FullName, Email, Phone, JoinDate, PlanID)
VALUES
  (1, 'Ahmed Hassan', 'ahmed@watchit.io', '01012345678', '2024-01-10', 2),
  (2, 'Sara Mohamed', 'sara@watchit.io', '01098765432', '2024-02-20', 3),
  (3, 'Omar Khaled', 'omar@watchit.io', NULL, '2024-03-05', 1);

  ----------------------------------------

INSERT INTO Wathed(UserID, VideoID, WatchedAt, Progress)
VALUES
  (1, 1, '2024-04-01 20:00:00', 300),
  (1, 3, '2024-04-02 21:30:00', 620),
  (2, 2, '2024-04-03 19:00:00', 3200),
  (2, 4, '2024-04-04 22:00:00', 145),
  (3, 1, '2024-04-05 18:00:00', 1200);

  -----------------------------------------

  -- DML 
  UPDATE [User] SET PlanID = 2 WHERE UserID = 3;

  DELETE FROM Wathed WHERE UserID = 1 AND VideoID = 3;

------------------------------------------------

DROP TABLE IF EXISTS SubscriptionPlan;
DROP TABLE IF EXISTS Creator;
DROP TABLE IF EXISTS Video;
DROP TABLE IF EXISTS [User];
DROP TABLE IF EXISTS Wathed;

---------------------------------------------------

CREATE TABLE Department(

    DeptCode    INT     PRIMARY KEY,
    DeptName    VARCHAR(100)    NOT NULL,
    Address     VARCHAR(100),
    ManagerStartDate    DATE
);

-- ALTER

CREATE TABLE Employee(

    EmpID       INT     PRIMARY KEY,
    EmpFName    VARCHAR(100)    NOT NULL,
    EmpLName    VARCHAR(100)    NOT NULL,
    Salary      DECIMAL(10,2),
    ManagerID   INT     REFERENCES  Employee(EmpID),
    DeptCode    INT     REFERENCES  Department(DeptCode)
);


CREATE TABLE Project(

    ProID       INT     PRIMARY KEY,
    ProName     VARCHAR(100)    NOT NULL,
    Location    VARCHAR(100)    NOT NULL,
    DeptCode    INT     REFERENCES  Department(DeptCode)
);


CREATE TABLE FamilyMember(

    EmpID   INT REFERENCES Employee(EmpID),
    FMName  VARCHAR(100)    NOT NULL,
    Gender  VARCHAR(100)    NOT NULL,
    Relationdhip    VARCHAR(100)    NOT NULL,

    PRIMARY KEY(EmpID, FMName)
);

CREATE TABLE WorkedHours(
    
    EmpID   INT REFERENCES Employee(EmpID),
    ProID   INT REFERENCES Project(ProID),
    WorkedHours INT,
    PRIMARY KEY(EmpID, ProID)
    
);

CREATE TABLE EmpPhone(
    EmpID   INT REFERENCES Employee(EmpID),
    EmpPhone    INT,
    PRIMARY KEY(EmpID,EmpPhone)
);

ALTER TABLE Department ADD EmpID INT;
ALTER TABLE Department ADD CONSTRAINT fk_Emp FOREIGN KEY (EmpID) REFERENCES Employee(EmpID);

