CREATE TRIGGER [dbo].[OwnerJorunal] ON [dbo].[Contract] AFTER INSERT
AS
BEGIN
	DECLARE @tenantID INT;
	DECLARE @journalDate DATE;
	DECLARE @endDate DATE;
	DECLARE @additionalCost FLOAT;
	DECLARE @rentalFee FLOAT;

	SELECT @tenantID = Tenant_ID, @endDate = End_Date, @journalDate = Start_Date, 
		@additionalCost = Additional_Costs, @rentalFee = Rental_Fee FROM inserted;

	WHILE DATEADD(MONTH, 1, @journalDate) < @endDate
	BEGIN
		INSERT INTO [dbo].[Journal]
			(
				[Booking_Date]
				,[Value_Date]
				,[Amount]
				,[Tenant_ID]
			)
		VALUES
		(@journalDate, @journalDate, @additionalCost + @rentalFee, @tenantID)
		SET @journalDate = DATEADD(MONTH, 1, @journalDate)
	END
END