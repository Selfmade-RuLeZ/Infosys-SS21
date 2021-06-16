import express from "express";
import database from "../database";
import pdfCreator from "../pdfGeneration";
import pdf from "html-pdf";
import fs from "fs";

const router = express.Router();

router.get("/:name/:year", async (req, res) => {
  await database
    .getUtilityCostForUser(req.params.name, parseInt(req.params.year))
    .then(async (usages: PDFUsage[]) => {
      await database
        .getPaidUtilityCostForUser(req.params.name)
        .then(async (utilityCostFromUser: PDFUser[]) => {
          if (utilityCostFromUser.length < 1) {
            throw "Not found!";
          }
          await database
            .getTenantAddress(req.params.name)
            .then((tenantAddress: Address) => {
              const utilityCostTenant = utilityCostFromUser[0];
              utilityCostTenant.Address = tenantAddress.Address;
              utilityCostTenant.PostalCode = tenantAddress.Postal_Code;
              utilityCostTenant.OffenerBetrag = 0;
              utilityCostTenant.ZahlenderBetrag = 0;
              usages.forEach((usage) => {
                utilityCostTenant.ZahlenderBetrag! += Math.abs(usage.Betrag);
                usage.Betrag = parseFloat(usage.Betrag.toFixed(2));
              });
              utilityCostTenant.OffenerBetrag =
                utilityCostTenant.Gesamtbetrag -
                utilityCostTenant.ZahlenderBetrag;
              utilityCostTenant.Gesamtbetrag = parseFloat(
                utilityCostTenant.Gesamtbetrag.toFixed(2)
              );
              utilityCostTenant.OffenerBetrag = parseFloat(
                utilityCostTenant.OffenerBetrag.toFixed(2)
              );
              utilityCostTenant.ZahlenderBetrag = parseFloat(
                utilityCostTenant.ZahlenderBetrag.toFixed(2)
              );
              pdfCreator.createPDF([utilityCostTenant], usages).then((pdf) => {
                res.contentType("application/pdf");
                res.send(pdf);
              });
            });
        });
    })
    .catch((err) => {
      console.log(err);
      res.sendStatus(500);
    });
});

export default router;
