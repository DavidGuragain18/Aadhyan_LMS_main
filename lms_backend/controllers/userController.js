const User = require("../models/userModel");
const cloudinary = require("cloudinary");
const bcrypt = require("bcrypt")
const jwt = require("jsonwebtoken")
const Book = require("../models/bookModel")
const Course = require("../models/courseModel")
// const validate = require("deep-email-validator")


const signUp = async (req, res) => {
    console.log(req.body);
    const { fullName, email, userName, phoneNumber, password } = req.body;
    let image = req.files && req.files.image;

    if (!image) {
        image = { path: '' };
    } else if (!image.path) {
        console.error("Uploaded file does not have 'path' property:", image);
        return res.status(400).json({
            success: false,
            message: "Uploaded file is invalid"
        });
    }

    if (!fullName || !email || !userName || !phoneNumber || !password) {
        return res.status(400).json({
            success: false,
            message: "Please enter all fields"
        });
    }
    try {
        // Uploading image to cloudinary if image path is provided
        let uploadedImage = { secure_url: '' }; // default empty string for image URL

        if (image.path) {
            uploadedImage = await cloudinary.v2.uploader.upload(
                image.path,
                {
                    folder: "user",
                    crop: "scale"
                });
        }

        const userExist = await User.findOne({ email: email });
        if (userExist) {
            return res.status(400).json({
                success: false,
                message: "User Already Exist"
            });
        }
        const userNameExist = await User.findOne({ userName: userName });
        if (userNameExist) {
            return res.status(400).json({
                success: false,
                message: "UserName already taken"
            });
        }
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt)
        const userData = new User({
            fullName: fullName,
            email: email,
            userName: userName,
            phoneNumber: phoneNumber,
            password: hashedPassword,
            image: uploadedImage.secure_url,
            isAdmin: false
        });
        await userData.save();
        return res.status(200).json({
            success: true,
            message: "User Created Successfully",
            userData,
        });
    } catch (error) {
        console.error(error);
        return res.status(500).json({
            success: false,
            message: "Internal Server Error"
        });
    }
};

const signin = async (req, res) => {
    const { userName, password } = req.body;
    if (!userName || !password) {
        return res.status(400).json({
            success: false,
            message: "Please Enter all fields"
        });
    }
    try {
        const userData = await User.findOne({ userName: userName }).populate('selectedCourse').populate('bookCompleted');
        if (!userData) {
            return res.status(400).json({
                success: false,
                message: "Invalid Username"
            });
        }
        const checkDatabasePassword = userData.password;
        const isMatched = await bcrypt.compare(password, checkDatabasePassword);
        if (!isMatched) {
            return res.status(400).json({
                success: false,
                message: "Invalid Password"
            });
        }
        const payload = {
            id: userData._id,
            userName: userData.userName,
            email: userData.email,
            fullName: userData.fullName,
            phoneNumber: userData.phoneNumber,
            selectedCourse: userData.selectedCourse,
            image: userData.image
        };
        const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: "6hr" });

        // Check if user has selected a course
        if (!userData.selectedCourse || userData.selectedCourse.length === 0) {
            return res.status(200).json({
                success: false,
                token: token,
                userData,
                message: "Please select a course"
            });
        }

        const courseIds = userData.selectedCourse.map(course => course._id);
        console.log('Selected Course IDs:', courseIds);
        const books = await getBooksByCourse(courseIds);
        console.log('Books Fetched:', books);

        res.status(201).json({
            success: true,
            token: token,
            userData,
            books,
            message: "Login Successfully"
        });

    } catch (error) {
        console.log(error);
        return res.status(500).json({
            success: false,
            message: "Internal Server Error"
        });
    }
};

const getBooksByCourse = async (selectedCourseIds) => {
    try {
        const books = await Book.find({ 
            course: { $in: selectedCourseIds },
            level: { $in: ["Beginner", "Easy"] } 
         });
        return books; 
    } catch (error) {
        console.error(`Error fetching books: ${error}`);
        return []; 
    }
};

  
//User Profile 
const userProfile = async (req, res) => {
    try {
        const user = await User.findById(req.params.id).populate('selectedCourse')
        if (!user) {
            return res.status(400).json({
                success: false,
                message: "User Not Found"
            })
        }
        const books = await Book.find({ course: { $in: user.selectedCourse } });
        return res.status(201).json({
            success: true,
            user,
            books,
        })
    } catch (error) {
        console.log(error)
        return res.status(400).json({
            success: false,
            message: "Inernal Server Error"
        })
    }
}

const updateProfile = async (req, res) => {
    const { fullName, email, userName, phoneNumber, password } = req.body;
    const image = req.files && req.files.image;

    try {
        let updateProfile = {
            fullName,
            email,
            userName,
            phoneNumber
        };

        if (password) {
            const salt = await bcrypt.genSalt(10);
            updateProfile.password = await bcrypt.hash(password, salt);
        }

        if (image) {
            const uploadedImage = await cloudinary.v2.uploader.upload(
                image.path,
                {
                    folder: "lms/profile",
                    crop: "scale"
                }
            );
            updateProfile.image = uploadedImage.secure_url;
        }

        await User.findByIdAndUpdate(req.params.id, updateProfile, { new: true });

        res.json({
            success: true,
            updateProfile,
            message: "Update Successfully",
        });
    } catch (error) {
        console.error(`Error in updating profile: ${error}`);
        return res.status(500).json({
            success: false,
            message: "Internal Server Error"
        });
    }
};

const selectCourse = async (req, res) => {

    try {
        const { userId, courseId } = req.body;
        const user = await User.findByIdAndUpdate(
            userId,
            { $set: { selectedCourse: courseId } },
            { new: true }
        )
        const books = await getBooksByCourse(user.selectedCourse);
        res.status(201).json({
            success: true,
            user,
            books,
            message: "Course Selected"
        })

    } catch (error) {
        return res.status(500).json({ success: false, message: error.message });
    }
}



module.exports = {
    signUp, signin, userProfile, updateProfile, selectCourse
};
