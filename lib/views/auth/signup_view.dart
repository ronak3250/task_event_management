import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/widget/cmn_button.dart';
import '../../utils/widget/cmn_textfield.dart';

class SignupView extends StatefulWidget {
  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  final _signKey = GlobalKey<FormState>();

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
                SizedBox(height: 20),
                Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Sign up to get started',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 40),
                Form(
                  key: _signKey,
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
                        hintText: 'Password',
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
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: 140,
                  child: Center(
                    child: CustomElevatedButton(
                      backgroundColor: Colors.green,
                      onPressed: () {
                        if (_signKey.currentState!.validate()) {
                          authController.signupWithEmail(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                      text: 'Sign Up',
                    ),
                  ),
                ),
                Spacer(),

                TextButton(
                  onPressed: () => Get.offNamed('/'),
                  child: Text(
                    'Already have an account? Log In',
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
