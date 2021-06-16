import express from "express";
import fileUpload, { UploadedFile } from "express-fileupload";
import csv from "csv-parser";
import fs from "fs";
import database from "../database";

const router = express.Router();

router.use(
  fileUpload({
    useTempFiles: true,
    tempFileDir: "/tmp/",
  })
);

router.post("/bookings", async (req, res) => {
  if (req.files) {
    const bookings: Booking[] = [];
    const csvFile = <UploadedFile>req.files.bookings;
    fs.createReadStream(csvFile.tempFilePath)
      .pipe(
        csv({
          headers: [
            "Buchungstag",
            "Valutadatum",
            "Buchungstext",
            "Verwendungszweck",
            "Auftraggeber",
            "Betrag",
          ],
          mapValues: ({ header, value }) =>
            header == "Betrag"
              ? parseFloat(value.replace(".", "").replace(",", "."))
              : value,
          separator: ";",
        })
      )
      .on("data", (data) => bookings.push(data))
      .on("end", async () => {
        bookings.slice(1).forEach(async (booking) => {
          await database.insertBooking(booking);
        });
      });
    res.redirect("/");
  } else {
    res.send(500);
  }
});

export default router;
