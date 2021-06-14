--select * from journal as j join Tenant as t on j.Tenant_ID = t.Tenant_ID
--select * from Position
--select * from Contract
--select * from Journal
--select * from Property
--select * from Owner
--select * from Flat
--select * from Utility_Cost
--select * from Tenant
--select SUM(j.Amount), t.First_Name, t.Last_Name from Journal as j join Tenant as t on t.Tenant_ID = j.Tenant_ID group by t.First_Name, t.Last_Name;
--select Value_Date, j.Amount ,  t.First_Name, t.Last_Name from Journal as j join Tenant as t on t.Tenant_ID = j.Tenant_ID Where j.Tenant_ID = 3 Order by Value_Date;

-- Für eine Property (1) gesamt Personenanzahl
select SUM(persons) from Tenant as t join Contract as c on c.Tenant_ID = t.Tenant_ID where c.Property_ID = 1

--select SUM(Amount), Usage from Utility_Cost group by Usage