import dotenv from "dotenv";
import connectDb from "./config/database.js";
import app from "./app.js";

dotenv.config({ path: ".env" });

const startServer = async () => {
  try {
    await connectDb();
    app.on("error", (error) => {
      console.log("Errror", error);
      throw error;
    });
    app.listen(process.env.PORT || 8000,()=>{
        console.log('Server running on port'+process.env.PORT);
        
    })
  } catch (error) {
    console.log('ERROR WHILE STARTING THE SERVER',error);
    
  }
};

startServer()