import express from "express";
import database from "../database";

const router = express.Router();

router.get("/", async (req, res) => {
  await database
    .getProperty()
    .then((properties: Property[]) => {
      const formatedOwner = properties.map((property) => {
        return {
          id: property.Property_ID,
          ownerId: property.Owner_ID,
          postalCode: property.Postal_Code,
          address: property.Address,
        };
      });
      res.send({ data: formatedOwner });
    })
    .catch(() => {
      res.sendStatus(500);
    });
});

export default router;
