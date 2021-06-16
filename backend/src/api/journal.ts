import express from "express";
import database from "../database";

const router = express.Router();

router.get("/", async (req, res) => {
  await database
    .getJournal()
    .then((journal: Journal[]) => {
      const formatedPositions = journal.map((journalEntry) => {
        return {
          id: journalEntry.Journal_ID,
          bookingDate: journalEntry.Booking_Date.toLocaleDateString("de-DE"),
          valueDate: journalEntry.Value_Date.toLocaleDateString("de-DE"),
          Amount: journalEntry.Amount,
          tenantId: journalEntry.Tenant_ID,
        };
      });
      res.send({ data: formatedPositions });
    })
    .catch(() => {
      res.sendStatus(500);
    });
});

export default router;
