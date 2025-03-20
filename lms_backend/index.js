const express = require('express');
const env = require('dotenv');
const connectDB = require('./database/db');
const cloudinary = require('cloudinary').v2; // Ensure using v2
const acceptMultimedia = require('connect-multiparty');

const app = express();
app.use(express.json());

// Configuration for dotenv 
env.config();
connectDB();

// Cloudinary config
cloudinary.config({
    cloud_name: process.env.CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET
});

// For Uploading file 
app.use(acceptMultimedia());

const PORT = process.env.PORT || 5000;

app.get('/', (req, res) => {
    res.send('Hello, My name is Roshan Kumar Khadka');
});

app.use('/api', require('./routes/userRoute'));
app.use('/api', require('./routes/courseRoute'));
app.use('/api', require('./routes/bookRoutes'));

app.listen(PORT, () => {
    console.log(`Server is Running on port ${PORT}`);
});
