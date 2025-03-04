const mongoose = require("mongoose")

const courseSchema = new mongoose.Schema({
    name:{
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    image: {
        type: String,
        required: false
    }
}, {timestamps: true})

const Course = mongoose.model("Course", courseSchema)
module.exports = Course