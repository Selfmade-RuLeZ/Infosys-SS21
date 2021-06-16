import express from "express";
import uploadRoute from "./upload";
import tenantRoute from "./tenant";
import database from "../database";

const router = express.Router();

router.use("/upload", uploadRoute);

router.use("/tenants", tenantRoute);

export default router;
