import mongoose, { Schema } from "mongoose";

const taskSchema = new Schema({
  title: {
    required: true,
    type: String,
    trim: true,
    maxlength: 20,
  },
  subTitle: {
    required: false,
    type: String,
    trim: true,
  },
  isCompleted: {
    required: false,
    type: Boolean,
  },
  image: {
    type: String, // we will be uploading the image to coudinary, getting the url and then storing the url in mongodb
    unique: true,
    required: true,
  },
},{
    timestamps:true
});

export const Task = mongoose.model("Task", taskSchema);
