import { User } from "../models/task.model.js";

const createPost = async (req, res) => {
  try {
    const { title, subTitle } = req.body;
    // const imageFile = req.formData;
    const post = await User.create({
      title,
      subTitle,
      isCompleted: false,
      image: "",
    });
    return res
      .status(201)
      .json({ message: "task created successfully", id: post.id });
  } catch (error) {
    res.status(500).json({ message: "internal server error" });
  }
};

export { createPost };
