import 'package:ebook_app/Pages/ProfilePage/ProfilePage.dart';
import 'package:ebook_app/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset("Assets/Icons/dashboard.svg"),
        const Text(
          "E-BOOK",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(ProfilePage());
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person_outline_rounded),
          ),
        ),

        // Text("homepage",)
      ],
    );
  }
}
