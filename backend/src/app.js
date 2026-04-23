import express from "express";

const app = express();

app.use(express.json());

import taskRouter from "../src/routes/task.routes.js";

app.use("/api/tasks", taskRouter);

export default app;
