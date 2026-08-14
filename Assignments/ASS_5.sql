CREATE DATABASE ASS_5;
USE ASS_5;

CREATE TABLE Branch(
	
	BranchID	INT	PRIMARY KEY,
	BranchName	VARCHAR(100)	NOT NULL,
	BranchAddress	VARCHAR(100)	
);

CREATE TABLE Project(
	
	ProID	INT	PRIMARY KEY,
	ProName	VARCHAR(100)	NOT NULL,
	BranchID	INT	REFERENCES	Branch(BranchID)

);

CREATE TABLE Staff(
	
	StaffID		INT	PRIMARY KEY,
	StaffName	VARCHAR(100)	NOT NULL,
	Salary		DECIMAL(10,2),
	BranchID	INT	REFERENCES	Branch(BranchID)

);

CREATE TABLE Working(
	
	StaffID		INT	REFERENCES Staff(StaffID),
	ProID		INT	REFERENCES Project(ProID),
	PRIMARY KEY(StaffID,ProID)

);


INSERT INTO Branch(BranchID,BranchName,BranchAddress) VALUES
(1, 'IT', 'Cairo'),
(2, 'Finance', 'Alex'),
(3, 'Commerce', 'Giza'),
(4, 'Marketing', 'Meofia'),
(5, 'Social Media', 'Cairo');

INSERT INTO Project(ProID,ProName,BranchID) VALUES 
(101, 'AI', 1),
(102, 'Audit', 2),
(103, 'Selling', 3),
(104, 'Adds', 4),
(105, 'Facebook Adds', 5);

INSERT INTO Staff(StaffID,StaffName,Salary,BranchID) VALUES
(1, 'Daniel', 30000, 1),
(2, 'Darren', 34000, 2),
(3, 'Ahmed', 15000, 3),
(4, 'Ali', 19000, 4),
(5, 'Yasser', 22000, 5);


INSERT INTO Working(StaffID,ProID) VALUES
(1, 101),
(2, 105),
(5, 104);



-- Display the number of staff, minimum salary and salary average in the company.
SELECT COUNT(StaffID) AS TotalStaff, MIN(Salary) AS MinimumSalary, AVG(Salary) AS AverageSalary 
FROM Staff;

-- For each branch, display the maximum salary of staff
SELECT MAX(S.Salary) AS MaxSalary, B.BranchName
FROM Staff S JOIN Branch B
ON S.BranchID = B.BranchID
GROUP BY B.BranchName;

-- For each branch, display the number of staff and total salary value order by branch. [Note: you must display the branch name]
SELECT B.BranchName, COUNT(S.StaffID) AS TotalStaff, SUM(S.Salary) AS TotalSalary
FROM Staff S JOIN Branch B
ON S.BranchID = B.BranchID
GROUP BY B.BranchName
ORDER BY B.BranchName

-- For each branch, display the number of staff and total salary value in which total salary >20000 LE. [Note: you must display the branch name]
SELECT B.BranchName, COUNT(S.StaffID) AS TotalStaff, SUM(S.Salary) AS TotalSalary
FROM Branch B JOIN Staff S
ON B.BranchID = S.BranchID
GROUP BY B.BranchName
HAVING SUM(S.Salary) > 20000
ORDER BY B.BranchName;

-- For each project, display the number of staff worked in project.
SELECT COUNT(W.StaffID) AS TotalStaffWorking, P.ProName
FROM Project P JOIN Working W 
ON P.ProID = W.ProID
JOIN Staff S ON W.StaffID = S.StaffID
GROUP BY P.ProName;

-- For each branch, display the number of project.
SELECT B.BranchName, COUNT(P.ProID) AS TotalProjects
FROM Branch B JOIN Project P
ON B.BranchID = P.BranchID
GROUP BY B.BranchName;

-- Find the information of staff in which the staff salary is more than the average salary.
SELECT * 
FROM Staff 
WHERE Salary > (SELECT AVG(Salary) FROM Staff);