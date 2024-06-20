import "reflect-metadata";
import express, { json } from "express";
import AppDataSource from "./config";
import { authRoutes } from "./auth/routes";
import cors from "cors";
import dotenv from "dotenv";



const app = express();
app.use(express.json());
const port = 3000;
app.use(
  cors({
    origin: "*",
  })
);

dotenv.config();

app.use("/api/v1/auth", authRoutes);



AppDataSource.initialize()
  .then(() => {
    app.listen(port, () => {
      console.log(`application is running on port ${port}.`);
    });
  })
  .catch((err: any) => console.log("error", err));
