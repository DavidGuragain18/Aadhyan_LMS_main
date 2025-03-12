class ApiEndpoints {

  // ApiEndpoints._();

  //Connection Timeout 
  static const Duration connectionTimeout = Duration(seconds: 100);
  //Recieve Timeout 
  static const Duration recieveTimeout = Duration(seconds: 100);


  //For Windows Base URL
  // static const String baseUrl = 'http://10.0.2.2:5500/api/';
  // For MAC
  static const String baseUrl = "http://localhost:5500/api/";

  //Office
  // static const String baseUrl = "http://172.25.10.51:5500/api/";

  //Flat
  // static const String baseUrl = "http://192.168.1.67:5500/api/";

  //College wifi
  // static const String baseUrl = "http://10.12.13.104:5500/api/";

  static const String register = "/signup";
  static const String login = "/signin";
  static const String getProfile = "/profile";
  static const String updateProfile= "/update";
  static const String getAllCourse= "/getallcourse";
  static const String selectCourse= "/selectcourse";
  static const String getBeginnerBook= "/books/level/Beginner";
  static const String getEasyBook= "/books/level/Easy";
  static const String getMediumBook= "/books/level/Medium";
  static const String getHardBook= "/books/level/Hard";
  static const String getAdvanceBook= "/books/level/Advance";
  static const String searchBook= "/search";
  static const String getCompletedBook =  "/completedbooks";
  static const String markasComplete =  "/markcomplete";
}
