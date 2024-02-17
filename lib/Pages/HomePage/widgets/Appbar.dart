import 'dart:typed_data';

import 'package:ebook_app/Pages/ProfilePage/ProfilePage.dart';
import 'package:ebook_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? imageUrl;
  final Uint8List? imageBytes;

  const HomeAppBar({Key? key, this.imageUrl, this.imageBytes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // You can use a placeholder image if imageUrl and imageBytes are both null

    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "E-BOOK",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () {
                Get.to(ProfilePage(
                  imageUrl: imageUrl,
                  imageBytes: imageBytes,
                  onUpdateImage: (imageUrl, imageBytes) {
                    // Do nothing when image is updated from app bar
                  },
                ));
              },
              child: CircleAvatar(
                radius: 19,
                child: Icon(Icons.person),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
