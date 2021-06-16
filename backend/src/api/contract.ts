import express from "express";
import database from "../database";

const router = express.Router();

router.get("/", async (req, res) => {
  await database
    .getContracts()
    .then((contracts: Contract[]) => {
      const formatedContracts = contracts.map((contract) => {
        return {
          id: contract.Contract_ID,
          tenant_id: contract.Tenant_ID,
          additionalCosts: contract.Additional_Costs,
          rentalFee: contract.Rental_Fee,
          startDate: contract.Start_Date.toLocaleDateString("de-DE"),
          endDate: contract.End_Date.toLocaleDateString("de-DE"),
          propertyID: contract.Property_ID,
        };
      });
      res.send({ data: formatedContracts });
    })
    .catch(() => {
      res.sendStatus(500);
    });
});

export default router;
