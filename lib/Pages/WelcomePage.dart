import 'package:ebook_app/Pages/LoginPage.dart';
import 'package:ebook_app/Pages/RegisterPage.dart';
import 'package:ebook_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 400,
                height: 300,
                child: Lottie.asset("Assets/Animation/Animation2.json"),
              ),
              const SizedBox(height: 30),
              Text(
                "E-BOOK APP",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.background,
                    ),
              ),
              const SizedBox(height: 20),
              Flexible(
                child: Text(
                  "Here you can find the best book for you, and you can also read books offline",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(LoginPage());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 68),
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    primary: const Color.fromARGB(255, 208, 33, 243),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("LOGIN"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(Register());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    primary: const Color.fromARGB(255, 208, 33, 243),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("REGISTER"),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
