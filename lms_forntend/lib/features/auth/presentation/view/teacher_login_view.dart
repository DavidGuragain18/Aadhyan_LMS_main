import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/config/common/show_snack_bar.dart';
import 'package:learn_management_system/core/app_routes.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';
import 'package:learn_management_system/features/auth/presentation/view_model/auth_view_model.dart';

class TeacherLoginView extends ConsumerStatefulWidget {
  const TeacherLoginView({super.key});

  @override
  ConsumerState<TeacherLoginView> createState() => _TeacherLoginViewState();
}

class _TeacherLoginViewState extends ConsumerState<TeacherLoginView> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = authViewModelProvider;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ReusableText(
                    text: 'Teacher Login',
                    color: kDark,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 150, top: 20),
                    child: Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/login_icon.png'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Username'),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.verified_user),
                      const VerticalDivider(thickness: 1, color: kDark),
                      Expanded(
                        child: TextFormField(
                          controller: _userNameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your Username',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Password'),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.lock_outline),
                      const VerticalDivider(thickness: 1, color: kDark),
                      Expanded(
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: 'Enter your Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(330, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: kButton,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final username = _userNameController.text.trim();
                        final password = _passwordController.text.trim();

                        ref
                            .read(authViewModelProvider.notifier)
                            .login(username, password, context);
                      }
                    },
                    child: const ReusableText(
                      text: 'Login as Teacher',
                      color: kLight,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ReusableText(
                        text: 'Don’t have a teacher account?',
                        color: kDark,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoute.teacherRegisterRoute);
                        },
                        child: const ReusableText(
                          text: '  Register',
                          color: kButton,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
