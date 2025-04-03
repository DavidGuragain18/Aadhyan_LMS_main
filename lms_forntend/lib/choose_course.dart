import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/core/app_routes.dart';

class ChooseCourse extends StatelessWidget {
  const ChooseCourse({super.key});

  Future<void> _setUserSession(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('courseSelected', true);
    await prefs.setBool(
        'isLoggedIn', true); // Ensure the user remains logged in

    // Navigate directly to the Dashboard
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoute.dashboardViewRoute, // This should point to your Dashboard screen
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: kMilkLight,
            child: Padding(
              padding: const EdgeInsets.only(top: 280),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(3, (index) {
                        return Container(
                          width: 130.0,
                          height: 130.0,
                          decoration: const BoxDecoration(
                            color: kDark,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(3, (index) {
                        return Container(
                          width: 130.0,
                          height: 130.0,
                          decoration: const BoxDecoration(
                            color: kDark,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 100),

                  // 🟢 Start Learning Now Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(330, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: kButton,
                    ),
                    onPressed: () => _setUserSession(context),
                    child: const ReusableText(
                      text: 'Start Learning Now',
                      color: kLight,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🟢 Not Now Button
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(330, 50),
                      side: const BorderSide(color: kButton, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () => _setUserSession(context),
                    child: const ReusableText(
                      text: 'Not Now',
                      color: kButton,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🟢 Header Section
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: kButton,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: 'Choose your \n course to Start',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: kLight,
                      ),
                    ],
                  ),
                  Container(
                    width: 130.0,
                    height: 130.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
