const router = require("express").Router()
const courseController = require("../controllers/courseController")
const auth = require("../middleware/authguard")

router.post("/createCourse", courseController.createCourse)
router.get("/getallcourse", courseController.getAllCourse)

module.exports = router