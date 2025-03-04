const mongoose = require('mongoose')
const userSchema = new mongoose.Schema({
    fullName: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
    },
    userName: {
        type: String,
        required: true
    },
    phoneNumber: {
        type: String,
        required: true
    },
    password: {
        type: String,
        required: true
    },
    isAdmin: {
        type: Boolean,
        default: false
    },
    selectedCourse: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "Course"
    }],
    bookCompleted: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "Book"
    }],
    image: {
        type: String,
        required: false
    }
}, { timestamps: true });

const User = mongoose.model('user', userSchema)
module.exports = User;
