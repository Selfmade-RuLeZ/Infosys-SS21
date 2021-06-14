/*
-- View für Offene Zahlungen etc
CREATE VIEW Zahlungen_Mieter
 AS select SUM(j.Amount) As Sum, t.First_Name, t.Last_Name 
 from Journal as j 
 join Tenant as t 
 on t.Tenant_ID = j.Tenant_ID 
 group by t.First_Name, t.Last_Name;
 */

 CREATE VIEW Berechnung_Gesamtposten
 AS select SUM(Amount) As Gesamtbetrag, Usage from Utility_Cost group by Usage