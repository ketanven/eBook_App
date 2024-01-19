import 'package:ebook_app/Controller/BookController.dart';
import 'package:ebook_app/Controller/SplaceController.dart';
import 'package:ebook_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplacePage extends StatelessWidget {
  const SplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    SplaceController splaceController = Get.put(SplaceController());
    BookController bookController = Get.put(BookController());
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                hexStringToColor("5E61F4"),
                hexStringToColor("5E61F4"),
                hexStringToColor("CB2B93"),
                hexStringToColor("9546C4"),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(child: Lottie.asset("Assets/Animation/Animation.json")),
        ),
      ),
    );
  }
}
