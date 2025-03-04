const router = require('express').Router();
const userController = require('../controllers/userController')
// const auth = require("../middleware/authguard");

router.post('/signup', userController.signUp)
router.post('/signin',   userController.signin)
router.get('/profile/:id', userController.userProfile)
router.put('/update/:id', userController.updateProfile)
router.put('/selectcourse', userController.selectCourse)

module.exports = router