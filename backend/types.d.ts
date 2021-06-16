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
