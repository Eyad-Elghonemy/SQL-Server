CREATE DATABASE ASS_2;
USE ASS_2;

CREATE TABLE Department(
	DeptCategory	INT	PRIMARY KEY,
	DeptName		VARCHAR(50)	NOT NULL
);

CREATE TABLE [Product](
	ProSerial	INT		PRIMARY KEY,
	ProName		VARCHAR(100)	NOT NULL,
	UnitPrice	DECIMAL(10,2)	NOT NULL CHECK(UnitPrice BETWEEN 100 AND 500),
	QuantityOnHand	INT	DEFAULT	0,
	DeptCategory	INT		FOREIGN KEY REFERENCES	Department(DeptCategory)		

);

CREATE TABLE Customer(
	
	CustNo	INT	PRIMARY KEY,
	CustFName	VARCHAR(100)	NOT NULL,
	CustLName	VARCHAR(100)	NOT NULL,
	CustPhone	INT	UNIQUE,
	Custddress	VARCHAR(100)

);

CREATE TABLE Buying(
	ProSerial	INT FOREIGN KEY REFERENCES	[Product](ProSerial),
	CustNo	INT		FOREIGN KEY REFERENCES	Customer(CustNo),
	BuyingDate		DATETIME	DEFAULT	GETDATE(),
	Quantity		INT,
	PRIMARY KEY(ProSerial,CustNo)

);

-- Insert at least 5 rows in each table.

INSERT INTO Department(DeptCategory,DeptName)
VALUES 
(1, 'Home Appliances'),
(2, 'Clothes'),
(3, 'Electronics'),
(4, 'Toys'),
(5, 'Groceries');


INSERT INTO [Product](ProSerial,ProName,UnitPrice,QuantityOnHand,DeptCategory)
VALUES (101, 'Air Fryier', 400, 1, 1),
(102, 'Hoodie', 350, 2, 2),
(103, 'Xbox', 200, 1, 3),
(104, 'Ball', 150, 4, 4),
(105, 'Tona', 100, 3, 5);

INSERT INTO Customer(CustNo,CustFName,CustLName,CustPhone,Custddress)
VALUES
(1,'Ali', 'Ahmed', 010148596, 'Cairo'),
(2,'Sama', 'Kareem', 010148896, 'Alex'),
(3,'Mariem', 'Essam', 010167596, 'Giza'),
(4,'Toka', 'Ashraf', 010134596, 'Giza'),
(5,'Reham', 'Ahmed', 010134597, 'Cairo');

INSERT INTO Buying(ProSerial,CustNo,Quantity)
VALUES
(101, 1,1),
(102, 2,2),
(103, 3,1),
(104, 4,3),
(105, 5,1);

-- Add a new column for a table.
ALTER TABLE Customer ADD Email VARCHAR(100);


-- Add a Primary key constraint for a table.
ALTER TABLE Buying DROP CONSTRAINT PK__Buying__95814C1FC71FA0DA;

ALTER TABLE Buying ADD CONSTRAINT pk_buying PRIMARY KEY (ProSerial,CustNo);

-- Drop column
ALTER TABLE Customer DROP COLUMN Email;

-- Modify the data type of column
ALTER TABLE Customer ALTER COLUMN Custddress NVARCHAR(100);

