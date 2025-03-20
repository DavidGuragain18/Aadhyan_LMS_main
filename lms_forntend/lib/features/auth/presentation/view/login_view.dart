import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/core/app_routes.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/core/provider/flutter_secure_storage_provider.dart';
import 'package:learn_management_system/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final key = GlobalKey<FormState>();
  bool _obsecureText = true;
  bool? rememberMe = false;
  final _gap = const SizedBox(height: 15);
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final LocalAuthentication localAuthentication = LocalAuthentication();
  List<BiometricType> _availableBiometrics = [];
  bool _isBiometricLoginEnabled = false;
  bool _isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
    _checkBiometricAvailability();
    _loadBiometricLoginState();
  }

  Future<void> _loadBiometricLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isBiometricLoginEnabled = prefs.getBool('biometric_login') ?? false;
    });
  }

  Future<void> _loadSavedCredentials() async {
    final flutterSecureStorage = ref.read(flutterSecureStorageProvider);
    String? savedUserName = await flutterSecureStorage.read(key: 'userName');
    String? savedPassword = await flutterSecureStorage.read(key: 'password');

    if (savedUserName != null) {
      setState(() {
        _userNameController.text = savedUserName;
        rememberMe = true;
      });
    }

    if (savedPassword != null) {
      setState(() {
        _passwordController.text = savedPassword;
      });
    }
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> saveCredentials(String userName, String password) async {
    final flutterSecureStorage = ref.read(flutterSecureStorageProvider);
    await flutterSecureStorage.write(key: 'userName', value: userName);
    await flutterSecureStorage.write(key: 'password', value: password);
  }

  void _onRemembermeTapped(bool newValue) async {
    if (newValue) {
      if (_userNameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        await saveCredentials(
            _userNameController.text, _passwordController.text);
      }
    } else {
      final flutterSecureStorage = ref.read(flutterSecureStorageProvider);
      await flutterSecureStorage.delete(key: 'userName');
      await flutterSecureStorage.delete(key: 'password');
    }
    setState(() {
      rememberMe = newValue;
    });
  }

  Future<void> _checkBiometricAvailability() async {
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    List<BiometricType> availableBiometrics =
        await localAuthentication.getAvailableBiometrics();
    setState(() {
      _isBiometricAvailable = canCheckBiometrics;
      _availableBiometrics = availableBiometrics;
    });
  }

  String _getBiometricButtonText() {
    if (_availableBiometrics.contains(BiometricType.face)) {
      return 'Login with Face ID';
    } else if (_availableBiometrics.contains(BiometricType.fingerprint)) {
      return 'Login with Fingerprint';
    } else {
      return 'Login with Biometric';
    }
  }

  Future<void> getDataAfterLoginWithBiometric() async {
    final secureStorage = ref.read(flutterSecureStorageProvider);
    final username = await secureStorage.read(key: 'userName');
    final password = await secureStorage.read(key: 'password');
    if (username != null && password != null) {
      await ref
          .read(authViewModelProvider.notifier)
          .login(username, password, context);
      EasyLoading.showSuccess("Login Success");
      Navigator.pushNamed(context, AppRoute.bottomViewRoute);
    } else {
      EasyLoading.showError("Failed to Login");
    }
  }

  Future<void> _authenticateUser() async {
    bool isAuthenticated = await localAuthentication.authenticate(
      localizedReason: 'Authenticate to login',
    );
    if (isAuthenticated) {
      await getDataAfterLoginWithBiometric();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                children: [
                  const ReusableText(
                    text: 'Login',
                    color: kDark,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  _gap,
                  _gap,
                  _gap,
                  Padding(
                    padding: const EdgeInsets.only(left: 180),
                    child: Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/login_icon.png'),
                        ),
                      ),
                    ),
                  ),
                  _gap,
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Username'),
                        Row(
                          children: [
                            const Icon(Icons.verified_outlined),
                            const VerticalDivider(
                              thickness: 1,
                              color: kDark,
                            ),
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
                        const Text('Password'),
                        Row(
                          children: [
                            const Icon(Icons.password_outlined),
                            const VerticalDivider(
                              thickness: 1,
                              color: kDark,
                            ),
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
                                        : Icons.visibility_off),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe ?? false,
                              onChanged: (value) {
                                _onRemembermeTapped(value!);
                              },
                            ),
                            ReusableText(
                              text: 'Remember me',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: kButton,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(330, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: kButton,
                    ),
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        ref.read(authViewModelProvider.notifier).login(
                          _userNameController.text.trim(),
                          _passwordController.text.trim(),
                          context,
                        );
                      }
                    },
                    child: const ReusableText(
                      text: 'Login',
                      color: kLight,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // if (_isBiometricLoginEnabled &&
                  //     Platform.isAndroid &&
                  //     _isBiometricAvailable)
                    InkWell(
                      onTap: () async {
                        if (Platform.isAndroid || Platform.isIOS) {
                          await _authenticateUser();
                        } else {
                          EasyLoading.showError(
                            "Biometric authentication is not supported on this platform.",
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_getBiometricButtonText()),
                          const Icon(Icons.fingerprint),
                        ],
                      ),
                    ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.registerViewRoute,
                          );
                        },
                        child: const ReusableText(
                          text: 'Register',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kButton,
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
