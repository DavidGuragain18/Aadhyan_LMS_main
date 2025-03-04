const mongoose = require("mongoose");

const bookSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    subtitle: {
        type: String,
    },
    description: {
        type: String
    },
    image: {
        type: String,
        require: false
    },
    course: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Course",
        required: true
    },
    level:{
        type: String,
        enum: ["Beginner", "Easy", "Medium", "Hard", "Advance"]
    }
});

const Book = mongoose.model('Book', bookSchema);
module.exports = Book;
