import 'package:flutter/material.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';

class ChooseCourse extends StatelessWidget {
  const ChooseCourse({super.key});

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
                      children: [
                        Container(
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
                          // child: Text('asfjv'),
                        ),
                        Container(
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
                        ),
                        Container(
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
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
                        ),
                        Container(
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
                        ),
                        Container(
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(330, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: kButton),
                      onPressed: () {},
                      child: const ReusableText(
                        text: 'Start Learning Now',
                        color: kLight,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(330, 50),
                        side: const BorderSide(color: kButton, width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () {},
                      child: const ReusableText(
                        text: 'Not Now',
                        color: kButton,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              ),
            ),
          ),
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: kButton,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                            text: 'Choose your \n course to Start',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: kLight),
                      ],
                    ),
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
