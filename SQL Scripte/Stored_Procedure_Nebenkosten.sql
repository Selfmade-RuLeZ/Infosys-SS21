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