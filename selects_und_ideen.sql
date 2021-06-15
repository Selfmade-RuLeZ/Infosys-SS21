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
/*select gesamtbetrag/(select SUM(persons) from Tenant as t join Contract as c on c.Tenant_ID = t.Tenant_ID where c.Property_ID = 1),usage, jahr 
from Berechnung_Gesamtposten
group by usage, gesamtbetrag, jahr*/

--select * from Nebenkosten_P_proPerson
--select * from Nebenkosten_Q_proQm
--select SUM(Amount), Usage from Utility_Cost group by Usage
exec gesamtbNebenkosten 'Maier', 2021

--select sum(DATEDIFF(MONTH, Start_Date, End_Date)*Additional_Costs), First_Name, Last_Name from Contract as c join Tenant as t on t.Tenant_ID = c.Tenant_ID group by First_Name, Last_Name
--update Contract set Start_Date = '20210101' where year(Start_Date) < 2021 
--delete from Contract
select * from gezahlteNebenkostenJeMieter where last_name = 'maier'
