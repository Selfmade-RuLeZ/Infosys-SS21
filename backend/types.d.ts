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

interface Owner {
  Owner_ID: number;
  First_Name: string;
  Last_Name: string;
  Phone_Number: number;
  Postal_Code: number;
  Address: string;
}

interface Property {
  Property_ID: number;
  Owner_ID: number;
  Postal_Code: number;
  Address: string;
}

interface Utility_Cost {
  Utility_Cost_ID: number;
  Booking_Date: Date;
  Value_Date: Date;
  Amount: number;
  Usage: string;
}

interface Journal {
  Journal_ID: number;
  Booking_Date: Date;
  Value_Date: Date;
  Amount: number;
  Tenant_ID: number;
}

interface Position {
  Position_ID: number;
  Booking_Date: Date;
  Value_Date: Date;
  Booking_Text: string;
  Usage: string;
  Beneficiary: string;
  Amount: string;
}

interface PDFUser {
  Gesamtbetrag: number;
  First_Name: string;
  Last_Name: string;
  OffenerBetrag?: number;
  ZahlenderBetrag?: number;
  Address?: string;
  PostalCode?: number;
}

interface PDFUsage {
  Betrag: number;
  usage: string;
}

interface OpenRental {
  Tenant_ID: number;
  Offene_Posten: number;
  First_Name: string;
  Last_Name: string;
}
interface Address {
  Address: string;
  Postal_Code: number;
}

declare module "pdf-creator-node" {
  export function create(
    document: {
      html: string;
      data: {
        users: PDFUser[];
        usages: PDFUsage[];
      };
      path: string;
      type: string;
    },
    options: {
      format: string;
      orientation: string;
      border: string;
      header: {
        height: string;
        contents: string;
      };
      footer: {
        height: string;
        contents: {
          first: string;
          2: string;
          default: string;
          last: string;
        };
      };
    }
  ): Promise;
}
