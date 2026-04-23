import { Router } from "express";

const router = Router();

import { createPost } from "../controllers/task.controller.js";

router.route("/create-post").post(createPost);

export default router;
