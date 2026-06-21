import { Task } from "../models/task.model.js";
import cloudinary from "../config/cloudinary.js";

const createPost = async (req, res) => {
  try {
    const { title, subTitle } = req.body;
    const imageFile = req.file;
    if (!title) {
      return res.status(400).json({ message: "title is required" });
    }

    let imageUrl = "";

    if (imageFile) {
      const result = await cloudinary.uploader.upload(imageFile.path);
      console.log(result);
      imageUrl = result.url;
    } else {
      return res.status(400).json({ message: "please upload the image" });
    }

    const post = await Task.create({
      title,
      subTitle,
      isCompleted: false,
      image: imageUrl,
    });
    return res
      .status(201)
      .json({ message: "task created successfully", id: post.id });
  } catch (error) {
    res
      .status(500)
      .json({ message: "internal server error", error: error.message });
    console.log(`error ${error}`);
  }
};

const viewAllTasks = async (req, res) => {
  try {
    const { search, isCompleted } = req.query;
    let filter = {};
    if (search) {
      filter.$or = [
        // or is used if we can match multiple variables here we can either check its present in title or subtitle
        { title: { $regex: search, $options: "i" } }, // options ; "i" means it wont check case sensitive
        { subTitle: { $regex: search, $options: "i" } },
      ];
    }
    if (isCompleted != undefined) {
      filter.isCompleted = isCompleted;
    }
    const allTasks = await Task.find(filter).select(
      "_id title subTitle isCompleted image",
    );
    res
      .status(200)
      .json({ message: "tasks fetched successfully", tasks: allTasks });
  } catch (error) {
    res
      .status(500)
      .json({ message: "internal server error", error: error.message });
    console.log(`error ${error}`);
  }
};

const editTask = async (req, res) => {
  try {
    const { id, title, subTitle, isCompleted } = req.body;

    if (id) {
      let task = await Task.findById(id);
      if (task) {
        if (title !== undefined) task.title = title;
        if (subTitle !== undefined) task.subTitle = subTitle;
        const imageFile = req.file;
        if (imageFile) {
          let imageUrl = "";
          let uploadedImageResult = await cloudinary.uploader.upload(
            imageFile.path,
          );
          if (uploadedImageResult) {
            imageUrl = uploadedImageResult.url;
            task.image = imageUrl;
          } else {
            return res
              .status(400)
              .json({ message: "error while uploading image" });
          }
        }
        if (isCompleted !== undefined) {
          task.isCompleted = isCompleted;
        }
        await task.save();
        return res
          .status(200)
          .json({ message: "task updated successfully", task: task });
      } else {
        return res.status(404).json({ message: "task not found" });
      }
    } else {
      return res.status(400).json({ message: "id is required" });
    }
  } catch (error) {
    return res.status(500).json({
      message: "internal server error",
      error: error.message,
    });
  }
};

const deleteTask = async (req, res) => {
  try {
    const doc = await Task.findByIdAndDelete(req.params.id); // if we just id pass it as params

    // {{baseurl}}/delete-task/6a37a710f7046c26b107b736 so we can do like this in postman
    if (!doc) {
      return res.status(404).json({ message: "task not found" });
    }

    res.status(200).json({ message: "task deleted successfully" });
  } catch (error) {
    return res.status(500).json({
      message: "internal server error",
      error: error.message,
    });
  }
};

export { createPost, viewAllTasks, editTask, deleteTask };
