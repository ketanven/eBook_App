import 'package:ebook_app/Pages/BookPage/BookPage.dart';
import 'package:ebook_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BookActionBtn extends StatelessWidget {
  final String bookUrl;
  const BookActionBtn({super.key, required this.bookUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
            colors: [hexStringToColor("CB2B93"), hexStringToColor("9546C4")],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.to(BookPage(
                bookUrl: bookUrl,
              ));
            },
            child: Row(
              children: [
                SvgPicture.asset("Assets/Icons/book.svg"),
                SizedBox(width: 10),
                Text(
                  "Read Book",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.3),
                ),
              ],
            ),
          ),
          Container(
            width: 2,
            height: 30,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10)),
          ),
          Row(
            children: [
              SvgPicture.asset("Assets/Icons/download.svg"),
              SizedBox(width: 10),
              Text(
                "Download",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1.3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
