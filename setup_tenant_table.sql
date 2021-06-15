insert into Tenant ( First_Name, Last_Name, IBAN, Persons)
values 
( 'Marcel', 'Mueller' , 'DE12312312312312312312', 2),
( 'Peter', 'Maier' , 'DE12312312312312312313', 3),
( 'Ingrid', 'Haug' , 'DE12312312312312312314', 4),
( 'Dietmar', 'Haefele' , 'DE12312312312312312315', 2),
( 'Petar', 'Koslowski' , 'DE12312312312312312316', 1),
( 'Dietmar', 'Haefele' , 'DE12312312312312312317', 2),
( 'Luigi', 'Barni' , 'DE12312312312312312318', 1),
( 'Michael', 'Mann' , 'DE12312312312312312320', 5),
( 'Guenter', 'Gruner' , 'DE12312312312312312321', 2),
( 'Matthias', 'Stich' , 'DE12312312312312312322', 3),
( 'Phillip', 'Riester' , 'DE12312312312312312323', 1)


insert into Owner (First_Name, Last_Name, Phone_Number, Postal_Code, Address)
values ('G¸nter', 'Grund', 01578456987, 73894, 'Teststraﬂe 14')

insert into Property (Owner_ID, Postal_Code, Address)
values (1, 75687 , 'Teststraﬂe 39')

insert into contract (Tenant_ID, Additional_Costs, Rental_Fee, Start_Date, End_Date, Property_ID)
values 
(1, 200, 650, '20210101', '20211231', 1),
(2, 100, 350, '20210101', '20211231', 1),
(3, 150, 450, '20210101', '20211231', 1),
(4, 200, 320, '20210101', '20211231', 1),
(5, 180, 220, '20210101', '20211231', 1),
(6, 250, 230, '20210101', '20211231', 1),
(7, 300, 310, '20210101', '20211231', 1),
(8, 100, 290, '20210101', '20211231', 1),
(9, 150, 120, '20210101', '20211231', 1),
(10, 130, 310, '20210101', '20211231', 1),
(11, 110, 280, '20210101', '20211231', 1)

insert into flat (Address, Size, Contract_ID, Tenant_ID, Owner_ID)
values 
('Teststraﬂe 39', 80, 1, 1, 1),
('Teststraﬂe 39', 72, 2, 2, 1),
('Teststraﬂe 39', 65, 3, 3, 1),
('Teststraﬂe 39', 68, 4, 4, 1),
('Teststraﬂe 39', 120, 5, 5, 1),
('Teststraﬂe 39', 89, 6, 6, 1),
('Teststraﬂe 39', 98, 7, 7, 1),
('Teststraﬂe 39', 69, 8, 8, 1),
('Teststraﬂe 39', 75, 9, 9, 1),
('Teststraﬂe 39', 71, 10, 10, 1),
('Teststraﬂe 39', 87, 11, 11, 1)