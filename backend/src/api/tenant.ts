import express from "express";
import database from "../database";

const router = express.Router();

router.get("/", async (req, res) => {
  await database
    .getTenants()
    .then((tenants: Tenant[]) => {
      const formatedTenants = tenants.map((tenant) => {
        return {
          id: tenant.Tenant_ID,
          name: tenant.First_Name,
          lastName: tenant.Last_Name,
          iban: tenant.IBAN,
          personen: tenant.Persons,
        };
      });
      res.send({ data: formatedTenants });
    })
    .catch(() => {
      res.sendStatus(500);
    });
});

router.post("/", async (req, res) => {
  await database
    .insertTenant(req.body)
    .then(() => {
      res.sendStatus(200);
    })
    .catch(() => {
      res.sendStatus(500);
    });
});

export default router;
