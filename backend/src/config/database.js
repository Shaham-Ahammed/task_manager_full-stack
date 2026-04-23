import mongoose from "mongoose";

const connectDb = async()=>{
    try {
     const connectionInstance =  await mongoose.connect(
        `${process.env.MONGODB_URI}`
     );
     console.log(`MONGODB connected successfully ${connectionInstance.connection.host}`);
      
    } catch (error) {
        console.log(`Error while setting up mongodb connection ${error}`);
        process.exit(1)
    }
}
export default connectDb