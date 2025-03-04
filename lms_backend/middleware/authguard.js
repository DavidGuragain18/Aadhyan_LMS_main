const jwt = require("jsonwebtoken")
const User = require("../models/userModel")


const isAdmin = async (req, res) => {
    try {
        const authHeader = req.headers.authorization;
        if (!authHeader) {
            return res.status(401).json({
                success: false,
                message: "Authorization header missing!",
            });
        }
        //Now spilit auth header and get token 
        const token = authHeader.split(" ")[1];
        if (!token) {
            return res.status(401).json({
              success: false,
              message: "Token missing!",
            });
          }

          //Now decode the token 
          const decodedData = jwt.verify(token, process.env.JWT_SECRET);
          req.user = decodedData;
          if(!req.user.isAdmin){
            return res.status(403).json({
                success: false,
                message: "Permission denied!..you must be admin",
              });
          }

          //If not the allow admin access
    } catch (error) {
        res.status(401).json({
            success: false,
            message: error.message,
        });
    }
}

module.exports = {
    isAdmin
}

