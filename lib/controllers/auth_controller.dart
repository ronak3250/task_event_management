import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
    loadUserUUID();  // Load the user UUID from SharedPreferences
  }

  Future<void> loginWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await saveUserUUID(_auth.currentUser?.uid);  // Save the UUID when logged in
      Get.offAllNamed('/events');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> signupWithEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await saveUserUUID(_auth.currentUser?.uid);  // Save the UUID after signing up
      Get.offAllNamed('/events');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      await saveUserUUID(_auth.currentUser?.uid);  // Save the UUID after Google login
      Get.offAllNamed('/events');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print('Google SignIn Error: $e');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await clearUserUUID();  // Clear the stored UUID on logout
    Get.offAllNamed('/');
  }

  // Method to save the user's UUID to SharedPreferences
  Future<void> saveUserUUID(String? uid) async {
    if (uid == null) return;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userUUID', uid);
  }

  // Method to load the user's UUID from SharedPreferences
  Future<void> loadUserUUID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userUUID = prefs.getString('userUUID');
    if (userUUID != null) {
      // Here you can perform any actions with the loaded UUID (e.g., sync user data)
      print('Loaded User UUID: $userUUID');
    }
  }

  // Method to clear the user's UUID from SharedPreferences
  Future<void> clearUserUUID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userUUID');
  }
}
