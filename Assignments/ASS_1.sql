CREATE DATABASE ASS_1;
USE ASS_1;

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
