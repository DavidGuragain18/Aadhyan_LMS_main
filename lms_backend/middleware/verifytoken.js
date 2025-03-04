const jwt = require("jsonwebtoken")

const verifytoken = async (req, res) => {
    const token = req.header("Authorization")
    if (!token) {
        return res.status(401).json({
            success: false,
            message: "Access denied. No token provided.",
        });
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET)
        req.user = decoded
    } catch (error) {
        console.log(`Error on verifytoken is ${error}`)
        res.status(401).json({
            success: false,
            message: "Invalid token.",
        });
    }
}

module.exports = verifytoken
