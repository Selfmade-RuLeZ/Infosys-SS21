import express from "express";
import database from "../database";

const router = express.Router();

router.get("/", async (req, res) => {
  await database
    .getPositions()
    .then((positions: Position[]) => {
      const formatedPositions = positions.map((journalEntry) => {
        return {
          id: journalEntry.Position_ID,
          bookingDate: journalEntry.Booking_Date.toLocaleDateString("de-DE"),
          valueDate: journalEntry.Value_Date.toLocaleDateString("de-DE"),
          usage: journalEntry.Usage,
          amount: journalEntry.Amount,
        };
      });
      res.send({ data: formatedPositions });
    })
    .catch(() => {
      res.sendStatus(500);
    });
});

export default router;
