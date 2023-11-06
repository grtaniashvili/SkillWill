use SkillWill
--
CREATE TABLE Organization (
    OrganizationID INT PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE Address (
    AddressID INT PRIMARY KEY,
    StreetAddress VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(2),
    ZipCode VARCHAR(10),
    OrganizationID INT UNIQUE,
    FOREIGN KEY (OrganizationID) REFERENCES Organization(OrganizationID)
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    OrganizationID INT,
    FOREIGN KEY (OrganizationID) REFERENCES Organization(OrganizationID)
);

CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(255)
);

CREATE TABLE EmployeeProject (
    EmployeeID INT,
    ProjectID INT,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

INSERT INTO Organization (OrganizationID, Name)
VALUES (1, 'GR Corporation');

INSERT INTO Address (AddressID, StreetAddress, City, State, ZipCode, OrganizationID)
VALUES (1, 'Vaja Pshavela ave.', 'Tbilisi', 'Geo', '12345', 1);

INSERT INTO Employee (EmployeeID, FirstName, LastName, OrganizationID)
VALUES (1, 'John', 'Doe', 1)
,(2, 'Jane', 'Smith', 1)
,(3, 'Jane', 'Doe', 1);

INSERT INTO Project (ProjectID, ProjectName)
VALUES (1, 'Project A')
		,(2, 'Project B');

INSERT INTO EmployeeProject (EmployeeID, ProjectID)
VALUES (1, 1)
		,(2, 2)
		,(1, 2)
		,(3, 2);



