import { Router } from "express";
//multer is used for handling files and images
import multer from "multer";

const router = Router();

const upload = multer({ dest: "uploads/" }); //It tells Multer: “When a file is uploaded, save it temporarily in the uploads/ folder.”

import {
  createPost,
  deleteTask,
  editTask,
  viewAllTasks,
} from "../controllers/task.controller.js";

router.route("/create-task").post(upload.single("image"), createPost);

router.route("/edit-task").patch(upload.single("image"), editTask);

router.route("/get-all-tasks").get(viewAllTasks);

router.route("/delete-task/:id").delete(deleteTask);

export default router;
