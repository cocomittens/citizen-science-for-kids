import dotenv from "dotenv";
dotenv.config();

import express from "express";
import authRoutes from "./routes/auth";
import projectRoutes from "./routes/projectRoutes";

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.get("/", (req, res) => {
  res.send("API is running");
});

app.use("/api/auth", authRoutes);
app.use("/api/projects", projectRoutes);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
