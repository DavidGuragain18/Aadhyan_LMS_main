import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:learn_management_system/core/app_routes.dart';
import 'package:learn_management_system/config/common/app_color.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoute.loginViewRoute,
      routes: AppRoute.getApplicationRoute(),
      theme:
          ThemeData(fontFamily: 'Poppins', scaffoldBackgroundColor: kMilkLight),
          builder: EasyLoading.init(),
    );
  }
}
