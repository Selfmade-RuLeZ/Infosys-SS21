IF OBJECT_ID ('dbo.CSVImportTrigger') IS NOT NULL
   DROP trigger dbo.CSVImportTrigger
GO

CREATE TRIGGER [dbo].[CSVImportTrigger] ON [dbo].[Position] AFTER INSERT
AS
BEGIN
	DECLARE @tenantID int;
	DECLARE @beg�nstigter varchar(50);

	SELECT @beg�nstigter = Beneficiary from inserted;

	IF @beg�nstigter IN (select last_name from tenant)
	BEGIN
		SELECT @tenantID = tenant_id from tenant where last_name = @beg�nstigter;
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
	ELSE IF @beg�nstigter IN ('ENBW')
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
	ELSE IF @beg�nstigter IN ('HAUG GAS WASSER SCHUTT')
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
	ELSE IF @beg�nstigter IN ('FA ESSLINGEN')
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
	ELSE IF @beg�nstigter IN ('EVF')
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