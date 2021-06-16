drop database infosys;
go
create database infosys;
go
use infosys;
go
--Tabellen anlegen
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

-- Views anlegen
CREATE VIEW Zahlungen_Mieter
 AS select t.Tenant_ID, SUM(j.Amount) As Offene_Posten, t.First_Name, t.Last_Name
 from Journal as j 
 left join Tenant as t 
 on t.Tenant_ID = j.Tenant_ID 
 where j.Value_Date <= GETDATE()
 group by t.Tenant_ID, t.First_Name, t.Last_Name;
 go
 
IF OBJECT_ID ('dbo.Nebenkosten_P_proPerson') IS NOT NULL
   DROP view dbo.Nebenkosten_P_proPerson
GO
 CREATE VIEW Nebenkosten_P_proPerson
 AS select (SUM(Amount)/(select SUM(persons) from Tenant as t join Contract as c on c.Tenant_ID = t.Tenant_ID where c.Property_ID = 1)) As Gesamtbetrag, Usage, YEAR(Value_Date) AS Jahr 
 from Utility_Cost 
 where Usage IN ('Strom', 'Grundsteuer', 'Wasser', 'Muell')
 group by Usage, YEAR(Value_Date)
 go
 

IF OBJECT_ID ('dbo.Nebenkosten_P_proPerson') IS NOT NULL
   DROP view dbo.Nebenkosten_P_proPerson
GO
 CREATE VIEW Nebenkosten_P_proPerson
 AS select (SUM(Amount)/(select SUM(persons) from Tenant as t join Contract as c on c.Tenant_ID = t.Tenant_ID where c.Property_ID = 1)) As Gesamtbetrag, Usage, YEAR(Value_Date) AS Jahr 
 from Utility_Cost 
 where Usage IN ('Strom')
 group by Usage, YEAR(Value_Date)
 go

IF OBJECT_ID ('dbo.Nebenkosten_Q_proQm') IS NOT NULL
   DROP view dbo.Nebenkosten_Q_proQm
GO
 CREATE VIEW Nebenkosten_Q_proQm
 AS select (SUM(Amount)/(select SUM(f.size) from Flat as f join Contract as c on c.Contract_ID = f.Contract_ID where c.Property_ID = 1)) As Gesamtbetrag, Usage, YEAR(Value_Date) AS Jahr 
 from Utility_Cost 
 where Usage IN ('Heizkosten')
 group by Usage, YEAR(Value_Date)
 go
 
 IF OBJECT_ID ('dbo.gezahlteNebenkostenJeMieter') IS NOT NULL
   DROP view dbo.gezahlteNebenkostenJeMieter
GO
 CREATE VIEW gezahlteNebenkostenJeMieter
 AS 
 select sum(DATEDIFF(MONTH, Start_Date, End_Date)*Additional_Costs) as Gesamtbetrag, First_Name, Last_Name 
 from Contract as c join Tenant as t on t.Tenant_ID = c.Tenant_ID 
 group by First_Name, Last_Name
 go

-- Trigger
IF OBJECT_ID ('dbo.CSVImportTrigger') IS NOT NULL
   DROP trigger dbo.CSVImportTrigger
GO

CREATE TRIGGER [dbo].[CSVImportTrigger] ON [dbo].[Position] AFTER INSERT
AS
BEGIN
	DECLARE @tenantID int;
	DECLARE @beguenstigter varchar(50);

	SELECT @beguenstigter = Beneficiary from inserted;

	IF EXISTS (select last_name from tenant where @beguenstigter LIKE '%'+Last_Name+'%')
	BEGIN
		SELECT @tenantID = tenant_id from tenant where @beguenstigter LIKE '%'+Last_Name+'%';
		INSERT INTO [dbo].[Journal]
			(
				[Booking_Date]
				,[Value_Date]
				,[Amount]
				,[Tenant_ID]
			)
		SELECT
			Booking_Date,
			Value_Date,
			Amount,
			@tenantID
		FROM inserted
	END
	ELSE IF @beguenstigter IN ('ENBW')
	BEGIN
		INSERT INTO [dbo].[Utility_Cost]
			(
				[Booking_Date]
				,[Value_Date]
				,[Amount]
				,[Usage]
			)
		SELECT
			Booking_Date,
			Value_Date,
			Amount,
			'Strom'
		FROM inserted
	END
	ELSE IF @beguenstigter IN ('Wasserversorgung')
	BEGIN
		INSERT INTO [dbo].[Utility_Cost]
			(
				[Booking_Date]
				,[Value_Date]
				,[Amount]
				,[Usage]
			)
		SELECT
			Booking_Date,
			Value_Date,
			Amount,
			'Wasser'
		FROM inserted
	END
	ELSE IF @beguenstigter IN ('Muellabfuhr')
	BEGIN
		INSERT INTO [dbo].[Utility_Cost]
			(
				[Booking_Date]
				,[Value_Date]
				,[Amount]
				,[Usage]
			)
		SELECT
			Booking_Date,
			Value_Date,
			Amount,
			'Muell'
		FROM inserted
	END
	ELSE IF @beguenstigter IN ('HAUG GAS WASSER SCHUTT')
	BEGIN
		INSERT INTO [dbo].[Utility_Cost]
			(
				[Booking_Date]
				,[Value_Date]
				,[Amount]
				,[Usage]
			)
		SELECT
			Booking_Date,
			Value_Date,
			Amount,
			'Handwerker'
		FROM inserted
	END
	ELSE IF @beguenstigter IN ('FA ESSLINGEN')
	BEGIN
		INSERT INTO [dbo].[Utility_Cost]
			(
				[Booking_Date]
				,[Value_Date]
				,[Amount]
				,[Usage]
			)
		SELECT
			Booking_Date,
			Value_Date,
			Amount,
			'Grundsteuer'
		FROM inserted
	END
	ELSE IF @beguenstigter IN ('EVF')
	BEGIN
		INSERT INTO [dbo].[Utility_Cost]
			(
				[Booking_Date]
				,[Value_Date]
				,[Amount]
				,[Usage]
			)
		SELECT
			Booking_Date,
			Value_Date,
			Amount,
			'Heizkosten'
		FROM inserted
	END
END
go

-- Contract Trigger for Journal

CREATE TRIGGER [dbo].[OwnerJournal] ON [dbo].[Contract] AFTER INSERT
AS
BEGIN
	DECLARE contractCursor CURSOR FOR SELECT Tenant_ID, End_Date, Start_Date, 
		Additional_Costs, Rental_Fee FROM inserted
	DECLARE @Tenant_ID int, @End_Date date, @Start_Date date, @Additional_Costs float, @Rental_Fee float
	OPEN contractCursor
	FETCH NEXT FROM contractCursor INTO @Tenant_ID, @End_Date, @Start_Date, @Additional_Costs, @Rental_Fee
	WHILE @@FETCH_STATUS = 0
	BEGIN
		WHILE DATEADD(DAY, 27, @Start_Date) <= @End_Date
		BEGIN
			INSERT INTO [dbo].[Journal]
				(
					[Booking_Date]
					,[Value_Date]
					,[Amount]
					,[Tenant_ID]
				)
			VALUES
			(@Start_Date, @Start_Date, (@Additional_Costs + @Rental_Fee) * -1, @Tenant_ID)
			SET @Start_Date = DATEADD(MONTH, 1, @Start_Date)
		END
		FETCH NEXT FROM contractCursor INTO @Tenant_ID, @End_Date, @Start_Date, @Additional_Costs, @Rental_Fee
	END
	CLOSE contractCursor
	DEALLOCATE contractCursor
END
GO

-- Stored Procedure fuer Nebenkosten
CREATE PROCEDURE dbo.gesamtbNebenkosten @nachnameMieter varchar(50), @jahr int
AS
BEGIN
	select (gesamtbetrag * (select Persons from Tenant where Last_Name = @nachnameMieter)) as Betrag, usage 
	from Nebenkosten_P_proPerson
	where Jahr = @jahr
	union
	select (gesamtbetrag * (select f.size from Flat as f join Contract as c on c.Contract_ID = f.Contract_ID join Tenant as t on t.Tenant_ID = c.Tenant_ID where Last_Name = @nachnameMieter)) as Betrag, usage 
	from Nebenkosten_Q_proQm
	where Jahr = @jahr
END
go
 
IF OBJECT_ID ('dbo.Nebenkosten_P_proPerson') IS NOT NULL
   DROP view dbo.Nebenkosten_P_proPerson
GO
 CREATE VIEW Nebenkosten_P_proPerson
 AS select (SUM(Amount)/(select SUM(persons) from Tenant as t join Contract as c on c.Tenant_ID = t.Tenant_ID where c.Property_ID = 1)) As Gesamtbetrag, Usage, YEAR(Value_Date) AS Jahr 
 from Utility_Cost 
 where Usage IN ('Strom', 'Grundsteuer', 'Wasser', 'Muell')
 group by Usage, YEAR(Value_Date)
 go

IF OBJECT_ID ('dbo.Nebenkosten_Q_proQm') IS NOT NULL
   DROP view dbo.Nebenkosten_Q_proQm
GO
 CREATE VIEW Nebenkosten_Q_proQm
 AS select (SUM(Amount)/(select SUM(f.size) from Flat as f join Contract as c on c.Contract_ID = f.Contract_ID where c.Property_ID = 1)) As Gesamtbetrag, Usage, YEAR(Value_Date) AS Jahr 
 from Utility_Cost 
 where Usage IN ('Heizkosten')
 group by Usage, YEAR(Value_Date)
 go
 
 IF OBJECT_ID ('dbo.gezahlteNebenkostenJeMieter') IS NOT NULL
   DROP view dbo.gezahlteNebenkostenJeMieter
GO
 CREATE VIEW gezahlteNebenkostenJeMieter
 AS 
 select sum(DATEDIFF(MONTH, Start_Date, End_Date)*Additional_Costs) as Gesamtbetrag, First_Name, Last_Name 
 from Contract as c join Tenant as t on t.Tenant_ID = c.Tenant_ID 
 group by First_Name, Last_Name
 go

 --DB mit Daten f�llen

insert into Tenant ( First_Name, Last_Name, IBAN, Persons)
values 
( 'Marcel', 'Mueller' , 'DE12312312312312312312', 2),
( 'Peter', 'Maier' , 'DE12312312312312312313', 3),
( 'Ingrid', 'Haug' , 'DE12312312312312312314', 4),
( 'Dietmar', 'Haefele' , 'DE12312312312312312315', 2),
( 'Petar', 'Koslowski' , 'DE12312312312312312316', 1),
( 'Luigi', 'Barni' , 'DE12312312312312312318', 1),
( 'Michael', 'Mann' , 'DE12312312312312312320', 5),
( 'Guenter', 'Gruner' , 'DE12312312312312312321', 2),
( 'Matthias', 'Stich' , 'DE12312312312312312322', 3),
( 'Phillip', 'Riester' , 'DE12312312312312312323', 1)
go


insert into Owner (First_Name, Last_Name, Phone_Number, Postal_Code, Address)
values ('Guenter', 'Grund', 01578456987, 73894, 'Teststrasse 14')
go

insert into Property (Owner_ID, Postal_Code, Address)
values (1, 75687 , 'Teststrasse 39')
go

insert into contract (Tenant_ID, Additional_Costs, Rental_Fee, Start_Date, End_Date, Property_ID)
values 
(1, 200, 650, '20210101', '20211231', 1),
(2, 100, 700, '20210101', '20211231', 1),
(3, 150, 550, '20210101', '20211231', 1),
(4, 200, 600, '20210101', '20211231', 1),
(5, 180, 550, '20210101', '20211231', 1),
(6, 250, 900, '20210101', '20211231', 1),
(7, 300, 700, '20210101', '20211231', 1),
(8, 100, 800, '20210101', '20211231', 1),
(9, 150, 1000, '20210101', '20211231', 1),
(10, 130, 800, '20210101', '20211231', 1),
(11, 110, 600, '20210101', '20211231', 1)
go

insert into flat (Address, Size, Contract_ID, Tenant_ID, Owner_ID)
values 
('Teststrasse 39', 80, 1, 1, 1),
('Teststrasse 39', 72, 2, 2, 1),
('Teststrasse 39', 65, 3, 3, 1),
('Teststrasse 39', 68, 4, 4, 1),
('Teststrasse 39', 120, 5, 5, 1),
('Teststrasse 39', 89, 6, 6, 1),
('Teststrasse 39', 98, 7, 7, 1),
('Teststrasse 39', 69, 8, 8, 1),
('Teststrasse 39', 75, 9, 9, 1),
('Teststrasse 39', 71, 10, 10, 1),
('Teststrasse 39', 87, 11, 11, 1)
go
