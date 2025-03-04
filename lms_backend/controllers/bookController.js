const Book = require("../models/bookModel");
const User = require("../models/userModel");
const cloudinary = require("cloudinary");

const createBook = async (req, res) => {
    const { title, subtitle, description, courseId, image, level} = req.body;

    if (!title || !courseId || !level) {
        return res.status(400).json({ success: false, message: "Title, Course ID and Level are required" });
    }
    
    //validating Level
    const validLevels = ["Beginner", "Easy", "Medium", "Hard", "Advance"];
    if(!validLevels){
        
        return res.status(400).json({ success: false, message: "Invalid Level" });
    }

    try {
        let imageUrl;

        if (typeof image === 'string' && image.startsWith('http')) {
            // If image is a URL
            imageUrl = image;
        } else if (req.files && req.files.image) {
            // If image is a file, upload to Cloudinary
            const uploadedImage = await cloudinary.uploader.upload(req.files.image.path, {
                folder: "course",
                crop: "scale"
            });
            imageUrl = uploadedImage.secure_url;
        }

        // Check if book already exists
        const bookExist = await Book.findOne({ title });
        if (bookExist) {
            return res.status(400).json({
                success: false,
                message: "Book Already Exists",
            });
        }

        // Create a new book
        const newBook = new Book({
            title,
            subtitle,
            description,
            image: imageUrl || '', 
            course: courseId,
            level
        });

        // Save the book to the database
        await newBook.save();

        res.status(201).json({ success: true, book: newBook, message: "Book Created Successfully" });
    } catch (error) {
        console.log(`Error creating book: ${error}`);
        res.status(500).json({ success: false, message: error.message });
    }
};

const getBookbyLevel = async (req, res) => {
    const { level, id } = req.params; 

    const validLevels = ["Beginner", "Easy", "Medium", "Hard", "Advance"];
    if (!validLevels.includes(level)) {
        return res.status(400).json({ success: false, message: "Invalid Level" });
    }

    try {
        // Fetch user data to get selected course IDs
        const userData = await User.findById(id).populate('selectedCourse');
        if (!userData) {
            return res.status(404).json({ success: false, message: "User not found" });
        }

        // Extract course IDs from user data
        const courseIds = userData.selectedCourse.map(course => course._id);

        // Fetch books according to the level and course IDs
        const books = await Book.find({ level, course: { $in: courseIds } });

        if (books.length === 0) {
            return res.status(404).json({ success: false, message: `No books found for level '${level}' and user's courses` });
        }

        res.status(200).json({ success: true, books });
    } catch (error) {
        console.log(`Error fetching books by level: ${error}`);
        res.status(500).json({ success: false, message: error.message });
    }
};

const getBooksByLevel = async (req, res) => {
    const { level } = req.params; 

    const validLevels = ["Beginner", "Easy", "Medium", "Hard", "Advance"];
    if (!validLevels.includes(level)) {
        return res.status(400).json({ success: false, message: "Invalid Level" });
    }

    try {
        // Fetch books according to the level
        const books = await Book.find({ level });

        if (books.length === 0) {
            return res.status(404).json({ success: false, message: `No books found for level '${level}'` });
        }

        res.status(200).json({ success: true, books });
    } catch (error) {
        console.log(`Error fetching books by level: ${error}`);
        res.status(500).json({ success: false, message: error.message });
    }
};


const getAllBook =async (req, res) => {
    try {
        const book = await Book.find()
        res.status(200).json({ success: false, book, message: 'All Book Fetched Successfully' });
    } catch (error) {
        console.log(`Error fetching allbooks: ${error}`);
        res.status(500).json({ success: false, message: error.message });
    }

}

const searchbook = async (req, res) => {
    try {
        const { userId, courseId, query } = req.params; // Extract parameters from path

        // Validate parameters
        if (!userId || !courseId || !query) {
            return res.status(400).json({ success: false, error: 'User ID, Course ID, and query are required' });
        }

        // Fetch user data
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).json({ success: false, error: 'User not found' });
        }

        // Check if the course exists in the user's selected courses
        const selectedCourse = user.selectedCourse.find(course => course._id.toString() === courseId);
        if (!selectedCourse) {
            return res.status(404).json({ success: false, error: 'Selected course not found for this user' });
        }

        // Build the search query
        const searchQuery = {
            course: courseId,
            title: { $regex: query, $options: 'i' }, 
        };

        // Perform the search
        const books = await Book.find(searchQuery);

        // Respond with the results
        res.json({ success: true, books });
    } catch (err) {
        console.error(err);
        res.status(500).json({ success: false, error: 'Server error' });
    }
};

const markascomplete = async(req, res) => {
    try {
        const { userId, bookId } = req.params;

        // Find the user by ID
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).send('User not found');
        }

        const existingBook = user.bookCompleted.find(book => book.bookId === bookId);
        if(existingBook){
            return res.status(404).json({
                success: false,
                message: "Book already completed",
            });
        }

        // Check if the book is already in the bookCompleted list
        if (!user.bookCompleted.includes(bookId)) {
            user.bookCompleted.push(bookId);
            await user.save();
            return res.status(200).json({
                success: true,
                message: 'Book marked as completed'
            })
        } else {
            return res.status(400).json({
                success: false,
                message: 'Book already marked as completed'
            })
        }
    } catch (error) {
        console.error('Error marking book as completed:', error);
        res.status(500).send('Internal Server Error');
    }
}

const getAllCompletedBooks = async (req, res) => {
    try {
        const { userId } = req.params;

        // Find the user by ID
        const user = await User.findById(userId).populate('bookCompleted');
        if (!user) {
            return res.status(404).json({ success: false, message: 'User not found' });
        }

        // Get the completed books
        const completedBooks = user.bookCompleted;

        if (completedBooks.length === 0) {
            return res.status(404).json({ success: false, message: 'No completed books found for this user' });
        }

        res.status(200).json({ success: true, books: completedBooks, message: 'Completed books fetched successfully' });
    } catch (error) {
        console.error('Error fetching completed books:', error);
        res.status(500).json({ success: false, message: 'Internal Server Error' });
    }
};


module.exports = {
    createBook, getBookbyLevel, getAllBook, searchbook, getBooksByLevel, markascomplete,  getAllCompletedBooks
};
