import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  final String title;
  final String coverUrl;
  final String author;
  final String rating;
  final int numberofRating;
  final int pages;
  final String category;
  final String bookId;
  final Null Function() onTap; // Changed the name to ontap
  final Null Function() ontap; // Changed the name to ontap

  const BookTile({
    Key? key,
    required this.title,
    required this.coverUrl,
    required this.author,
    required this.rating,
    required this.numberofRating,
    required this.pages,
    required this.category,
    required this.bookId,
    required this.ontap,
    required this.onTap, // Updated the name to ontap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 185,
        padding: EdgeInsets.all(10),
        // margin: EdgeInsets.only(right: 10),
        child: Column(
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
                  rating as String,
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
      ),
    );
  }
}
