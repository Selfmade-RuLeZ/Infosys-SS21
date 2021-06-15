drop database infosys;
create database infosys;
use infosys;


CREATE TABLE [Position]
(
 [Position_ID]  int identity(1,1),
 [Booking_Date] datetime NOT NULL ,
 [Value_Date]   datetime NOT NULL ,
 [Booking_Text] varchar(50) NOT NULL ,
 [Usage]        varchar(50) NOT NULL ,
 [Beneficiary] varchar(50) NOT NULL ,
 [Amount]       float NOT NULL ,


 CONSTRAINT [PK_position] PRIMARY KEY CLUSTERED ([Position_ID] ASC)
);

CREATE TABLE [Owner]
(
 [Owner_ID]     int identity(1,1),
 [First_Name]   varchar(50) NOT NULL ,
 [Last_Name]    varchar(50) NOT NULL ,
 [Phone_Number] int NOT NULL ,
 [Postal_Code]  int NOT NULL ,
 [Address]      varchar(50) NOT NULL ,


 CONSTRAINT [PK_owner] PRIMARY KEY CLUSTERED ([Owner_ID] ASC)
);

CREATE TABLE [Tenant]
(
 [Tenant_ID]  int identity(1,1),
 [First_Name] varchar(50) NULL ,
 [Last_Name]  varchar(50) NULL ,
 [IBAN]       char(22) NOT NULL ,
 [Persons]    int NOT NULL ,


 CONSTRAINT [PK_tenants] PRIMARY KEY CLUSTERED ([Tenant_ID] ASC)
);

CREATE TABLE [Property]
(
 [Property_ID] int identity(1,1),
 [Owner_ID]    int NOT NULL ,
 [Postal_Code] int NOT NULL ,
 [Address]     varchar(50) NOT NULL ,


 CONSTRAINT [PK_property] PRIMARY KEY CLUSTERED ([Property_ID] ASC),
 CONSTRAINT [FK_40] FOREIGN KEY ([Owner_ID])  REFERENCES [Owner]([Owner_ID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_41] ON [Property] 
 (
  [Owner_ID] ASC
 )

CREATE TABLE [Contract]
(
 [Contract_ID]      int identity(1,1) ,
 [Tenant_ID]        int NOT NULL ,
 [Additional_Costs] float NOT NULL ,
 [Rental_Fee]       float NOT NULL ,
 [Start_Date]       datetime NOT NULL ,
 [End_Date]         datetime NOT NULL ,
 [Property_ID]      int NOT NULL ,


 CONSTRAINT [PK_contract] PRIMARY KEY CLUSTERED ([Contract_ID] ASC),
 CONSTRAINT [FK_22] FOREIGN KEY ([Tenant_ID])  REFERENCES [Tenant]([Tenant_ID]),
 CONSTRAINT [FK_68] FOREIGN KEY ([Property_ID])  REFERENCES [Property]([Property_ID])
);
GO

CREATE NONCLUSTERED INDEX [fkIdx_23] ON [Contract] 
 (
  [Tenant_ID] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_69] ON [Contract] 
 (
  [Property_ID] ASC
 )
 
CREATE TABLE [Flat]
(
 [Flat_ID]     int identity(1,1) ,
 [Address]     varchar(50) NOT NULL ,
 [Size] float NOT NULL,
 [Contract_ID] int NOT NULL ,
 [Tenant_ID]   int NOT NULL ,
 [Owner_ID]    int NOT NULL ,


 CONSTRAINT [PK_flat] PRIMARY KEY CLUSTERED ([Flat_ID] ASC),
 CONSTRAINT [FK_49] FOREIGN KEY ([Contract_ID])  REFERENCES [Contract]([Contract_ID]),
 CONSTRAINT [FK_52] FOREIGN KEY ([Tenant_ID])  REFERENCES [Tenant]([Tenant_ID]),
 CONSTRAINT [FK_55] FOREIGN KEY ([Owner_ID])  REFERENCES [Owner]([Owner_ID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_50] ON [Flat] 
 (
  [Contract_ID] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_53] ON [Flat] 
 (
  [Tenant_ID] ASC
 )

CREATE TABLE [Journal]
(
 [Journal_ID]   int identity(1,1),
 [Booking_Date] datetime NOT NULL ,
 [Value_Date]   datetime NOT NULL ,
 [Amount]       float NOT NULL ,
 [Tenant_ID]    int NOT NULL ,


 CONSTRAINT [PK_journal] PRIMARY KEY CLUSTERED ([Journal_ID] ASC),
 CONSTRAINT [FK_105] FOREIGN KEY ([Tenant_ID])  REFERENCES [Tenant]([Tenant_ID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_106] ON [Journal] 
 (
  [Tenant_ID] ASC
 )

CREATE TABLE [Utility_Cost]
(
 [Utility_Cost_ID] int identity(1,1),
 [Booking_Date]    datetime NOT NULL ,
 [Value_Date]      datetime NOT NULL ,
 [Amount]          float NOT NULL ,
 [Usage] varchar(50) NOT NULL,


 CONSTRAINT [PK_utility_cost] PRIMARY KEY CLUSTERED ([Utility_Cost_ID] ASC)
);
GO

insert into Tenant ( First_Name, Last_Name, IBAN, Persons)
values 
( 'Marcel', 'Mueller' , 'DE12312312312312312312', 2),
( 'Peter', 'Maier' , 'DE12312312312312312313', 3),
( 'Ingrid', 'Haug' , 'DE12312312312312312314', 4),
( 'Dietmar', 'Haefele' , 'DE12312312312312312315', 2),
( 'Petar', 'Koslowski' , 'DE12312312312312312316', 1),
( 'Dietmar', 'Haefele' , 'DE12312312312312312317', 2),
( 'Luigi', 'Barni' , 'DE12312312312312312318', 1),
( 'Michael', 'Mann' , 'DE12312312312312312320', 5),
( 'Guenter', 'Gruner' , 'DE12312312312312312321', 2),
( 'Matthias', 'Stich' , 'DE12312312312312312322', 3),
( 'Phillip', 'Riester' , 'DE12312312312312312323', 1)


insert into Owner (First_Name, Last_Name, Phone_Number, Postal_Code, Address)
values ('G¸nter', 'Grund', 01578456987, 73894, 'Teststraﬂe 14')

insert into Property (Owner_ID, Postal_Code, Address)
values (1, 75687 , 'Teststraﬂe 39')

insert into contract (Tenant_ID, Additional_Costs, Rental_Fee, Start_Date, End_Date, Property_ID)
values 
(1, 200, 650, '20210101', '20211231', 1),
(2, 100, 350, '20210101', '20211231', 1),
(3, 150, 450, '20210101', '20211231', 1),
(4, 200, 320, '20210101', '20211231', 1),
(5, 180, 220, '20210101', '20211231', 1),
(6, 250, 230, '20210101', '20211231', 1),
(7, 300, 310, '20210101', '20211231', 1),
(8, 100, 290, '20210101', '20211231', 1),
(9, 150, 120, '20210101', '20211231', 1),
(10, 130, 310, '20210101', '20211231', 1),
(11, 110, 280, '20210101', '20211231', 1)

insert into flat (Address, Size, Contract_ID, Tenant_ID, Owner_ID)
values 
('Teststraﬂe 39', 80, 1, 1, 1),
('Teststraﬂe 39', 72, 2, 2, 1),
('Teststraﬂe 39', 65, 3, 3, 1),
('Teststraﬂe 39', 68, 4, 4, 1),
('Teststraﬂe 39', 120, 5, 5, 1),
('Teststraﬂe 39', 89, 6, 6, 1),
('Teststraﬂe 39', 98, 7, 7, 1),
('Teststraﬂe 39', 69, 8, 8, 1),
('Teststraﬂe 39', 75, 9, 9, 1),
('Teststraﬂe 39', 71, 10, 10, 1),
('Teststraﬂe 39', 87, 11, 11, 1)