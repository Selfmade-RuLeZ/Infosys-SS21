import express from "express";
import uploadRoute from "./upload";
import tenantRoute from "./tenant";
import bkaRoute from "./betriebskostenabr";
import contractRoute from "./contract";
import flatRoute from "./flat";
import ownerRoute from "./owner";
import propertyRoute from "./property";
import utilityCostRoute from "./utilityCost";
import journalRoute from "./journal";
import positionRoute from "./position";
import openRentalRoute from "./openRentals";

const router = express.Router();

router.use("/contract", contractRoute);

router.use("/flats", flatRoute);

router.use("/upload", uploadRoute);

router.use("/tenants", tenantRoute);

router.use("/owner", ownerRoute);

router.use("/property", propertyRoute);

router.use("/utilityCost", utilityCostRoute);

router.use("/journal", journalRoute);

router.use("/position", positionRoute);

router.use("/openRental", openRentalRoute);

router.use("/betriebskostenabrechnung", bkaRoute);

export default router;
