const express = require('express');
const router = express.Router();
const BookController = require('../controllers/bookController');
const upload = require('../middleware/upload');

// Route to create a new book
router.post('/createbook', BookController.createBook);
router.post('/markcomplete/:userId/:bookId', BookController.markascomplete);
router.get('/completedbooks/:userId', BookController.getAllCompletedBooks);
router.get('/getallbook', BookController.getAllBook);
router.get('/books/level/:level/:id', BookController.getBookbyLevel);
router.get('/books/level/:level', BookController.getBooksByLevel);
router.get('/search/:userId/:courseId/:query', BookController.searchbook);


module.exports = router;
