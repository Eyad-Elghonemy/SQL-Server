CREATE DATABASE  ASS_4;
USE ASS_4;


CREATE TABLE Branch(
	
	BrnchID		INT		PRIMARY KEY,
	BranchName	VARCHAR(100)	NOT NULL,
	Location	VARCHAR(100)

);

-- ALTER 

CREATE TABLE Staff(
	
	StaffID		INT		PRIMARY KEY,
	StaffName	VARCHAR(100)	NOT NULL,
	Role		VARCHAR(100),
	BrnchID	INT		REFERENCES	Branch(BrnchID)

);

CREATE TABLE Vehicle(

	VehicleID	INT		PRIMARY KEY,
	Model		VARCHAR(100)	NOT NULL,
	RentalPrice	DECIMAL(10,2),
	BrnchID	INT		REFERENCES	Branch(BrnchID)
);


CREATE TABLE Client(

	ClientID	INT		PRIMARY KEY,
	ClientName	VARCHAR(100)	NOT NULL,
	Phone		INT

);

CREATE TABLE Rental(
	
	RentalNumber	INT	PRIMARY KEY,
	ClientID	INT	REFERENCES Client(ClientID),
	VehicleID	INT REFERENCES Vehicle(VehicleID),
	RentalDate	DATE
);



INSERT INTO Branch(BrnchID, BranchName, Location) VALUES 
(1, 'Cairo Branch', 'Zamalek, Cairo'),
(2, 'Alex Branch', 'Stanley, Alexandria'),
(3, 'Giza Branch', 'Pyramids St, Giza'),
(4, 'Mansoura Branch', 'Talkha, Mansoura'),
(5, 'Tanta Branch', 'Saeed St, Tanta');

INSERT INTO Staff (StaffID, StaffName, Role, BrnchID) VALUES 
(101, 'Ahmed Hassan', 'Manager', 1),
(102, 'David Smith', 'Senior Mechanic', 1),
(103, 'Sara Aly', 'Receptionist', 2),
(104, 'Mohamed Ibrahim', 'Mechanic', 3),
(105, 'Dina Mahmoud', 'Senior Mechanic', 1);

INSERT INTO Vehicle (VehicleID, Model, RentalPrice, BrnchID) VALUES 
(501, 'Toyota Corolla', 1200.00, 1),
(502, 'Mercedes C200', 2500.00, 1),
(503, 'Hyundai Elantra', 950.00, 2),
(504, 'Kia Cerato', 1500.00, 1),
(505, 'Fiat Tipo', 800.00, 3);

INSERT INTO Client (ClientID, ClientName, Phone) VALUES 
(1, 'Ali Mansour', 0101234567),
(2, 'Ahmed Sami', 0119876543),
(3, 'Mona Zaki', 0122233445),
(4, 'Samy Reda', 0155566778),
(5, 'Huda Omar', 0100099887);

INSERT INTO Rental (RentalNumber, ClientID, VehicleID, RentalDate) VALUES 
(1001, 1, 501, '2024-05-01'),
(1002, 2, 502, '2024-05-05'),
(1003, 3, 503, '2024-05-10'),
(1004, 1, 504, '2024-05-15'),
(1005, 5, 501, '2024-05-20');

------------------------------

-- Display all details about customers whose deal with the company.
SELECT C.ClientName
FROM Client C JOIN Rental R
ON C.ClientID = R.ClientID;


-- Display the customers who rented cars from the Cairo branch.
SELECT C.*
FROM Rental R JOIN Client C
ON R.ClientID = C.ClientID
JOIN Vehicle V ON R.VehicleID = V.VehicleID
JOIN Branch B ON V.BrnchID = B.BrnchID
WHERE B.BranchName='Cairo Branch';

-- Display the cars located in the Cairo branch.
SELECT V.Model
FROM Vehicle V JOIN Branch B ON V.BrnchID = B.BrnchID
WHERE B.BranchName='Cairo Branch';

-- Display the rentals accompanied by the customer's name and the car model.
SELECT C.ClientName, V.Model
FROM Client C JOIN Rental R ON C.ClientID = R.ClientID
JOIN Vehicle V ON V.VehicleID = R.VehicleID;

-- Display the vehicle model and price that that have never been rented.
SELECT V.Model, V.RentalPrice
FROM Vehicle V LEFT JOIN Rental R ON V.VehicleID = R.VehicleID
WHERE R.VehicleID IS NULL;

-- Display vehicles with their branch names.
SELECT V.Model, B.BranchName
FROM Vehicle V JOIN Branch B ON V.BrnchID = B.BrnchID;

-- Display staff with their branch names.
SELECT S.StaffName, B.BranchName
FROM Staff S JOIN Branch B 
ON S.BrnchID = B.BrnchID;