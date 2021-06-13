IF OBJECT_ID ('dbo.CSVImportTrigger') IS NOT NULL   DROP trigger dbo.CSVImportTrigger
GO

CREATE TRIGGER [dbo].[CSVImportTrigger] ON [dbo].[Position] AFTER INSERT
AS
BEGIN
	DECLARE @tenantID int;
	DECLARE @begünstigter varchar(50);

	SELECT @begünstigter = Beneficiary from inserted;

	IF @begünstigter IN (select last_name from tenant)
	BEGIN
		SELECT @tenantID = tenant_id from tenant where last_name = @begünstigter;
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
	IF @begünstigter IN ('ENBW','STADT ESSLINGEN', 'HAUG GAS WASSER SCHUTT' )
	BEGIN
		INSERT INTO [dbo].[Utility_Cost]
			(
				[Booking_Date]
				,[Value_Date]
				,[Amount]
			)
		SELECT
			Booking_Date,
			Value_Date,
			Amount
		FROM inserted
	END
END