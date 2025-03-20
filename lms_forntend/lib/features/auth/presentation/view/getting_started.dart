import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_management_system/core/app_routes.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';

class GettingStarted extends StatelessWidget {
  const GettingStarted({super.key});

  final _gap = const SizedBox(
    height: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const ReusableText(
                  text: 'Getting Started',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: kButton),
              Container(
                height: 450,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/getting_started.png'))),
              ),
              _gap,
              const ReusableText(
                  text: 'Welcome to LearnEase',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              _gap,
              Container(
                width: 350,
                child: const ReusableText(
                  text:
                      'The ultimate Learning Management System (LMS) designed to simplify and enhance the educational experience.',
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                ),
              ),
              _gap,
              _gap,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(330, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: kButton),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.registerViewRoute);
                  },
                  child: const ReusableText(
                    text: 'Create an Account',
                    color: kLight,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
              _gap,
              OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(330, 50),
                    side: const BorderSide(color: kButton, width: 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                      Navigator.pushNamed(context, AppRoute.loginViewRoute);
                  },
                  child: const ReusableText(
                    text: 'Login',
                    color: kButton,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
