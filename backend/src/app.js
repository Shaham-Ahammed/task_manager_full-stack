import express from "express";
import cors from "cors";

const app = express();

app.use(express.json());
app.use(cors());

import taskRouter from "../src/routes/task.routes.js";

app.use("/api/tasks", taskRouter);

export default app;
