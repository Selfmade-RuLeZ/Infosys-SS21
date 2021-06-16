import express from "express";
import uploadRoute from "./upload";
import database from '../database'

const router = express.Router();

router.use("/upload", uploadRoute);
router.get('/tenants', async (req, res) => {
    await database.getTenants()
    .then((tenants) => res.send(tenants))
    .catch(() => {
        res.sendStatus(500);
    });
    
}) 

export default router;
