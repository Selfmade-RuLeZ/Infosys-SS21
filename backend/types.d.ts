interface Booking {
  Buchungstag: string;
  Valutadatum: string;
  Buchungstext: string;
  Verwendungszweck: string;
  Auftraggeber: string;
  Betrag: string;
}

interface Tenant {
  Tenant_ID: number;
  First_Name: string;
  Last_Name: string;
  IBAN: string;
  Persons: number;
}

interface JSONTenant {
  name: string;
  lastName: string;
  iban: string;
  personen: number;
}

interface Contract {
  Contract_ID: number;
  Tenant_ID: number;
  Property_ID: number;
  Additional_Costs: number;
  Rental_Fee: number;
  Start_Date: Date;
  End_Date: Date;
}

interface Flat {
  Flat_ID: number;
  Address: string;
  Size: number;
  Contract_ID: number;
  Tenant_ID: number;
  Owner_ID: number;
}
