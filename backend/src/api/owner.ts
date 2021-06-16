import express from "express";
import database from "../database";

const router = express.Router();

router.get("/", async (req, res) => {
  await database
    .getOwner()
    .then((owners: Owner[]) => {
      const formatedOwner = owners.map((owner) => {
        return {
          id: owner.Owner_ID,
          name: owner.First_Name,
          lastName: owner.Last_Name,
          phoneNumber: owner.Phone_Number,
          PostalCode: owner.Postal_Code,
          address: owner.Address,
        };
      });
      res.send({ data: formatedOwner });
    })
    .catch(() => {
      res.sendStatus(500);
    });
});

export default router;
