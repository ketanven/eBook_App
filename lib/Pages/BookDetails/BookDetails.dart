import 'package:ebook_app/Components/BackButton.dart';
import 'package:ebook_app/Components/BookCard.dart';
import 'package:ebook_app/Controller/BookController.dart';
import 'package:ebook_app/Pages/BookDetails/BookActionBtn.dart';
import 'package:ebook_app/Pages/BookDetails/HeaderWidget.dart';
import 'package:ebook_app/models/BookModel.dart';
import 'package:ebook_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookDetails extends StatelessWidget {
  final BookModel book;
  const BookDetails({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookController controller = Get.put(BookController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section with book details
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
                  hexStringToColor("5E61F4"),
                  // hexStringToColor("5E61F4"),

                  hexStringToColor("9546C4"),
                ], center: Alignment.center),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  MyBackButton(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(width: 60),
                      Text(
                        book.title!,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      book.coverUrl!, // Assuming your BookModel has a coverUrl field
                      width: 150,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Details section
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pages",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    book.pages.toString(),
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Category",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    book.category.toString(),
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Author Name",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    book.author!,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 20),

                  Text(
                    "Ratings",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    book.rating!,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),

                  // Add more details as needed

                  SizedBox(height: 20),

                  Text(
                    "About Book",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    book.description!,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 20),

                  Text(
                    "About Author",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    book.aboutAuthor!,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Book action button
                  BookActionBtn(
                    bookUrl: book.bookurl!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
