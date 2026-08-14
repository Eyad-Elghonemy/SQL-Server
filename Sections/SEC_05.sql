-- ======================================================================
-- Section 05 — Streaming Platform Schema (SubscriptionPlan, Creator, Video, User, Watched) + ALTER TABLE + UPDATE/DELETE
-- Database 1 Course
-- ======================================================================


CREATE DATABASE SEC_5;
USE SEC_5;

CREATE TABLE SubscriptionPlan(

	PlanID	INT PRIMARY KEY,
	PlanName	VARCHAR(50)	NOT NULL,
	Price	DECIMAL(8,2)	NOT NULL,
	Quality	VARCHAR(50)
);

CREATE TABLE Creator(

	CreatorID	INT	PRIMARY KEY,
	CreatorName	VARCHAR(100)	NOT NULL,
	Country		VARCHAR(50),
	JoinDate	DATE
);


CREATE TABLE Video(

	VideoID	   INT  PRIMARY KEY,
	Title	   VARCHAR(200) NOT NULL,
	Duration   INT,
	Genere	   VARCHAR(50),
	ReleaseYear	INT,
	CreatorID	INT	REFERENCES Creator(CreatorID)
);


CREATE TABLE [USER](

	UserID	INT	PRIMARY KEY,
	FullName	NVARCHAR(100) NOT NULL,
	Email		VARCHAR(150)  UNIQUE,
	JoinDate	DATE,
	PlanID	INT	REFERENCES SubscriptionPlan(PlanID)

);

CREATE TABLE Watched(

	VideoID	   INT REFERENCES Video(VideoID),
	UserID	   INT REFERENCES [User](UserID),
	WatchedAt  DATETIME,
	WatchProgress	INT,
	PRIMARY KEY(UserID,VideoID)

);




ALTER TABLE SubscriptionPlan ADD MaxDevices INT;
ALTER TABLE [USER] ADD Phone INT



INSERT INTO SubscriptionPlan (PlanID, PlanName, Price, Quality, MaxDevices)
VALUES
  (1, 'Basic', 4.99, 'SD', 1),
  (2, 'Standard', 8.99, 'HD', 2),
  (3, 'Premium', 14.99, '4K', 4);

INSERT INTO Creator (CreatorID, CreatorName, Country, JoinDate)
VALUES
  (1, 'TechReview', 'EG', '2022-03-15'),
  (2, 'CinemaScope', 'US', '2021-08-01');


INSERT INTO Video (VideoID, Title, Duration, Genere , ReleaseYear, CreatorID)
VALUES
  (1, 'Intro to SQL', 45, 'Education', 2023, 1),
  (2, 'Database Design 101', 60, 'Education', 2023, 1),
  (3, 'Cairo After Dark', 110, 'Drama', 2022, 2),
  (4, 'The Desert Code', 95, 'Thriller', 2024, 2);


INSERT INTO [User] (UserID, FullName, Email, Phone, JoinDate, PlanID)
VALUES
  (1, 'Ahmed Hassan', 'ahmed@watchit.io', '01012345678', '2024-01-10', 2),
  (2, 'Sara Mohamed', 'sara@watchit.io', '01098765432', '2024-02-20', 3),
  (3, 'Omar Khaled', 'omar@watchit.io', NULL, '2024-03-05', 1);



INSERT INTO Watched (UserID, VideoID, WatchedAt, WatchProgress)
VALUES
  (1, 1, '2024-04-01 20:00:00', 300),
  (1, 3, '2024-04-02 21:30:00', 620),
  (2, 2, '2024-04-03 19:00:00', 3200),
  (2, 4, '2024-04-04 22:00:00', 145),
  (3, 1, '2024-04-05 18:00:00', 1200);



UPDATE [USER] SET PlanID = 2 WHERE UserID = 3;
DELETE FROM Watched WHERE UserID=1 AND VideoID=3;
