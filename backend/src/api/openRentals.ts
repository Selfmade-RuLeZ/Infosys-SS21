import express from "express";
import database from "../database";

const router = express.Router();

router.get("/", async (req, res) => {
  await database
    .getOpenRentals()
    .then((openRentals: OpenRental[]) => {
      const formatedRentals = openRentals.map((openRental) => {
        return {
          id: openRental.Tenant_ID,
          amount: openRental.Offene_Posten,
          firstName: openRental.First_Name,
          lastName: openRental.Last_Name,
        };
      });
      res.send({ data: formatedRentals });
    })
    .catch(() => {
      res.sendStatus(500);
    });
});

export default router;
