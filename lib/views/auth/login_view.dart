import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/auth_controller.dart';
import '../../main.dart';
import '../../utils/widget/cmn_button.dart';
import '../../utils/widget/cmn_textfield.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;

  @override
  void initState() {
    requestPermission();
    // requestExactAlarmPermission();
    _checkIfUserIsLoggedIn();

    super.initState();
  }

  // Check if the user is logged in by looking for the UUID in SharedPreferences
  Future<void> _checkIfUserIsLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userUUID = prefs.getString('userUUID');

    if (userUUID != null) {
      // If UUID is found, redirect the user to the /events page
      Get.offAllNamed('/events');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6A11CB),
                Color(0xFF2575FC),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Login to continue',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: emailController,
                        hintText: 'abc@gmail.com',
                        prefixIcon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: passwordController,
                        hintText: '',
                        prefixIcon: Icons.lock,
                        isPassword: true,
                        isPasswordHidden: _isPasswordHidden,
                        togglePasswordVisibility: () {
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      Container(
                        height: 60,
                        width: 140,
                        child: Center(
                          child: CustomElevatedButton(
                            backgroundColor: Colors.green,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                authController.loginWithEmail(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                            text: 'Login',
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                Spacer(),
                CustomElevatedButton(
                  onPressed: authController.loginWithGoogle,
                  text: 'Sign in with Google',
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                TextButton(
                  onPressed: () => Get.toNamed('/signup'),
                  child: Text(
                    'Don\'t have an account? Sign Up',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
