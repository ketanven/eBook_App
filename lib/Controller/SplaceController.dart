import 'package:ebook_app/Pages/HomePage/AdminHomePage.dart';
import 'package:ebook_app/Pages/HomePage/BookMangerHomepage.dart';
import 'package:ebook_app/Pages/HomePage/UserHomePage.dart';

import 'package:ebook_app/Pages/WelcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    splashController();
  }

  void splashController() {
    Future.delayed(Duration(seconds: 2), () {
      if (_auth.currentUser != null) {
        // User is already signed in, redirect based on their role
        redirectBasedOnRole();
      } else {
        Get.offAll(WelcomePage());
      }
    });
  }

  void redirectBasedOnRole() {
    User? user = _auth.currentUser;
    if (user != null) {
      // Check the role of the user and redirect accordingly
      // For example, you may have a role field in your user document in Firestore
      // Here, I'm assuming you have a basic role check based on email
      if (user.email!.contains('bookmanager')) {
        Get.offAll(BookMangerHome());
      } else if (user.email!.contains('admin')) {
        Get.offAll(AdminHomePage());
      } else {
        Get.offAll(HomeScreen());
      }
    }
  }
}
