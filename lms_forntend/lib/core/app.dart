import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:learn_management_system/core/app_routes.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initialRoute = AppRoute.loginViewRoute; // Default to login

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    bool courseSelected = prefs.getBool('courseSelected') ?? false;

    setState(() {
      initialRoute = isLoggedIn
          ? (courseSelected
              ? AppRoute.dashboardViewRoute
              : AppRoute.chooseCourseRoute)
          : AppRoute.loginViewRoute; // Navigate to login if not logged in
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Management System',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: kMilkLight,
      ),
      initialRoute: initialRoute, // 🟢 Dynamically sets the route
      routes: AppRoute.getApplicationRoute(),
      builder: EasyLoading.init(),
    );
  }
}
