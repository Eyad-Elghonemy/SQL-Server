-- ======================================================================
-- Practice 01 — Multi-Schema Practice: Hotel Booking, Product Inventory, University (Student/Course/Registration), Airline (Passenger/Flight)
-- Database 1 Course
-- Note: fixed a trailing comma in the Booking table and a table-name mismatch (Registration -> Regestraition) so the script runs end to end.
-- ======================================================================


CREATE DATABASE Pra;
USE Pra;


CREATE TABLE Guest(

	GuestID		INT				PRIMARY KEY,
	GuestFName	VARCHAR(100)	NOT NULL,
	GuestLName	VARCHAR(100)	NOT NULL,
	Email		VARCHAR(100),
	Phone		NVARCHAR(100)

);

CREATE TABLE Room(
	
	RoomID	INT PRIMARY KEY,
	RoomPosition	VARCHAR(100),
	RoomType		VARCHAR(100),
	PricePerNight	DECIMAL(10,2)

);

CREATE TABLE Booking(
	
	GuestID	INT	REFERENCES	Guest(GuestID),
	RoomID	INT	REFERENCES	Room(RoomID),
	BookingDate	DATE
);

INSERT INTO Guest(GuestID,GuestFName,GuestLName,Email,Phone) VALUES
(1, 'Ali', 'Ahmed', 'Ali@gmail.com', '0120221200'),
(2, 'kareem', 'Ahmed', 'Ali@gmail.com', '0120221200'),
(3, 'Samy', 'Ahmed', 'Ali@gmail.com', '0120221200');


INSERT INTO  Room(RoomID,RoomPosition,RoomType,PricePerNight) VALUES
(1, 'North', 'Sweet', 200),
(2, 'West', 'onebed', 200),
(3, 'South', 'twobed', 200);


INSERT INTO Booking(GuestID, RoomID, BookingDate) VALUES
(1, 1, '2026-1-1'),
(2, 3, '2026-2-1'),
(3, 2, '2026-3-1');


SELECT GuestFName + ' ' + GuestLName AS GuestName, BookingDate, Room.*
FROM Booking JOIN Guest
ON Booking.GuestID = Guest.GuestID
JOIN Room ON Booking.RoomID = Room.RoomID;

-------------------------------------------

DROP TABLE IF EXISTS Guest;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS Booking;
-------------------------------------------

CREATE TABLE [Product](

	ProductNo		INT		PRIMARY KEY,
	ProductName		VARCHAR(100) NOT NULL,
	ProductPrice	DECIMAL(8,2)	CHECK(ProductPrice < 1000),
	ProductOnHand	INT,
	ProductCategory	VARCHAR(100) NOT NULL,
	DateExpire		DATE

);


INSERT INTO [Product](ProductNo,ProductName,ProductPrice,ProductOnHand,ProductCategory,DateExpire) VALUES 
(1, 'Pasta',40,5,'Carbs','2027-1-1'),
(2, 'Rice',50,3,'soils','2028-1-1');

SELECT COUNT(ProductCategory) AS NumOfCategories FROM [Product];

ALTER TABLE [Product] DROP COLUMN DateExpire;


INSERT INTO [Product](ProductNo,ProductName,ProductPrice,ProductOnHand,ProductCategory) VALUES 
(3, 'Meat',250,5,'Fats'),
(4, 'Checken',270,3,'Fats');

SELECT ProductName  
FROM [Product]
WHERE ProductPrice = 250 OR ProductPrice = 270;


DROP TABLE IF EXISTS [Product];

---------------------------------------------------

CREATE TABLE Department(

	DeptID	INT	PRIMARY KEY,
	DeptName	VARCHAR(100)

);

CREATE TABLE Student(
	
	SCode	INT	PRIMARY KEY,
	SFName	VARCHAR(100),
	SLName	VARCHAR(100),
	SAddress	VARCHAR(100),
	SBirthDate	DATE,
	SGender		VARCHAR(50),
	SPhone		INT,
	DeptID		INT		REFERENCES	Department(DeptID)

);

CREATE TABLE Course(
	
	CCode		INT	PRIMARY KEY,
	CTitle		VARCHAR(100),
	Prerequesite	VARCHAR(100),
	Lecture			VARCHAR(100),
	Tutorial		VARCHAR(100),
	Lab				VARCHAR(100),
	Credits			INT,
	DeptID		INT		REFERENCES	Department(DeptID)
);

CREATE TABLE Registeration(
	
	SCode	INT	REFERENCES Student(SCode),
	CCode	INT REFERENCES Course(CCode),
	Grade	VARCHAR(10)
	
);

INSERT INTO Department (DeptID, DeptName) VALUES
(1, 'Computer Science'),
(2, 'Information Systems'),
(3, 'Electrical Engineering');

INSERT INTO Student (SCode, SFName, SLName, SAddress, SBirthDate, SGender, SPhone, DeptID) VALUES
(101, 'Omar', 'Samy', 'Banha', '2004-05-15', 'Male', 1234567, 1),
(102, 'Ahmed', 'Ali', 'Cairo', '2005-02-10', 'Male', 7654321, 2),
(103, 'Sara', 'Kamal', 'Alex', '2004-11-20', 'Female', 1122334, 1),
(104, 'Mona', 'Hassan', 'Giza', '2005-08-05', 'Female', 5566778, 3);

INSERT INTO Course (CCode, CTitle, Prerequesite, Lecture, Tutorial, Lab, Credits, DeptID) VALUES
(201, 'Database 1', 'Intro to CS', 'Room 101', 'T1', 'Lab A', 3, 1),
(202, 'Algorithms', 'Programming 2', 'Room 205', 'T2', 'Lab B', 4, 1),
(203, 'Accounting', NULL, 'Room 303', 'T3', NULL, 2, 2);

INSERT INTO Registeration (SCode, CCode, Grade) VALUES
(101, 201, 'A'),
(101, 202, 'B+'),
(102, 203, 'A-'),
(103, 201, 'B'),
(104, 203, 'C+');

-- 1 
SELECT SFName + ' ' + SLName AS SName, SAddress, SBirthDate, SGender, SPhone
FROM Student 
WHERE Student.SFName NOT LIKE '%A%' AND Student.SLName NOT LIKE '%A%'
ORDER BY SName;

-- 2
SELECT Course.CTitle
FROM Course
WHERE Course.Lab IS NULL;

-- 3
SELECT S.SFName, C.CTitle, R.Grade
FROM Student S JOIN Registeration R
ON S.SCode = R.SCode
JOIN Course C ON R.CCode = C.CCode;

-- 4
SELECT COUNT(S.SCode) AS TotalStudents, D.DeptName
FROM Student S JOIN Department D
ON S.DeptID = D.DeptID
GROUP BY D.DeptName;

-- 5


DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Registeration;
------------------------------------------------

CREATE TABLE Passenger(
	
	PassID	INT	PRIMARY KEY,
	PassName	VARCHAR(100),
	PassAddress	VARCHAR(100),
	PassEmail	VARCHAR(100)

);


CREATE TABLE PassPhone(
	PassID	INT REFERENCES	Passenger(PassID),
	PassPhone	INT,
	PRIMARY KEY(PassID,PassPhone)
);

CREATE TABLE Flight(
	FlightNo		INT	PRIMARY KEY,
	FlaightDate		DATETIME,
	FlightPrice		DECIMAL(8,2),
	FlightDeparture	VARCHAR(100),
	FlightAArrival  VARCHAR(100),
	DepartureTime	DATETIME,
	ArrivalTime	    DATETIME,
	AvailableSeats	INT

);

CREATE TABLE Regestraition(

	PassID	INT	REFERENCES	Passenger(PassID),
	FlightNo	INT	REFERENCES Flight(FlightNo),
	RegistDate	DATETIME,
	PRIMARY KEY (PassID, FlightNo)

);


-- إضافة ركاب
INSERT INTO Passenger VALUES (1, 'Ahmed Ali', 'Cairo', 'ahmed@mail.com');
INSERT INTO Passenger VALUES (2, 'Mona Salem', 'Alex', 'mona@mail.com');
INSERT INTO Passenger VALUES (3, 'Omar Samy', 'Giza', 'omar@mail.com');

-- إضافة تليفونات (عشان تجرّب عرض كل الأرقام)
INSERT INTO PassPhone VALUES (1, '010111'), (1, '012222');
INSERT INTO PassPhone VALUES (2, '011333');
INSERT INTO PassPhone VALUES (3, '015444'), (3, '010555');

-- إضافة رحلات (واحدة لمصر عشان السؤال طالب كدة)
INSERT INTO Flight VALUES (101, '2026-05-10', 1200.00, 'Dubai', 'Egypt', '10:00', '13:00', 50);
INSERT INTO Flight VALUES (102, '2026-05-11', 800.00, 'Cairo', 'London', '08:00', '14:00', 30);
INSERT INTO Flight VALUES (103, '2026-05-12', 1500.00, 'Riyadh', 'Egypt', '15:00', '17:00', 20);

-- إضافة حجوزات
INSERT INTO Regestraition VALUES (1, 101, GETDATE());
INSERT INTO Regestraition VALUES (1, 102, GETDATE());
INSERT INTO Regestraition VALUES (1, 103, GETDATE());
INSERT INTO Regestraition VALUES (1, 101, GETDATE()); -- (تجربة لأكثر من 3 رحلات)
INSERT INTO Regestraition VALUES (2, 101, GETDATE());
INSERT INTO Regestraition VALUES (3, 103, GETDATE());



-- 1 
SELECT *
FROM Flight
WHERE Flight.FlightPrice > 1000;

-- 3
SELECT P.PassName, Ph.PassPhone
FROM PassPhone Ph JOIN Passenger P
ON Ph.PassID = P.PassID;

-- 4
SELECT P.PassName, F.FlightAArrival
FROM Passenger P JOIN Regestraition R
ON P.PassID = R.PassID
JOIN Flight F ON R.FlightNo = F.FlightNo;

-- 5
SELECT P.PassName
FROM Passenger P JOIN Regestraition R
ON P.PassID = R.PassID
JOIN Flight F ON R.FlightNo = F.FlightNo
WHERE F.FlightAArrival = 'Egypt';

-- 6 
SELECT P.PassName, COUNT(R.FlightNo)
FROM Passenger P JOIN Regestraition R
ON P.PassID = R.PassID
GROUP BY P.PassName
HAVING COUNT(R.FlightNo) > 3;