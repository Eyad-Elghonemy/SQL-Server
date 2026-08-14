-- ======================================================================
-- Section 04 — ALTER TABLE, Constraints (CHECK/UNIQUE/FK), DML, ON DELETE CASCADE, sp_rename, Joins
-- Database 1 Course
-- ======================================================================


CREATE DATABASE Uni;

USE Uni;


Create TABLE Department(

	DeptNum		INT		PRIMARY KEY,
	DeptName	NVARCHAR(100)	NOT NULL,
	DeptLocation	NVARCHAR(200)
);

Create TABLE Employee(
	
	EmpId		INT		PRIMARY KEY,
	EmpName		NVARCHAR	NOT NULL,
	EmpSalary	DECIMAL(10,2)	NOT NULL,
	HireDate	DATE	DEFAULT		GETDATE(),
	DeptNum		INT		FOREIGN KEY	REFERENCES	Department(DeptNum)
);


Create TABLE Project(
	
	ProID		INT		PRIMARY KEY,
	ProName		NVARCHAR(200),
	ProBudget	DECIMAL(12,2)	
);

Create TABLE Works_On(
	
	EmpId		INT		FOREIGN KEY REFERENCES	Employee(EmpID),
	ProID		INT		FOREIGN KEY	REFERENCES	Project(ProID),
	HoursWorked	DECIMAL(5,1),
	PRIMARY KEY(EmpId, ProID)
);

-- Add Column --
ALTER TABLE	Department
ADD	DeptField	VARCHAR(100);

SELECT * FROM Department;

-- Drop Column -- 
ALTER TABLE Department
DROP COLUMN	DeptField;

SELECT * FROM Department;

-- Modify Column [Changing Data Types] --
ALTER TABLE Department
ALTER COLUMN	DeptName	VARCHAR(150) NOT NULL;

-- Add Constraint --
ALTER TABLE	Employee
ADD CONSTRAINT	Chk_Salary_Positive	
CHECK	(EmpSalary > 0);


ALTER TABLE Employee
ALTER COLUMN EmpEmail VARCHAR(100)	NOT NULL;


ALTER TABLE	Employee
ADD CONSTRAINT Unique_EmailUNIQUE UNIQUE(EmpEmail);




--------------------
ALTER TABLE Employee
ALTER COLUMN	EmpName NVARCHAR(100) NOT NULL;

INSERT INTO Employee(EmpId, EmpName, EmpSalary, EmpEmail) VALUES
(13201, 'sara', 5000, 'eyadmohamed');
--------------------

-- Rename Table --
EXEC	sp_rename 'Works_On', 'Assignment';

----- DML -----

ALTER TABLE Department
ADD Location NVARCHAR(200);

-----------------------

INSERT INTO Department (DeptNum, DeptName, Location)
VALUES (10, 'Engineering', 'Building A');

INSERT INTO Department (DeptNum, DeptName, Location)
VALUES (20, 'Marketing', 'Building B');

INSERT INTO Department (DeptNum, DeptName, Location)
VALUES (30, 'Finance', 'Building C');

-----------------------

ALTER TABLE	Employee
DROP CONSTRAINT	Unique_EmailUNIQUE;

INSERT INTO Employee (EmpID, EmpName, EmpSalary, HireDate, DeptNum)
VALUES (1, 'Ahmed', 5000, '2023-01-15', 10);

INSERT INTO Employee (EmpID, EmpName, EmpSalary, HireDate, DeptNum)
VALUES (2, 'Sara', 6000, '2022-06-01', 10);

INSERT INTO Employee (EmpID, EmpName, EmpSalary, HireDate, DeptNum)
VALUES (3, 'Omar', 4500, '2024-03-10', 20);

INSERT INTO Employee (EmpID, EmpName, EmpSalary, HireDate, DeptNum)
VALUES (4, 'Mona', 7000, '2021-09-20', 30);

------------------------

INSERT INTO Project (ProID, ProName, ProBudget)
VALUES (100, 'Website Redesign', 50000);

INSERT INTO Project (ProID, ProName, ProBudget)
VALUES (200, 'Mobile App', 120000);

INSERT INTO Project (ProID, ProName, ProBudget)
VALUES (300, 'Data Pipeline', 80000);

-------------------------

INSERT INTO Assignment (EmpID, ProID, HoursWorked)
VALUES (1, 100, 20);  -- Ahmed → Website Redesign

INSERT INTO Assignment (EmpID, ProID, HoursWorked)
VALUES (1, 200, 15);  -- Ahmed → Mobile App

INSERT INTO Assignment (EmpID, ProID, HoursWorked)
VALUES (2, 100, 30);  -- Sara → Website Redesign

INSERT INTO Assignment (EmpID, ProID, HoursWorked)
VALUES (3, 200, 25);  -- Omar → Mobile App

INSERT INTO Assignment (EmpID, ProID, HoursWorked)
VALUES (4, 300, 40);  -- Mona → Data Pipeline

-------------------------------------

---- Update Data ----
UPDATE Employee 
SET	EmpSalary = 10000 WHERE EmpId = 1;

SELECT EmpSalary  FROM Employee WHERE EmpId = 1;


---- Delete Rows ----
DELETE FROM Employee WHERE EmpId = 3;

---- ON DELETE CASCADE ----
ALTER TABLE Assignment 
DROP CONSTRAINT FK__Works_On__EmpId__5535A963;


ALTER TABLE Assignment 
ADD CONSTRAINT FK_Ass_Emp 
FOREIGN KEY (EmpId) REFERENCES Employee(EmpId)
ON DELETE CASCADE
ON UPDATE CASCADE;

---- Single Table Select ----
SELECT EmpName, DeptNum FROM Employee;

---- join ----
SELECT Employee.EmpName, Department.DeptName From Employee
JOIN Department ON Employee.DeptNum = Department.DeptNum;


SELECT E.EmpName, P.ProName, A.HoursWorked
FROM Employee E
JOIN Assignment A ON E.EmpId = A.EmpId
JOIN Project P ON A.ProId = P.ProID;






