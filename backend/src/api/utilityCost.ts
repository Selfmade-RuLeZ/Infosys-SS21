import express from "express";
import database from "../database";

const router = express.Router();

router.get("/", async (req, res) => {
  await database
    .getUtilityCost()
    .then((utilityCosts: Utility_Cost[]) => {
      const formatedUtilityCost = utilityCosts.map((utilityCost) => {
        return {
          id: utilityCost.Utility_Cost_ID,
          bookingDate: utilityCost.Booking_Date.toLocaleDateString("de-DE"),
          valueDate: utilityCost.Value_Date.toLocaleDateString("de-DE"),
          Amount: utilityCost.Amount,
        };
      });
      res.send({ data: formatedUtilityCost });
    })
    .catch(() => {
      res.sendStatus(500);
    });
});

export default router;
