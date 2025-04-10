import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/show_snack_bar.dart';
import 'package:learn_management_system/core/app_routes.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';
import 'package:learn_management_system/features/auth/presentation/view_model/auth_view_model.dart';

class TeacherRegisterView extends ConsumerStatefulWidget {
  const TeacherRegisterView({super.key});

  @override
  ConsumerState<TeacherRegisterView> createState() =>
      _TeacherRegisterViewState();
}

class _TeacherRegisterViewState extends ConsumerState<TeacherRegisterView> {
  final _key = GlobalKey<FormState>();
  bool _obsecureText = true;
  bool _obsecureText1 = true;

  final _gap = const SizedBox(height: 15);

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
                  text: 'Teacher Signup',
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
                        image: AssetImage('assets/images/signup_icon.png'),
                      ),
                    ),
                  ),
                ),
                // Same form fields reused here (copy-paste from original RegisterView)
                _buildFormFields(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(330, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: kButton,
                  ),
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      if (_passwordController.text !=
                          _confirmpasswordController.text) {
                        return showSnackBar(
                          message: 'Passwords do not match',
                          context: context,
                          color: Colors.red,
                        );
                      } else {
                        final teacherData = AuthEntity(
                          fullName: _fullNameController.text.trim(),
                          email: _emailController.text.trim(),
                          userName: _userNameController.text.trim(),
                          phoneNumber: _phoneNumberController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                        ref
                            .read(authViewModelProvider.notifier)
                            .register(teacherData, context);
                      }
                    }
                  },
                  child: const ReusableText(
                    text: 'Create Teacher Account',
                    color: kLight,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ReusableText(
                      text: 'Already registered?',
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
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildField('Full Name', Icons.person, _fullNameController),
        _gap,
        _buildField('Email', Icons.email, _emailController, isEmail: true),
        _gap,
        _buildField('Username', Icons.verified, _userNameController),
        _gap,
        _buildField('Phone Number', Icons.phone, _phoneNumberController,
            isPhone: true),
        _gap,
        _buildPasswordField('Password', _passwordController, isFirst: true),
        _gap,
        _buildPasswordField('Confirm Password', _confirmpasswordController,
            isFirst: false),
        _gap,
        _gap,
      ],
    );
  }

  Widget _buildField(
      String label, IconData icon, TextEditingController controller,
      {bool isEmail = false, bool isPhone = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Row(
          children: [
            Icon(icon),
            const VerticalDivider(thickness: 1, color: kDark),
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: isEmail
                    ? TextInputType.emailAddress
                    : isPhone
                        ? TextInputType.phone
                        : TextInputType.text,
                decoration:
                    InputDecoration(hintText: 'Please enter your $label'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter $label';
                  }
                  if (isEmail && !value.contains('@')) {
                    return 'Enter a valid email';
                  }
                  if (isPhone && value.length < 10) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller,
      {required bool isFirst}) {
    bool isObscured = isFirst ? _obsecureText : _obsecureText1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Row(
          children: [
            const Icon(Icons.password_outlined),
            const VerticalDivider(thickness: 1, color: kDark),
            Expanded(
              child: TextFormField(
                controller: controller,
                obscureText: isObscured,
                decoration: InputDecoration(
                  hintText: 'Please enter your $label',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isFirst) {
                          _obsecureText = !_obsecureText;
                        } else {
                          _obsecureText1 = !_obsecureText1;
                        }
                      });
                    },
                    child: Icon(
                      isObscured ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                validator: (value) {
                  final numericRegExp = RegExp(r'^(?=.*?[0-9]).{8,}$');
                  if (value == null || value.isEmpty) {
                    return 'Please enter $label';
                  } else if (value.length < 6) {
                    return 'Password must contain at least 6 characters';
                  } else if (!numericRegExp.hasMatch(value)) {
                    return 'Password must contain a number';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
