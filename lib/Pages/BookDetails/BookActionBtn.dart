import 'package:ebook_app/Pages/BookPage/BookPage.dart';
import 'package:ebook_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class BookActionBtn extends StatelessWidget {
  final String bookUrl;

  const BookActionBtn({Key? key, required this.bookUrl}) : super(key: key);

  Future<void> _downloadBook() async {
    final response = await http.get(Uri.parse(bookUrl));

    if (response.statusCode == 200) {
      final directory = await getExternalStorageDirectory();
      final bookTitle = _extractBookTitle(bookUrl);
      final filePath = '${directory?.path}/$bookTitle.pdf';

      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      // Show SnackBar on successful download
      final snackBar = SnackBar(
        content: Text('Book downloaded successfully: $bookTitle.pdf'),
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    } else {
      // Handle the case when the download fails
      print('Failed to download the book');
    }
  }

  String _extractBookTitle(String url) {
    // Implement logic to extract book title from the URL or use a default title
    // For demonstration, we'll use a default title "Unknown Title"
    return 'Unknown Title';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
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
                    letterSpacing: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 2,
            height: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          InkWell(
            onTap: _downloadBook,
            child: Row(
              children: [
                SvgPicture.asset("Assets/Icons/download.svg"),
                SizedBox(width: 10),
                Text(
                  "Download",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
