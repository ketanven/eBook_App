import 'package:ebook_app/Components/BookManagerBookTile.dart';
import 'package:ebook_app/Controller/BookController.dart';
import 'package:ebook_app/Pages/BookDetails/BookDetails.dart';
import 'package:ebook_app/models/BookModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteBooksPage extends StatelessWidget {
  const DeleteBooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());

    return Scaffold(
      appBar: AppBar(
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
          ],
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: bookController.bookData.length,
          itemBuilder: (BuildContext context, int index) {
            final book = bookController.bookData[index];
            return BookManagerTile(
              onTap: () {
                Get.to(BookDetails(
                  book: book,
                ));
              },
              title: book.title!,
              coverUrl: book.coverUrl!,
              author: book.author!,
              rating: book.rating!,
              numberofRating: book.numberofRating ?? 0,
              pages: book.pages!,
              category: '',
              deleteBook: (String bookId, String coverUrl, String pdfUrl) {
                // Call the deleteBook function from BookController with necessary parameters
                bookController.deleteBook(
                  bookId as BookModel,
                  coverUrl,
                  pdfUrl,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
