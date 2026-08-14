-- ======================================================================
-- Section 03 — ER Diagram to Relational Schema: Hospital System (Department, Doctor, Patient, Appointment)
-- Database 1 Course
-- ======================================================================


CREATE DATABASE Hospital;

CREATE TABLE Department(

	DeptID	INT	PRIMARY KEY,
	DeptName	NVARCHAR(100)	NOT NULL,
	DeptPhone	NVARCHAR(20)		NOT NULL,
	DeptFloor	NVARCHAR(100)
);

CREATE TABLE Doctor(
	
	DoctorID	INT	PRIMARY KEY,
	DoctorName	NVARCHAR(100)	NOT NULL,
	DoctorSpecialization	NVARCHAR(150) NOT NULL,
	DoctorPhone	NVARCHAR(20),
	DeptID	INT		FOREIGN KEY	 REFERENCES Department(DeptID)
);

CREATE TABLE Patient(
	
	PatientID	INT	PRIMARY KEY,
	PatientName	NVARCHAR(100),
	PatientDateOfBirth	DATETIME,
	PatientPhone	NVARCHAR(20)
);

CREATE TABLE Appointment(
	
	DoctorID	INT	FOREIGN KEY REFERENCES Doctor(DoctorID),
	PatientID	INT FOREIGN KEY	 REFERENCES Patient(PatientID),
	AppDate		DATE,
	AppTime		TIME,
	AppDiagnose		NVARCHAR(200),
	PRIMARY KEY(PatientID, DoctorID, AppDate)
);

