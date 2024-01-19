import 'package:ebook_app/Components/BackButton.dart';
import 'package:ebook_app/Components/BookTile.dart';
import 'package:ebook_app/Controller/BookController.dart';
import 'package:ebook_app/Pages/AddNewBook/AddNewBook.dart';
import 'package:ebook_app/Pages/WelcomePage.dart';
import 'package:ebook_app/models/Data.dart';
import 'package:ebook_app/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddNewBook());
        },
        child: Icon(
          Icons.add,
          // color: Theme.of(context).colorScheme.background,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
                  hexStringToColor("5E61F4"),
                  hexStringToColor("5E61F4"),
                  // hexStringToColor("CB2B93"),
                  hexStringToColor("9546C4")
                ], center: Alignment.center),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyBackButton(),
                            SizedBox(height: 5),
                            const Text(
                              "Profile",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(width: 40),
                                IconButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WelcomePage(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.login,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 60),
                        Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: LinearGradient(
                              colors: [
                                hexStringToColor("9546C4"),
                                hexStringToColor("CB2B93"),
                                // hexStringToColor("5E61F4"),
                              ],
                              end: Alignment.bottomCenter,
                            ),
                            border: Border.all(
                              width: 2,
                            ),
                          ),
                          child: Container(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "Assets/Images/Python.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Ketan Pillai",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                        ),
                        Text(
                          "ketan@gmail.com",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Your Books",
                          style: Theme.of(context).textTheme.labelLarge)
                    ],
                  ),
                  SizedBox(height: 20),
                  // Inside your Obx block
                  Obx(
                    () => Column(
                      children: List.generate(
                        (bookController.currentUserBooks.length / 2).ceil(),
                        (index) {
                          int startIndex = index * 2;
                          int endIndex = startIndex + 2;
                          if (endIndex >
                              bookController.currentUserBooks.length) {
                            endIndex = bookController.currentUserBooks.length;
                          }

                          return Row(
                            children: bookController.currentUserBooks
                                .sublist(startIndex, endIndex)
                                .map(
                                  (e) => Expanded(
                                    child: BookTile(
                                      title: e.title!,
                                      coverUrl: e.coverUrl!,
                                      author: e.author!,
                                      rating: e.rating!,
                                      numberofRating: e.numberofRating ?? 0,
                                      ontap: () {},
                                      category: e.category.toString(),
                                      pages: e.pages ?? 0,
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
