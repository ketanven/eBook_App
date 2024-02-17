// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BookManagerTile extends StatelessWidget {
  final String title;
  final String coverUrl;
  final String author;
  final String rating;
  final int numberofRating;
  final int pages;
  final String category;
  final String bookId;
  final VoidCallback onTap; // Changed the type to VoidCallback
  final Function(String, String, String) deleteBook;
  final String pdfUrl; // Added pdfUrl parameter

  const BookManagerTile({
    Key? key,
    required this.title,
    required this.coverUrl,
    required this.author,
    required this.rating,
    required this.numberofRating,
    required this.pages,
    required this.category,
    required this.onTap,
    required this.deleteBook,
    this.pdfUrl = '',
    this.bookId = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 185,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    coverUrl,
                    width: 150,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  author,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      rating,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Icon(
                      Icons.star,
                      size: 12,
                      color: Colors.amber,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '($numberofRating)',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle update button press
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 208, 33, 243),
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () {
                    // Show delete confirmation dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Delete Book"),
                          content: Text(
                              "Are you sure you want to delete this book?"),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                // Close the dialog
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                              ),
                              child: Text("No"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Call the deleteBook function with appropriate parameters
                                deleteBook(bookId, coverUrl, pdfUrl);
                                // Close the dialog
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 243, 93, 33),
                              ),
                              child: Text("Yes"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 243, 93, 33),
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
