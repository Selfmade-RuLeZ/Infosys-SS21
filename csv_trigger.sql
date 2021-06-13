IF OBJECT_ID ('dbo.CSVImportTrigger') IS NOT NULL   DROP trigger dbo.CSVImportTrigger
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
	IF @beg�nstigter IN ('ENBW','STADT ESSLINGEN', 'HAUG GAS WASSER SCHUTT' )
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