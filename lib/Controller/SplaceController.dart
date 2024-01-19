import 'package:ebook_app/Pages/HomePage/UserHomePage.dart';
import 'package:ebook_app/Pages/WelcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplaceController extends GetxController {
  final auth = FirebaseAuth.instance;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    splaceController();
  }

  void splaceController() {
    Future.delayed(Duration(seconds: 5), () {
      if (auth.currentUser != null) {
        Get.offAll(HomeScreen());
      } else {
        Get.offAll(WelcomePage());
      }
    });
  }
}
