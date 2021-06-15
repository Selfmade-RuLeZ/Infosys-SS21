-- View für Offene Zahlungen etc
CREATE VIEW Zahlungen_Mieter
 AS select SUM(j.Amount) As Sum, t.First_Name, t.Last_Name 
 from Journal as j 
 join Tenant as t 
 on t.Tenant_ID = j.Tenant_ID 
 group by t.First_Name, t.Last_Name;
 go
 
IF OBJECT_ID ('dbo.Nebenkosten_P_proPerson') IS NOT NULL
   DROP view dbo.Nebenkosten_P_proPerson
GO
 CREATE VIEW Nebenkosten_P_proPerson
 AS select (SUM(Amount)/(select SUM(persons) from Tenant as t join Contract as c on c.Tenant_ID = t.Tenant_ID where c.Property_ID = 1)) As Gesamtbetrag, Usage, YEAR(Value_Date) AS Jahr 
 from Utility_Cost 
 where Usage IN ('Strom', 'Grundsteuer')
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