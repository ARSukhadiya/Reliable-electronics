CREATE DATABASE Reliable_Electronics;

-- Person Table
CREATE TABLE PERSON (
Id int PRIMARY KEY,
FirstName varchar(30),
LastName varchar(30),
Gender varchar(15),
Email varchar(50),
PhoneNumber numeric,
SSN VARCHAR(20),
Address VARCHAR(150)
);

-- List of the Departments
CREATE TABLE DEPARTMENT(
Id varchar(10) PRIMARY KEY,
Name varchar(50)
);

-- List of the Sub-Departments
CREATE TABLE SUBDEPARTMENT(
Id varchar(10) PRIMARY KEY,
Name varchar(50),
DeptId varchar(10),
CONSTRAINT FK_DeptId FOREIGN KEY (DeptId) REFERENCES Department(Id) ON DELETE CASCADE ON UPDATE CASCADE);

-- Employee data
CREATE TABLE EMPLOYEE (
Id varchar(10) PRIMARY KEY,
PersonId int,
JoiningDate datetime,
SubDepartmentId varchar(10),
CONSTRAINT FK_PersonId FOREIGN KEY (PersonId) REFERENCES PERSON(Id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FK_SubDepartmentId FOREIGN KEY (SubDepartmentId) REFERENCES SUBDEPARTMENT(Id) ON DELETE SET NULL ON UPDATE CASCADE 
);

-- Inventory data
CREATE TABLE INVENTORY (
Id VARCHAR(10) PRIMARY KEY,
Name VARCHAR(50),
Location VARCHAR(50),
Type VARCHAR(20),
LastUpdatedDate DATETIME,
ManagerId VARCHAR(10),
CONSTRAINT FK_ManagerId FOREIGN KEY (ManagerId) REFERENCES EMPLOYEE(Id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Equipment data
CREATE TABLE EQUIPMENT (
Id VARCHAR(10) PRIMARY KEY,
Name VARCHAR(50), 
Quantity int,
Type VARCHAR(50) NOT NULL,
Description VARCHAR(1000)
);

-- Tools Details
CREATE TABLE TOOLSDETAIL (
Id INT PRIMARY KEY,
EquipId VARCHAR(10),
Name VARCHAR(50),
Manufacturer VARCHAR(15),
Model VARCHAR(15),
Category VARCHAR(20) DEFAULT 'Perishable',
Price DECIMAL, 
Weight DECIMAL,	
Description VARCHAR(1000),
CONSTRAINT FK_EquipId FOREIGN KEY (EquipId) REFERENCES EQUIPMENT(Id) ON DELETE SET NULL
);


-- Tools data
CREATE TABLE TOOLS (
ToolId VARCHAR(10) PRIMARY KEY,
InvId VARCHAR(10), 
PurchaseDate DATETIME,
TStatus VARCHAR(20) DEFAULT 'Available',
ToolsDetailId INT,
CONSTRAINT FK_ToolsDetailId FOREIGN KEY (ToolsDetailId) REFERENCES TOOLSDETAIL(Id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FK_InvId FOREIGN KEY (InvId) REFERENCES INVENTORY(Id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- CheckIN/Out data
CREATE TABLE CHECKINOUT (
Id VARCHAR(15) PRIMARY KEY,
EmpId VARCHAR(10),
CheckInDateTime DATETIME,
CheckInQuantity INT,
CheckOutQuantity INT,
CheckOutExpectedDate DATETIME,
CONSTRAINT FK_EmpId FOREIGN KEY (EmpId) REFERENCES EMPLOYEE(Id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- CheckIn/Out Tools
CREATE TABLE CHECKINOUTTOOL(
CheckInId VARCHAR(15),
ToolId VARCHAR(10),
CONSTRAINT FK_ToolsId FOREIGN KEY (ToolId) REFERENCES TOOLS(ToolId) ON UPDATE CASCADE,
CONSTRAINT FK_CheckInId FOREIGN KEY (CheckInId) REFERENCES CHECKINOUT(Id) ON DELETE CASCADE ON UPDATE CASCADE
);
UPDATE CHECKINOUT SET EmpId = E007 WHERE Id = 'CI010';

-- DamageLost data
CREATE TABLE DAMAGELOST (
Id VARCHAR(10) PRIMARY KEY,
ToolId VARCHAR(10),
CheckInId VARCHAR(15),
Type VARCHAR(20),
Description VARCHAR(1000),
DateTime DATETIME,
Expense DECIMAL,
CONSTRAINT FK_D_and_L_ToolId FOREIGN KEY (ToolId) REFERENCES TOOLS(ToolId) ON UPDATE CASCADE,
CONSTRAINT FK_D_and_L_CheckInId FOREIGN KEY (CheckInId) REFERENCES CHECKINOUT(Id) ON DELETE CASCADE ON UPDATE CASCADE
);




SELECT * FROM PERSON;
SELECT * FROM DEPARTMENT;
SELECT * FROM SUBDEPARTMENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM INVENTORY;
SELECT * FROM EQUIPMENT;
SELECT * FROM TOOLSDETAIL;
SELECT * FROM TOOLS;
SELECT * FROM CHECKINOUT;
SELECT * FROM CHECKINOUTTOOL;
SELECT * FROM DAMAGELOST;

//SELECT * FROM LOSTITEM;


INSERT INTO PERSON (Id, FirstName, LastName, Gender, Email, PhoneNumber, SSN, Address)
VALUES
	(1, 'John', 'Doe', 'Male', 'john.doe@example.com', 1234567890, 123456789, '123 Main St Long Beach CA USA, 12345'),
    (2, 'Jane', 'Smith', 'Female', 'jane.smith@example.com', 9876543210, 987654321, '456 Oak St Queens NY USA, 54321'),
    (3, 'Bob', 'Johnson', 'Male', 'bob.johnson@example.com', 5551234567, 555987654, '789 Pine St San Jose CA USA, 67890'),
    (4, 'Alice', 'Williams', 'Female', 'alice.williams@example.com', 4445556666, 444666555, '101 Elm St Orlando FL USA, 13579'),
    (5, 'Chris', 'Davis', 'Male', 'chris.davis@example.com', 1237894560, 123987654, '222 Maple St Manhattan NY USA, 24680'),
    (6, 'Emily', 'Jones', 'Female', 'emily.jones@example.com', 9998887777, 999777888, '333 Birch St Santa Clara CA USA, 86420'),
    (7, 'Michael', 'Smith', 'Male', 'michael.smith@example.com', 7778889999, 777999888, '444 Cedar St Tampa FL USA, 97531'),
    (8, 'Sara', 'Brown', 'Female', 'sara.brown@example.com', 1112223333, 111333222, '555 Pine St San Bruno CA USA, 36987'),
    (9, 'David', 'Miller', 'Male', 'david.miller@example.com', 2223334444, 222444333, '666 Oak St Fremont CA USA, 75319'),
    (10, 'Olivia', 'Taylor', 'Female', 'olivia.taylor@example.com', 3334445555, 333555444, '777 Elm St Park City UT USA, 15963'),
    (11, 'William', 'Taylor', 'Male', 'william@email.com', 9876543210, '67555444','456 Birch St CozyTown UT USA, 44444'),
    (12, 'Olivia', 'Martinez', 'Female', 'olivia@email.com', 1234567890, 123456789012, '123 Avenue MegaCity MegaState MegaCountry, 99999'),
    (13, 'Brown','Martinez', 'Non-Binary', 'nolastname@email.com', 4444444554, 4567800012, '777 Walnut St TinyVillage TinyState TinyCountry, 33333'),
    (14, 'Sophia', 'Brown', 'Female', 'sophianame@email.com',4444444444, 456780012, '789 Maple St SmallTown SmallState SmallCountry, 22222'),
	(15, 'Emma', 'Garcia', 'Female', 'emma@email.com', 9876543210, 987654321, '101 Pine St NewCity CA USA, 98765');


INSERT INTO DEPARTMENT (Id, Name)
VALUES
    ('D001', 'Sales'),
    ('D002', 'Maintenance'),
    ('D003', 'Finance'),
    ('D004', 'Human Resources'),
    ('D005', 'Information Technology'),
    ('D006', 'Customer Support'),
    ('D007', 'Research and Development'),
    ('D008', 'Operations'),
    ('D009', 'Legal'),
    ('D010', 'Quality Assurance');
    
-- UPDATE DEPARTMENT SET Id = 'D014' WHERE Id = 'D004';
    
INSERT INTO SUBDEPARTMENT (Id, Name, DeptId)
VALUES
	('SD001', 'Sales Team A', 'D001'),
    ('SD002', 'Carpentry', 'D002'),
    ('SD003', 'Painting', 'D002'),
    ('SD004', 'Electrical Maintenance', 'D002'),
    ('SD005', 'Welding', 'D002'),
    ('SD006', 'Plumbing', 'D002'),
    ('SD007', 'Finance Planning', 'D003'),
    ('SD008', 'HR Recruitment', 'D004'),
    ('SD009', 'IT Infrastructure', 'D002');

INSERT INTO EMPLOYEE (Id, PersonId, JoiningDate, SubDepartmentId)
VALUES
    ('E001', 1, '2023-01-01 08:00:00', 'SD001'),
    ('E002', 2, '2023-02-15 09:30:00', 'SD002'),
    ('E003', 3, '2023-03-20 10:45:00', 'SD003'),
    ('E004', 4, '2023-04-05 11:15:00', 'SD004'),
    ('E005', 5, '2023-05-10 12:30:00', 'SD004'),
    ('E006', 6, '2023-06-25 13:45:00', 'SD003'),
    ('E007', 7, '2023-07-15 14:30:00', 'SD002'),
    ('E008', 8, '2023-08-02 15:00:00', 'SD001'),
    ('E009', 9, '2023-09-18 16:15:00', 'SD002'),
    ('E010', 10, '2023-10-05 17:30:00', 'SD001'),
    ('E011', 11, '2023-02-15 09:30:00', 'SD002'),
    ('E012', 12, '2023-02-15 09:30:00', 'SD003'),
    ('E013', 13, '2023-02-15 09:30:00', 'SD002'),
    ('E014', 14, '2023-02-15 09:30:00', 'SD004'),
    ('E015', 15, '2023-02-15 09:30:00', 'SD002');

INSERT INTO INVENTORY (Id, Name, Location, Type, LastUpdatedDate, ManagerId)
VALUES
    ('INV001', 'Main Warehouse', 'Oak Street', 'Large', '2023-01-15 08:30:00', 'E001'),
    ('INV002', 'Small Warehouse', 'Maple Avenue', 'Small', '2023-02-20 09:45:00', 'E002');
    
-- DELETE FROM PERSON WHERE Id = '1';
-- UPDATE INVENTORY SET ManagerId = 'E003' WHERE Id = 'INV001';
    
INSERT INTO EQUIPMENT (Id, Name, Quantity, Type, Description)
VALUES
    ('EQP001', 'Power Drill (Cordless)', 20, 'Tool', 'Corded power drill for various construction tasks.'),
    ('EQP002', 'Soldering Iron', 15, 'Electronics', 'High-temperature soldering iron for electronic soldering.'),
    ('EQP003', 'Forklift', 5, 'Vehicle', 'Electric forklift for material handling in the warehouse.'),
    ('EQP004', 'Generator', 8, 'Power', 'Diesel generator for backup power supply during outages.'),
    ('EQP005', 'Excavator', 3, 'Construction', 'Heavy-duty excavator for construction and digging tasks.'),
    ('EQP006', 'Printers', 30, 'Office', 'Office printers for document printing.'),
    ('EQP007', 'Safety Helmets', 100, 'Safety', 'Standard safety helmets for construction site workers.'),
    ('EQP008', 'Network Switch', 12, 'IT', 'Ethernet network switch for office network infrastructure.'),
    ('EQP009', 'Box of Screws', 500, 'Fastener', 'Assorted screws for woodworking and construction.'),
    ('EQP010', 'Box of Nails', 800, 'Fastener', 'Assorted nails for various construction tasks.');


    
-- insert data into toolsDetail table
INSERT INTO TOOLSDETAIL (Id, EquipId, Name, Manufacturer, Model, Category, Price, Weight, Description) 
VALUES
	-- Power Drill 'EQP001'
    (1, 'EQP001', 'Hammer Drill','Makita', 'D100', 'NonPerishable', 99, 10, 'Cordless drill for easy and portable use.'),
    (2, 'EQP001', 'Percussion Drill', 'Makita', 'D101', 'NonPerishable',68, 11, 'Cordless drill for easy and portable use.'),
    (3, 'EQP001', 'Mixed & Rotary Drill', 'Makita', 'D102', 'NonPerishable', 75, 10.5, 'Cordless drill for easy and portable use.'),
    (4, 'EQP001', 'Angle Drill', 'Makita', 'D103', 'NonPerishable', 87, 11, 'Cordless drill for easy and portable use.'),
    (5, 'EQP001', 'Impect Driver', 'Makita', 'D104', 'NonPerishable', 54, 9, 'Cordless drill for easy and portable use.'),
    -- Soldering Iron 'EQP002'
	(6, 'EQP002', 'Pointed Courtidge','Makita', 'Ma100', 'NonPerishable', 60, 14, 'Soldring knife.'),
    (7, 'EQP002', 'Blade Courtidge', 'Makita', 'Ma101', 'NonPerishable', 55, 15, 'Soldring knife.'),
    (8, 'EQP002', 'Chisel Courtidge', 'Makita', 'Ma102', 'NonPerishable', 70, 20, 'Soldring knife.'),
    (9, 'EQP002', 'Bevel Courtidge', 'Makita', 'Ma103', 'NonPerishable', 49, 10, 'Soldring knife.'),
    (10, 'EQP002', 'Flow Courtidge', 'Makita', 'Ma104', 'NonPerishable', 65.8, 11, 'Soldring knife.'),
    -- Forklift 'EQP003'
	(11, 'EQP003', 'Gasoline', 'Bosch', 'DB121', 'NonPerishable', 2000, 8.2, 'Assorted drill bits for use with power drills.'),
    (12, 'EQP003', 'Propane', 'Bosch', 'DB122', 'NonPerishable', 7986, 8.2, 'Assorted drill bits for use with power drills.'),
    (13, 'EQP003', 'Narrow Aisle', 'Bosch', 'DB123', 'NonPerishable', 5899.99, 8.2, 'Assorted drill bits for use with power drills.'),
    (14, 'EQP003', 'Telescopic', 'Bosch', 'DB124', 'NonPerishable', 2588.99, 8.2, 'Assorted drill bits for use with power drills.'),
    (15, 'EQP003', 'Articulated', 'Bosch', 'DB125', 'NonPerishable', 3477, 8.2, 'Assorted drill bits for use with power drills.'),
    (16, 'EQP003', 'Rough Terrain', 'Bosch', 'DB126', 'NonPerishable', 5000, 8.2, 'Assorted drill bits for use with power drills.'),
    (17, 'EQP003', 'Electric', 'Bosch', 'DB127', 'NonPerishable', 9000, 8.2, 'Assorted drill bits for use with power drills.'),
    (18, 'EQP003', 'Heavy Duty', 'Bosch', 'DB128', 'NonPerishable', 9998.99, 8.2, 'Assorted drill bits for use with power drills.');


-- insert data into tools table
INSERT INTO TOOLS (ToolId, InvId, PurchaseDate, TStatus, ToolsDetailId)
VALUES
	-- Power Drill 'EQP001'
    ('T001', 'INV001', '2023-01-20 10:00:00', 'Available', 1),
    ('T002', 'INV001', '2023-01-20 10:00:00', 'Available', 2),
    ('T003', 'INV001', '2023-01-20 10:00:00', 'Available', 3),
    ('T004', 'INV002', '2023-01-20 10:00:00', 'Available', 4),
    ('T005', 'INV002', '2023-01-20 10:00:00', 'Available', 5),
    -- Soldering Iron 'EQP002'
	('T006', 'INV001', '2023-01-20 10:00:00', 'Available', 6),
    ('T007', 'INV001', '2023-01-20 10:00:00', 'Available', 6),
    ('T008', 'INV002', '2023-01-20 10:00:00', 'Available', 6),
    ('T009', 'INV002', '2023-01-20 10:00:00', 'Available', 6),
    ('T010', 'INV001', '2023-01-20 10:00:00', 'Available', 7),
    ('T011', 'INV001', '2023-01-20 10:00:00', 'Available', 7),
    ('T012', 'INV002', '2023-01-20 10:00:00', 'Available', 7),
    ('T013', 'INV002', '2023-01-20 10:00:00', 'Available', 7),
    ('T014', 'INV001', '2023-01-20 10:00:00', 'Available', 8),
    ('T015', 'INV001', '2023-01-20 10:00:00', 'Available', 8),
    ('T016', 'INV002', '2023-01-20 10:00:00', 'Available', 8),
    ('T017', 'INV002', '2023-01-20 10:00:00', 'Available', 8),
    ('T018', 'INV001', '2023-01-20 10:00:00', 'Available', 9),
    ('T019', 'INV001', '2023-01-20 10:00:00', 'Available', 9),
    ('T020', 'INV001', '2023-01-20 10:00:00', 'Available', 9),
    ('T021', 'INV002', '2023-01-20 10:00:00', 'Available', 9),
    ('T022', 'INV001', '2023-01-20 10:00:00', 'Available', 10),
    ('T023', 'INV001', '2023-01-20 10:00:00', 'Available', 10),
    ('T024', 'INV002', '2023-01-20 10:00:00', 'Available', 10),
    ('T025', 'INV002', '2023-01-20 10:00:00', 'Available', 10),
    -- Forklift 'EQP003'
	('T026', 'INV001', '2023-07-25 16:30:00', 'Available', 11),
    ('T027', 'INV001', '2023-07-25 16:30:00', 'Available', 12),
    ('T028', 'INV001', '2023-07-25 16:30:00', 'Available', 13),
    ('T029', 'INV001', '2023-07-25 16:30:00', 'Available', 14),
    ('T030', 'INV002', '2023-07-25 16:30:00', 'Available', 15),
    ('T031', 'INV002', '2023-07-25 16:30:00', 'Available', 16),
    ('T032', 'INV002', '2023-07-25 16:30:00', 'Available', 17),
    ('T033', 'INV002', '2023-07-25 16:30:00', 'Available', 18);

-- insert data into checkinout table
INSERT INTO CHECKINOUT (Id, EmpId, CheckInDateTime, CheckInQuantity, CheckOutQuantity, CheckOutExpectedDate)
VALUES
    ('CI001', 'E004', '2023-01-20 10:30:00', 4, 2, '2023-02-05 14:45:00'),
    ('CI002', 'E011', '2023-01-20 10:30:00', 4, 4, '2023-02-05 14:45:00'),
    ('CI003', 'E005', '2023-02-15 12:00:00', 3, 3, '2023-03-10 09:30:00'),
    ('CI004', 'E006', '2023-03-25 13:15:00', 1, 1, '2023-04-10 15:00:00'),
    ('CI005', 'E007', '2023-04-10 14:45:00', 4, 4, '2023-04-30 11:30:00'),
    ('CI006', 'E008', '2023-04-15 13:15:00', 3, 1, '2023-04-30 15:00:00'),
    ('CI007', 'E006', '2023-04-15 13:15:00', 2, 1, '2023-04-30 15:00:00'),
    ('CI008', 'E006', '2023-04-20 13:15:00', 4, 2, '2023-04-30 15:00:00'),
    ('CI009', 'E006', '2023-04-22 13:15:00', 5, 3, '2023-04-30 15:00:00'),
    ('CI010', 'E006', '2023-04-30 13:15:00', 4, 0, '2023-04-30 15:00:00');

-- insert data into checkinouttool
INSERT INTO CHECKINOUTTOOL(CheckInId, ToolId)
VALUES ('CI001', 'T006'),
    ('CI001', 'T007'),
    ('CI001', 'T031'),
    ('CI001', 'T032'),
    ('CI002', 'T026'),
    ('CI002', 'T033'),
    ('CI002', 'T027'),
    ('CI003', 'T008'),
    ('CI003', 'T026'),
    ('CI003', 'T016'),
    ('CI004', 'T026'),
    ('CI005', 'T001'),
    ('CI005', 'T002'),
    ('CI005', 'T029'),
    ('CI005', 'T019');



-- insert data into damageLost table
INSERT INTO DAMAGELOST (Id, ToolId, CheckInId, Type, Description, DateTime, Expense)
VALUES
    ('DL001', 'T007', 'CI001', 'Damage', 'Damaged during use.', '2023-01-26 15:30:00', 60.00),
    ('DL002', 'T032', 'CI001', 'Lost', 'Missing', '2023-02-02 10:00:00', 35.66),
    ('DL003', 'T031', 'CI004', 'Lost', 'Missing', '2023-04-30 15:00:00', 5000.00),
    ('DL004', 'T021', 'CI002', 'Damage', 'Damaged during use', '2023-04-30 15:00:00', 11.22),
    ('DL005', 'T027', 'CI002', 'Lost', 'Missing', '2023-04-30 15:00:00', 21.96),
    ('DL006', 'T016', 'CI002', 'Lost', 'Missing', '2023-04-30 15:00:00', 58.71),
    ('DL007', 'T015', 'CI003', 'Lost', 'Missing', '2023-04-30 15:00:00', 100.00),
    ('DL008', 'T030', 'CI003', 'Lost', 'Missing', '2023-04-30 15:00:00', 42.00),
    ('DL009', 'T004', 'CI005', 'Damage', 'Damaged during use', '2023-04-30 15:00:00', 87.00);


    ('DL010', 'T003', 'CI005', 'Lost', 'Missing', '2023-04-30 15:00:00', 75.00),
    ('DL011', 'T011', 'CI005', 'Damage', 'Damaged during use', '2023-04-30 15:00:00', 55.00),
    ('DL012', 'T012', 'CI005', 'Lost', 'Missing', '2023-04-30 15:00:00', 55.00);


INSERT INTO DAMAGELOST (Id, ToolId, CheckInId, Type, Description, DateTime, Expense)
VALUES ('DL018', 'T100', 'CI009', 'Lost', 'Missing', '2023-04-30 15:00:00', 55.00);


-- Basic Queries


-- Intermediate Queries
    -- List of tools in the Inventory
    select  iv.Name, iv.Location, iv.Type, count(TOOLS.ToolId) as 'No. of Tools' 
    from TOOLS join INVENTORY iv on TOOLS.InvId = iv.Id group by TOOLS.InvId;

    -- List of lost items
    select Name from TOOLSDETAIL join TOOLS on ToolsDetail.Id = TOOLS.ToolsDetailId
    JOIN DAMAGELOST on DAMAGELOST.ToolId = TOOLS.ToolId and DAMAGELOST.Type = 'Lost';

    -- List of EmployeeId who made Damge
    select CHECKINOUT.EmpId from DAMAGELOST 
    join CHECKINOUT on CHECKINOUT.Id = DAMAGELOST.CheckInId and DAMAGELOST.Type = 'Damage';

    -- List of available tools of the Particular type
    SELECT EQ.Name, count(TOOLS.ToolID) as "Available Tools" from EQUIPMENT as EQ
    LEFT JOIN TOOLSDETAIL as TD on TD.EquipId = EQ.Id
    left join TOOLS on TD.Id = TOOLS.ToolsDetailId and TOOLS.TStatus = 'Available' group by EQ.Name;

    -- List of tools checking on the Particular date 
    SELECT TD.Name, count(TD.Name) AS 'Tools count' FROM TOOLSDETAIL AS TD JOIN TOOLS ON TOOLS.ToolsDetailId = TD.Id
    JOIN CHECKINOUTTOOL ON CHECKINOUTTOOL.ToolId = tools.ToolId 
    JOIN CHECKINOUT ON CHECKINOUT.id = CHECKINOUTTOOL.CheckInId
    WHERE CHECKINOUT.CheckInDateTime = '2023-01-20 10:30:00' GROUP BY TD.Name;


-- Advanced Queries
    -- number of the Maintenance Employee
        SELECT count(E.Id) as 'Maintenance Employee count' FROM EMPLOYEE E
        JOIN SUBDEPARTMENT SD ON E.SubDepartmentId = SD.Id 
        and SD.DeptId in (SELECT D.Id FROM DEPARTMENT D WHERE Name LIKE '%Maintenance%');

    -- List of Employee who made Damage or Lost
    select E.Id, FirstName || ' ' || LastName as 'EmployeeName' from PERSON P
    join EMPLOYEE E on E.PersonId = P.id 
    where E.id in 
    (select EmpId from CHECKINOUT C where C.Id in (select CheckInId from DAMAGELOST));

        -- List of Employee who made Damage or Lost
        select EMPLOYEE.Id ,concat(FirstName,' ',LastName) as 'EmployeeName' from PERSON 
        join EMPLOYEE on EMPLOYEE.PersonId = PERSON.id 
        where EMPLOYEE.id in (select EmpId from CHECKINOUT where CHECKINOUT.Id in (select CheckInId from DAMAGELOST));

    -- List of Employee who made Lost
    select EmpId from CHECKINOUT cio 
    where cio.Id in (select CheckInId from DAMAGELOST where Type = 'Lost');


-- Total Expense of lost and damage
select sum(Expense) from DAMAGELOST;



-- List of available tools of the Particular type in particular Inventory
SELECT EQ.Name, count(TOOLS.ToolID) as "Available Tools" from EQUIPMENT as EQ
LEFT JOIN TOOLSDETAIL as TD on TD.EquipId = EQ.Id
left join TOOLS on TD.Id = TOOLS.ToolsDetailId and TOOLS.TStatus = 'Available' and TOOLS.InvId = 'INV00' group by EQ.Name;

-- NF -> EMPLOYEE Table
ALTER TABLE EMPLOYEE DROP FOREIGN KEY employee_ibfk_2;
ALTER TABLE EMPLOYEE DROP COLUMN DeptId;


-- List avg expense of lost and Damage for April, 2023
SELECT round(AVG(Expense),2) as 'Avg Expense' 
FROM DAMAGELOST 
WHERE MONTH(DateTime) = 4;


-- Total Expense of Lost and Damage for April, 2023
SELECT SUM(Expense) as 'Total Expense' 
FROM DAMAGELOST 
WHERE MONTH(DateTime) = 4;

SELECT count(ToolId),ToolId from DAMAGELOST group by ToolId;

select Name from TOOLSDETAIL join TOOLS on ToolsDetail.Id = TOOLS.ToolsDetailId
JOIN DAMAGELOST on DAMAGELOST.ToolId = TOOLS.ToolId and DAMAGELOST.Type = 'Lost' and Name like '%Hammer%';

SELECT Id FROM DAMAGELOST ORDER BY Id DESC LIMIT 1;
UPDATE TOOLS SET TStatus = 'Available' WHERE InvId in (SELECT Id FROM INVENTORY);
UPDATE TOOLS SET TStatus = 'Damage' WHERE ToolId in (SELECT ToolId FROM DAMAGELOST WHERE Type = 'Damage');
UPDATE TOOLS SET TStatus = 'Lost' WHERE ToolId in (SELECT ToolId FROM DAMAGELOST WHERE Type = 'Lost');