-- ======================================================================
-- Section 08 — Subqueries (Scalar, IN, ANY/ALL, Correlated, EXISTS) & Derived Tables
-- Database 1 Course
-- ======================================================================


CREATE DATABASE LEC_12;

USE LEC_12;


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
    (104, '011-1111-8888');   -- Karim has 


    ALTER TABLE Student ADD GPA DECIMAL(3,2);
    
UPDATE Student SET GPA = 3.85 WHERE StudentID = 101; -- Sara
UPDATE Student SET GPA = 3.40 WHERE StudentID = 102; -- Omar
UPDATE Student SET GPA = 3.95 WHERE StudentID = 103; -- Layla
UPDATE Student SET GPA = 2.75 WHERE StudentID = 104; -- Karim
UPDATE Student SET GPA = 3.10 WHERE StudentID = 105; -- Nada
UPDATE Student SET GPA = 3.65 WHERE StudentID = 106; -- Youssef


    -- SUBQueries 
    select FirstName + LastName As StudentName From Student 
    WHERE Student.GPA < (SELECT AVG(Student.GPA) FROM Student);

    -- 2
    SELECT  FirstName + LastName As StudentName FROM Student 
    WHERE GPA = (SELECT MAX(GPA) FROM Student);

    -- 3
    SELECT  FirstName + LastName As StudentName,
    (SELECT AVG(GPA) FROM Student) AS ClassAvg,
    GPA - (SELECT AVG(GPA) FROM Student) AS Diff 
    FROM Student;


    -- 4
    SELECT DISTINCT FirstName + LastName As StudentName 
    FROM Student S JOIN Enrollment E 
    ON S.StudentID = E.StudentID 
    WHERE E.CourseID IN (SELECT CourseID From Course WHERE DeptID = 1);

    -- 5 
    SELECT  FirstName + LastName As StudentName FROM 
    Student WHERE StudentID NOT IN (SELECT StudentID FROM Enrollment);
 
    -- 6 
    SELECT FirstName + LastName As StudentName FROM Student
    WHERE GPA > ANY (SELECT GPA FROM Student WHERE DeptID = 2);

    -- 7 
    SELECT FirstName + LastName As StudentName FROM Student
    WHERE GPA > ALL (SELECT GPA FROM Student WHERE DeptID = 2);

    -- 8 (Correlated SubQueries)
    SELECT S1.FirstName, S1.GPA FROM Student S1 WHERE
    S1.GPA > (SELECT AVG(S2.GPA) FROM Student S2 WHERE S1.DeptID = S2.DeptID);

    SELECT S.FirstName FROM Student S 
    WHERE EXISTS (SELECT 1 FROM Enrollment E WHERE E.StudentID = S.StudentID);

    SELECT S.FirstName FROM Student S 
    WHERE NOT EXISTS (SELECT 1 FROM Enrollment E WHERE E.StudentID = S.StudentID);

    -- Derived Table
SELECT D.DeptName, DS.DeptAvg
FROM   Department D
JOIN   ( SELECT DeptID, AVG(GPA) AS DeptAvg
         FROM   Student
         GROUP BY DeptID ) AS DS
       ON D.DeptID = DS.DeptID
WHERE  DS.DeptAvg > 3.0;



