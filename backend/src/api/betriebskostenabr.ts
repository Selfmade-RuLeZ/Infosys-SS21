import express from "express";
import database from "../database";
import pdfCreator from "../pdfGeneration";

const router = express.Router();

router.get("/:name/:year", async (req, res) => {
  await database
    .getUtilityCostForUser(req.params.name, parseInt(req.params.year))
    .then(async (usages: PDFUsage[]) => {
      await database
        .getPaidUtilityCostForUser(req.params.name)
        .then((utilityCostFromUser: PDFUser[]) => {
          if (utilityCostFromUser.length < 1) {
            throw "Not found!";
          }
          utilityCostFromUser[0].OffenerBetrag = 0;
          utilityCostFromUser[0].ZahlenderBetrag = 0;
          usages.forEach((usage) => {
            utilityCostFromUser[0].ZahlenderBetrag! += Math.abs(usage.Betrag);
            usage.Betrag = parseFloat(usage.Betrag.toFixed(2));
          });
          utilityCostFromUser[0].OffenerBetrag =
            utilityCostFromUser[0].Gesamtbetrag -
            utilityCostFromUser[0].ZahlenderBetrag;
          utilityCostFromUser[0].Gesamtbetrag = parseFloat(
            utilityCostFromUser[0].Gesamtbetrag.toFixed(2)
          );
          utilityCostFromUser[0].OffenerBetrag = parseFloat(
            utilityCostFromUser[0].OffenerBetrag.toFixed(2)
          );
          utilityCostFromUser[0].ZahlenderBetrag = parseFloat(
            utilityCostFromUser[0].ZahlenderBetrag.toFixed(2)
          );
          pdfCreator.createPDF(utilityCostFromUser, usages).then((pdf) => {
            res.contentType("application/pdf");
            res.send(pdf);
          });
        });
    })
    .catch(() => {
      res.sendStatus(500);
    });
});

export default router;
