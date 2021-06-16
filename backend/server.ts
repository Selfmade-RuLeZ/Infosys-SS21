import express from "express";
import apiRouter from "./src/api";

const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

app.use("/api", apiRouter);

app.use(express.static("public"));

app.listen(port, () => {
  console.log(`Infosys is listening on http://localhost:${port}`);
});
