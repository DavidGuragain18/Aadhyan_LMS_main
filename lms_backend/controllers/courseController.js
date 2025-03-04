const Course = require("../models/courseModel")
const cloudinary = require("cloudinary")

const createCourse = async (req, res) => {
    const { name, description } = req.body;
    console.log(req.body)
    const {image} = req.files && req.image;

    if(!name || !description){
        return res.status(400).json({
            success: false,
            message: "Please Enter all Fields"
        })
    }
    try {
        const uploadedImage = await cloudinary.v2.uploader.upload(
            image.path,
            {
                folder: "course",
                crop: "scale"
            }
        )
        const courseExist = await Course.findOne({name: name})
        if(courseExist){
            return res.status(400).json({
                success: false,
                message: "Course Already Exist"
            })
        }
        const course = new Course({
            name: name,
            description: description,
            image: uploadedImage.secure_url
        })
        await course.save()
        return res.status(201).json({
            success: false,
            message: "Course Created Successfully",
            course
        })
        
    } catch (error) {
        console.log(`Error in create Course is ${error}`)
        return res.status(500).json({
            success: false,
            message: "Internal Server Error"
        }) 
    }
}

const getAllCourse = async(req, res) => {
    try {
        const allCourse = await Course.find()
        return res.status(201).json({
            success: true,
            message: "All Course",
            allCourse
        }) 
    } catch (error) {
        console.log(`Error in get All Course is ${error}`)
        return res.status(500).json({
            success: false,
            message: "Internal Server Error"
        }) 
    }
}

module.exports = {
    createCourse,
    getAllCourse
}