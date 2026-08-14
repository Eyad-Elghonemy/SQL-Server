CREATE DATABASE  ASS_3;

USE ASS_3;


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


-- Display All Details About Vehicles
SELECT * FROM Vehicle;

-- Display the client’s name and phone number ordered alphabetically by name.
SELECT C.ClientName, C.Phone
FROM Client C
ORDER BY C.ClientName;

-- Display the vehicle model in which the rental price is greater than 1000 LE and less than 2000 LE.
SELECT Model, RentalPrice
FROM Vehicle
WHERE RentalPrice > 1000 AND RentalPrice < 2000;

-- Display the value of vehicle rental price for three months .
SELECT Model, V.RentalPrice * 3 AS 'Rental Price For Three Months'
FROM Vehicle V

-- Display the full details of client which name include ali or ahmed .
SELECT *
FROM Client
WHERE ClientName LIKE '%Ali%' OR ClientName LIKE '%ahmed%';

-- Display the full details of staff which name include Letter [D]
SELECT *
FROM Staff
WHERE StaffName LIKE '%D%';