import sql from "mssql";

const sqlConfig = {
  user: process.env.DB_USER || "sa",
  password: process.env.DB_PASSWORD || "Password1!",
  database: process.env.DB_NAME || "infosys",
  server: process.env.DB_HOST || "localhost",
  port: 1433,
  pool: {
    max: 10,
    min: 0,
    idleTimeoutMillis: 30000,
  },
  options: {
    trustServerCertificate: true,
  },
};

export default {
  insertBooking: async (booking: Booking) => {
    const pool = new sql.ConnectionPool(sqlConfig);
    booking.Buchungstag =
      booking.Buchungstag.slice(6) +
      "" +
      booking.Buchungstag.slice(3, 5) +
      "" +
      booking.Buchungstag.slice(0, 2);
    booking.Valutadatum =
      booking.Valutadatum.slice(6) +
      "" +
      booking.Valutadatum.slice(3, 5) +
      "" +
      booking.Valutadatum.slice(0, 2);
    await pool
      .connect()
      .then(async () => {
        const request = new sql.Request(pool);
        await request.query(
          `insert into Position( Booking_Date, Value_Date, Booking_Text, Usage, Beneficiary, Amount) values ( '${booking.Buchungstag}', '${booking.Valutadatum}', '${booking.Buchungstext}','${booking.Verwendungszweck}', '${booking.Auftraggeber}', ${booking.Betrag});`
        );
      })
      .catch((error) => {
        console.error(
          `This query failed with this error: ${error}\nNext log shows the booking object`
        );
        console.error(booking);
      });
    pool.close();
  },
  getTenants: async () => {
    const pool = new sql.ConnectionPool(sqlConfig);
    const tenants = await pool
      .connect()
      .then(async () => {
        const request = new sql.Request(pool);
        const result = await request.query("select * from tenant");
        return result.recordset;
      })
      .catch((error) => {
        console.error(
          `There is an error occured in Function getTenants: ${error}`
        );
        throw error;
      });
    return tenants;
  },

  insertTenant: async (tenant: JSONTenant) => {
    const pool = new sql.ConnectionPool(sqlConfig);
    await pool
      .connect()
      .then(async () => {
        const request = new sql.Request(pool);
        await request.query(
          `insert into Tenant( First_Name, Last_Name, IBAN, Persons) values ( '${tenant.name}', '${tenant.lastName}', '${tenant.iban}',${tenant.personen});`
        );
      })
      .catch((error) => {
        console.error(
          `This query failed with this error: ${error}\nNext log shows the booking object`
        );
        console.error(tenant);
      });
    pool.close();
  },
  getContracts: async () => {
    const pool = new sql.ConnectionPool(sqlConfig);
    const contracts = await pool
      .connect()
      .then(async () => {
        const request = new sql.Request(pool);
        const result = await request.query("select * from contract");
        return result.recordset;
      })
      .catch((error) => {
        console.error(
          `There is an error occured in Function getContract: ${error}`
        );
        throw error;
      });
    return contracts;
  },
  getFlats: async () => {
    const pool = new sql.ConnectionPool(sqlConfig);
    const flats = await pool
      .connect()
      .then(async () => {
        const request = new sql.Request(pool);
        const result = await request.query("select * from flat");
        return result.recordset;
      })
      .catch((error) => {
        console.error(
          `There is an error occured in Function getFlats: ${error}`
        );
        throw error;
      });
    return flats;
  },
  getOwner: async () => {
    const pool = new sql.ConnectionPool(sqlConfig);
    const owner = await pool
      .connect()
      .then(async () => {
        const request = new sql.Request(pool);
        const result = await request.query("select * from owner");
        return result.recordset;
      })
      .catch((error) => {
        console.error(
          `There is an error occured in Function getOwner: ${error}`
        );
        throw error;
      });
    return owner;
  },
  getProperty: async () => {
    const pool = new sql.ConnectionPool(sqlConfig);
    const property = await pool
      .connect()
      .then(async () => {
        const request = new sql.Request(pool);
        const result = await request.query("select * from property");
        return result.recordset;
      })
      .catch((error) => {
        console.error(
          `There is an error occured in Function getProperty: ${error}`
        );
        throw error;
      });
    return property;
  },
  getUtilityCost: async () => {
    const pool = new sql.ConnectionPool(sqlConfig);
    const utilityCost = await pool
      .connect()
      .then(async () => {
        const request = new sql.Request(pool);
        const result = await request.query("select * from utility_cost");
        return result.recordset;
      })
      .catch((error) => {
        console.error(
          `There is an error occured in Function getUtilityCost: ${error}`
        );
        throw error;
      });
    return utilityCost;
  },
  getJournal: async () => {
    const pool = new sql.ConnectionPool(sqlConfig);
    const journal = await pool
      .connect()
      .then(async () => {
        const request = new sql.Request(pool);
        const result = await request.query("select * from journal");
        return result.recordset;
      })
      .catch((error) => {
        console.error(
          `There is an error occured in Function getJorunal: ${error}`
        );
        throw error;
      });
    return journal;
  },

  getPositions: async () => {
    const pool = new sql.ConnectionPool(sqlConfig);
    const positions = await pool
      .connect()
      .then(async () => {
        const request = new sql.Request(pool);
        const result = await request.query("select * from position");
        return result.recordset;
      })
      .catch((error) => {
        console.error(
          `There is an error occured in Function getPositions: ${error}`
        );
        throw error;
      });
    return positions;
  },
  getUtilityCostForUser: async (username: string, year: number) => {
    const pool = new sql.ConnectionPool(sqlConfig);
    const utilityCost = await pool
      .connect()
      .then(async () => {
        const request = new sql.Request(pool);
        const result = await request
          .input("nachnameMieter", sql.VarChar, username)
          .input("jahr", sql.Int, year)
          .execute("gesamtbNebenkosten");
        return result.recordset;
      })
      .catch((error) => {
        console.error(
          `There is an error occured in Function getUtilityCostForUser: ${error}`
        );
        throw error;
      });
    return utilityCost;
  },
  getPaidUtilityCostForUser: async (username: string) => {
    const pool = new sql.ConnectionPool(sqlConfig);
    const positions = await pool
      .connect()
      .then(async () => {
        const request = new sql.Request(pool);
        const result = await request.query(
          `select * from gezahlteNebenkostenJeMieter where Last_Name = '${username}'`
        );
        return result.recordset;
      })
      .catch((error) => {
        console.error(
          `There is an error occured in Function getPaidUtilityCostForUser: ${error}`
        );
        throw error;
      });
    return positions;
  },
  getOpenRentals: async () => {
    const pool = new sql.ConnectionPool(sqlConfig);
    const positions = await pool
      .connect()
      .then(async () => {
        const request = new sql.Request(pool);
        const result = await request.query(`select * from Zahlungen_Mieter`);
        return result.recordset;
      })
      .catch((error) => {
        console.error(
          `There is an error occured in Function getOpenRentals: ${error}`
        );
        throw error;
      });
    return positions;
  },
};
