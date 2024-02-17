import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/Components/BackButton.dart';
import 'package:ebook_app/Controller/BookController.dart';
import 'package:ebook_app/Pages/BookDetails/BookActionBtn.dart';
import 'package:ebook_app/models/BookModel.dart';
import 'package:ebook_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookDetails extends StatelessWidget {
  final BookModel book;

  const BookDetails({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookController controller = Get.put(BookController());
    TextEditingController commentController = TextEditingController();
    double starRating = 0;
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
                  hexStringToColor("5E61F4"),
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
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Share.share(book.bookurl!);

                      // Handle share action
                    },
                    icon: Icon(Icons.share,
                        color: Theme.of(context).colorScheme.primary),
                    label: Text(
                      "Share",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 173, 243, 33),
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  // SizedBox(height: 20),
                  // _buildCommentBox(
                  //     context, commentController, starRating, userEmail),
                ],
              ),
            ),
            SizedBox(height: 10),
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
                  _buildCommentBox(
                      context, commentController, starRating, userEmail),
                  SizedBox(height: 20),
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

  Widget _buildCommentBox(
    BuildContext context,
    TextEditingController commentController,
    double starRating,
    String? userEmail,
  ) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Rating & Reviews",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          // Display user email
          Text(
            "${userEmail ?? 'Unknown'}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // SizedBox(height: 10),
          // _buildStarRating(starRating), // Build the star rating section
          SizedBox(height: 10),
          TextField(
            controller: commentController,
            maxLines: 3,
            maxLength: 250,
            decoration: InputDecoration(
              hintText: "Add your comment (Max 50 characters)",
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  commentController.clear();
                },
                child: Text("Clear"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Submit comment and rating
                  _submitComment(commentController.text, starRating);
                  // Clear the text field after submitting
                  commentController.clear();
                },
                child: Text("OK"),
              ),
            ],
          ),
          SizedBox(height: 10),
          // Placeholder for displaying submitted comments
          Text(
            "Latest Comments",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // Here you can display the submitted comments below
          // For demonstration, I'll just display the latest comment and rating
          _buildLatestComments(),
        ],
      ),
    );
  }

  Widget _buildStarRating(double starRating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        bool isSelected = index < starRating;
        return GestureDetector(
          onTap: () {
            // Update the star rating
            starRating = index + 1;
            // Rebuild the widget tree to reflect the changes
            Get.forceAppUpdate();
          },
          child: Icon(
            Icons.star,
            color: isSelected ? const Color.fromARGB(255, 59, 255, 62) : null,
          ),
        );
      }),
    );
  }

  Widget _buildUserCommentsBox(String userEmail, double starRating,
      String comment, String? currentUserEmail) {
    // List to store the color of stars
    List<Color> starColors = List.generate(5, (index) {
      // If the index is less than the starRating, color it yellow, else color it grey
      return index < starRating
          ? Colors.yellow
          : const Color.fromARGB(255, 168, 9, 9);
    });

    // Check if the current comment was made by the current user
    bool isCurrentUserComment = userEmail == currentUserEmail;

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.lightBlue[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Display user email
          Text(
            "${userEmail}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isCurrentUserComment ? Colors.green : Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display star rating here if needed
              ],
            ),
          ),
          SizedBox(height: 10),
          // Display user comment
          Text(
            "Comment: $comment",
          ),
        ],
      ),
    );
  }

  Widget _buildLatestComments() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Comments')
          .orderBy('timestamp', descending: true)
          .limit(20) // Limit to only show the latest 20 comments
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Or any other loading indicator
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No comments yet'); // Or any other placeholder text
        }

        // Retrieve current user's email
        String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;

        // Render the list of comments
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String userEmail = data['userEmail'] ?? '';
            double rating = data['rating'] ?? 0;
            String comment = data['comment'] ?? '';
            return _buildUserCommentsBox(
                userEmail, rating, comment, currentUserEmail);
          }).toList(),
        );
      },
    );
  }

  void _submitComment(String comment, double rating) async {
    try {
      // Check if the comment is empty
      if (comment.trim().isEmpty) {
        // Show a snackbar to prompt the user to add their comment
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Kindly add your comments')),
        );
        return; // Exit the method without submitting the comment
      }

      // Get the current user ID and email
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      String? userEmail = FirebaseAuth.instance.currentUser?.email;

      if (userId != null && userEmail != null) {
        // Ensure userEmail is not null
        // Create a new document in the 'Comments' collection
        await FirebaseFirestore.instance.collection('Comments').add({
          'userId': userId,
          'userEmail': userEmail,
          'comment': comment,
          'rating': rating,
          'timestamp': Timestamp.now(),
        });

        // Show a snackbar to indicate successful submission
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Comment submitted successfully')),
        );
      } else {
        // Handle case where user is not logged in or email is null
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Please log in to submit a comment')),
        );
      }
    } catch (e) {
      print("Error submitting comment: $e");
      // Show a snackbar to indicate submission failure
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Failed to submit comment')),
      );
    }
  }
}
