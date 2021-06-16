import express from "express";
import uploadRoute from "./upload";
import tenantRoute from "./tenant";
import bkaRoute from "./betriebskostenabr";
import database from "../database";

const router = express.Router();

router.use("/upload", uploadRoute);

router.use("/tenants", tenantRoute);

router.use("/betriebskostenabrechnung", bkaRoute);

export default router;
