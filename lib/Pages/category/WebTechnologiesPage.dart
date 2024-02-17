import 'package:ebook_app/Components/BookTile.dart';
import 'package:ebook_app/Controller/BookController.dart';
import 'package:ebook_app/Pages/BookDetails/BookDetails.dart';
import 'package:ebook_app/models/BookModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebTechnologyPage extends StatelessWidget {
  final String selectedCategory;

  final BookController bookController = Get.find();

  WebTechnologyPage({Key? key, required this.selectedCategory})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<BookModel> filteredBooks = bookController.bookData
        .where((book) => book.category == selectedCategory)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Web Technology Books"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: filteredBooks.length,
        itemBuilder: (context, index) {
          final book = filteredBooks[index];
          return BookTile(
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
            category: book.category!,
            ontap: () {},
            bookId: '',
          );
        },
      ),
    );
  }
}
