import express from "express";
import uploadRoute from "./upload";

const router = express.Router();

router.use("/upload", uploadRoute);

export default router;
