import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/Components/BookTile.dart';
import 'package:ebook_app/Controller/BookController.dart';
import 'package:ebook_app/Pages/BookDetails/BookDetails.dart';
import 'package:ebook_app/models/BookModel.dart';
import 'package:ebook_app/Pages/HomePage/widgets/MyInputTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchedBooksPage extends StatelessWidget {
  final String searchQuery;

  const SearchedBooksPage({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BookController()); // Instantiate the BookController

    return Scaffold(
      appBar: AppBar(
        title: Text("Searched Books"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Books')
            .where('title', isGreaterThanOrEqualTo: searchQuery)
            .where('title', isLessThan: searchQuery.substring(0, 1) + 'z')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No books found.'));
          }

          final List<DocumentSnapshot> books = snapshot.data!.docs;

          // Update the book data in the controller
          BookController.to.setBooks(
            books.map((e) => BookModel.fromSnapshot(e)).toList(),
          );

          return Obx(
            () => ListView.builder(
              itemCount: BookController.to.books.length,
              itemBuilder: (context, index) {
                final BookModel book = BookController.to.books[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(BookDetails(
                      book: book,
                    ));
                  },
                  child: BookTile(
                    title: book.title!,
                    coverUrl: book.coverUrl!,
                    author: book.author!,
                    rating: book.rating!,
                    numberofRating: book.numberofRating ?? 0,
                    pages: book.pages!,
                    category: '',
                    bookId: '',
                    onTap: () {
                      Get.to(BookDetails(
                        book: book,
                      ));
                    },
                    ontap: () {},
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
