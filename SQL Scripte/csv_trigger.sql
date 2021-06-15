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