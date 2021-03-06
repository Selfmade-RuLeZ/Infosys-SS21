
drop database infosys;
create database infosys;
use infosys;


CREATE TABLE [Position]
(
 [Position_ID]  int identity(1,1),
 [Booking_Date] datetime NOT NULL ,
 [Value_Date]   datetime NOT NULL ,
 [Booking_Text] varchar(50) NOT NULL ,
 [Usage]        varchar(255) NOT NULL ,
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

/*
INSERT INTO position (Booking_Date, Value_Date, Booking_Text, Usage, Beneficiary, Amount)
VALUES ('02.01.2019', '02.01.2019','LASTSCHRIFT', 'ZWIEBEL ANZ. 4246638', 'ZWIEBEL ESSLINGEN',-60.84)

INSERT INTO position (Booking_Date, Value_Date, Booking_Text, Usage, Beneficiary, Amount)
VALUES ('02.01.2019',  '02.01.2019', 'DAUERAUFTRAG',  'MIETE 300 ','EHELEUTE HAEFELE', 360.00)
*/

/* declare @amount float; */
/* select @amount = parse(replace(replace('-3.333,90', '.', ''), ',', '.') as float); */
/* Print 'amount: ' + cast(@amount as varchar); */

/* declare @time datetime; */
/* select @time = CONVERT(DATETIME,'02.01.2019') */
/* select @time = '02.01.2019' */
/* print @time */