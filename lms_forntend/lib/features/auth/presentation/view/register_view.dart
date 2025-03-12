import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/show_snack_bar.dart';
import 'package:learn_management_system/core/app_routes.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';
import 'package:learn_management_system/features/auth/presentation/view_model/auth_view_model.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _key = GlobalKey<FormState>();
  bool _obsecureText = true;
  bool _obsecureText1 = true;
  final _gap = const SizedBox(
    height: 15,
  );
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _userNameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = authViewModelProvider;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                const ReusableText(
                  text: 'Signup',
                  color: kDark,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 150),
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/signup_icon.png'))),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Full Name'),
                      Row(
                        children: [
                          const Icon(Icons
                              .supervised_user_circle_rounded), // Prefix Icon
                          const VerticalDivider(
                            thickness: 1,
                            color: kDark,
                          ), // Vertical Divider
                          Expanded(
                            child: TextFormField(
                              // key: const ValueKey('fullName'),
                              controller: _fullNameController,
                              decoration: const InputDecoration(
                                hintText: 'Please Enter your Full Name',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter FullName';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      _gap,
                      const Text('Email'),
                      Row(
                        children: [
                          const Icon(Icons.email_outlined), // Prefix Icon
                          const VerticalDivider(
                            thickness: 1,
                            color: kDark,
                          ), // Vertical Divider
                          Expanded(
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: 'Please Enter your Email',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter Email';
                                } else if (!value.contains('@')) {
                                  return 'please enter valid email';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      _gap,
                      const Text('Username'),
                      Row(
                        children: [
                          const Icon(Icons.verified_outlined), // Prefix Icon
                          const VerticalDivider(
                            thickness: 1,
                            color: kDark,
                          ), // Vertical Divider
                          Expanded(
                            child: TextFormField(
                              controller: _userNameController,
                              decoration: const InputDecoration(
                                hintText: 'UserName must be unique',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter UserName';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      _gap,
                      const Text('Phone Number'),
                      Row(
                        children: [
                          const Icon(Icons.phone), // Prefix Icon
                          const VerticalDivider(
                            thickness: 1,
                            color: kDark,
                          ), // Vertical Divider
                          Expanded(
                            child: TextFormField(
                              controller: _phoneNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                hintText: 'Please enter your Phone Number',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter PhoneNumber';
                                } else if (value.length < 10) {
                                  return 'please enter valid number';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      _gap,
                      const Text('Password'),
                      Row(
                        children: [
                          const Icon(Icons.password_outlined), // Prefix Icon
                          const VerticalDivider(
                            thickness: 1,
                            color: kDark,
                          ), // Vertical Divider
                          Expanded(
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obsecureText,
                              decoration: InputDecoration(
                                  hintText: 'Please Enter your password',
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obsecureText = !_obsecureText;
                                        });
                                      },
                                      child: Icon(_obsecureText
                                          ? Icons.visibility
                                          : Icons.visibility_off))),
                              validator: (value) {
                                final numericRegExp =
                                    RegExp(r'^(?=.*?[0-9]).{8,}$');
                                if (value!.isEmpty) {
                                  return 'please Enter Password';
                                } else if (value.length < 6) {
                                  return 'Password must contain 6 letters';
                                } else if (!numericRegExp.hasMatch(value)) {
                                  return 'Password must contain at least one numeric value';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      _gap,
                      const Text('Confirm Password'),
                      Row(
                        children: [
                          const Icon(Icons.password_outlined), // Prefix Icon
                          const VerticalDivider(
                            thickness: 1,
                            color: kDark,
                          ), // Vertical Divider
                          Expanded(
                            child: TextFormField(
                              controller: _confirmpasswordController,
                              obscureText: _obsecureText1,
                              decoration: InputDecoration(
                                  hintText: 'Please Enter confirm password',
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obsecureText1 = !_obsecureText1;
                                      });
                                    },
                                    child: Icon(_obsecureText1
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  )),
                              validator: (value) {
                                final numericRegExp =
                                    RegExp(r'^(?=.*?[0-9]).{8,}$');
                                if (value!.isEmpty) {
                                  return 'please Enter confirm Password';
                                } else if (value.length < 6) {
                                  return 'Password must contain 6 letters';
                                } else if (!numericRegExp.hasMatch(value)) {
                                  return 'Password must contain at least one numeric value';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      _gap,
                      _gap,
                    ],
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(330, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: kButton),
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        if (_passwordController.text !=
                            _confirmpasswordController.text) {
                          return showSnackBar(
                              message:
                                  'Passowrd do not match with confirm password',
                              context: context, color: Colors.red);
                        }else{
                              final userData = AuthEntity(
                            fullName: _fullNameController.text.trim(),
                            email: _emailController.text.trim(),
                            userName: _userNameController.text.trim(),
                            phoneNumber: _phoneNumberController.text.trim(),
                            password: _passwordController.text.trim());
                        ref
                            .read(authViewModelProvider.notifier)
                            .register(userData, context);
                        }
                      }
                    },
                    child: const ReusableText(
                      text: 'Create an Account',
                      color: kLight,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ReusableText(
                      text: 'Already have an account?',
                      color: kDark,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoute.loginViewRoute);
                      },
                      child: const ReusableText(
                        text: '  Login',
                        color: kButton,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
