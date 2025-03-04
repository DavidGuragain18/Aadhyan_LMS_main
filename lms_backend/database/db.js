const mongoose = require('mongoose')
const env = require('dotenv')
env.config()

const DB = process.env.DB_URL

const connectDB = () => {
    mongoose.connect(process.env.DB_URL).then(()=> {
        console.log(`Database is connected to ${DB}`)
    })
}

module.exports = connectDB