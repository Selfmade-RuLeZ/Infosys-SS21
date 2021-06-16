import express from "express";
import database from "../database";

const router = express.Router();

router.get("/", async (req, res) => {
  await database
    .getFlats()
    .then((flats: Flat[]) => {
      const formatedFlats = flats.map((flat) => {
        return {
          id: flat.Flat_ID,
          contractId: flat.Contract_ID,
          tenantId: flat.Tenant_ID,
          ownerId: flat.Owner_ID,
        };
      });
      res.send({ data: formatedFlats });
    })
    .catch(() => {
      res.sendStatus(500);
    });
});

export default router;
