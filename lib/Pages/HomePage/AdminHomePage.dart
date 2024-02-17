import 'package:ebook_app/Components/BookCard.dart';
import 'package:ebook_app/Components/BookTile.dart';
import 'package:ebook_app/Controller/BookController.dart';
import 'package:ebook_app/Pages/AddNewBook/AddNewBook.dart';
import 'package:ebook_app/Pages/BookDetails/BookDetails.dart';
import 'package:ebook_app/Pages/HomePage/widgets/Appbar.dart';
import 'package:ebook_app/Pages/HomePage/widgets/CategoryWidget.dart';
import 'package:ebook_app/Pages/HomePage/widgets/MyInputTextField.dart';
import 'package:ebook_app/Pages/ProfilePage/ProfilePage.dart';
import 'package:ebook_app/Pages/WelcomePage.dart';
import 'package:ebook_app/Pages/category/ComputerEngineeringPage.dart';
import 'package:ebook_app/Pages/category/ComputerSciencePage.dart';
import 'package:ebook_app/Pages/category/DataScienceAndDatabasePage.dart';
import 'package:ebook_app/Pages/category/ProrammingLanguagesPage.dart';
import 'package:ebook_app/Pages/category/WebTechnologiesPage.dart';

import 'package:ebook_app/models/Data.dart';
import 'package:ebook_app/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());

    // Avoid calling functions that modify state during build

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookController.getUserBook();
    });

    return Scaffold(
      // key: _scaffoldKey,
      appBar: HomeAppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    hexStringToColor("CB2B93"),
                    hexStringToColor("9546C4"),
                    hexStringToColor("5E61F4"),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Container(
                width: 100,
                height: 100,
                child: Lottie.asset("Assets/Animation/login.json"),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.person,
                      color: Theme.of(context).colorScheme.primary),
                  SizedBox(width: 9),
                  Text(
                    'My Profile',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(
                            onUpdateImage: (imageUrl, imageBytes) {},
                          )),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.upload,
                      color: Theme.of(context).colorScheme.primary),
                  SizedBox(width: 9),
                  Text(
                    'Upload Books',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewBook()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.arrow_circle_down_rounded,
                      color: Theme.of(context).colorScheme.primary),
                  SizedBox(width: 9),
                  Text(
                    'Topics',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewBook()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.book_rounded,
                      color: Theme.of(context).colorScheme.primary),
                  SizedBox(width: 9),
                  Text(
                    'Programming Language',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProgrammingLanguagesPage(
                            selectedCategory: ' ',
                          )),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.book_rounded,
                      color: Theme.of(context).colorScheme.primary),
                  SizedBox(width: 9),
                  Text(
                    'Computer Engineering',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ComputerEngineeringPage(
                            selectedCategory: ' ',
                          )),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.book_rounded,
                      color: Theme.of(context).colorScheme.primary),
                  SizedBox(width: 9),
                  Text(
                    'Computer Science',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ComputerSciencePage(
                            selectedCategory: ' ',
                          )),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.book_rounded,
                      color: Theme.of(context).colorScheme.primary),
                  SizedBox(width: 9),
                  Text(
                    'Data Science And Database',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DataScienceAndDatabasePage(
                            selectedCategory: ' ',
                          )),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.book_rounded,
                      color: Theme.of(context).colorScheme.primary),
                  SizedBox(width: 9),
                  Text(
                    'Web Technology',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebTechnologyPage(
                            selectedCategory: ' ',
                          )),
                );
              },
            ),
            SizedBox(height: 30),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.logout,
                      color: Theme.of(context).colorScheme.primary),
                  SizedBox(width: 13),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 240, 87, 138),
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    hexStringToColor("CB2B93"),
                    hexStringToColor("9546C4"),
                    hexStringToColor("5E61F4"),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              height: 270,
              child: Column(
                children: [
                  // SizedBox(height: 30),
                  // HomeAppBar(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          'Welcome Admin !!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  MyInputTextField(
                    onSubmitted: (String) {},
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Topics",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categoryData
                          .map(
                            (e) => CategoryWidget(
                              iconPath: e["Icon"] ??
                                  "", // Provide a default value if necessary

                              btnName: e["label"]!,
                              onTap: () {
                                // Navigate to the corresponding category page
                                if (e["label"] == "Programming Languages") {
                                  Get.to(ProgrammingLanguagesPage(
                                    selectedCategory: '',
                                  ));
                                } else if (e["label"] ==
                                    "Computer Engineering Books") {
                                  Get.to(ComputerEngineeringPage(
                                    selectedCategory: '',
                                  ));
                                } else if (e["label"] == "Computer Science") {
                                  Get.to(ComputerSciencePage(
                                    selectedCategory: '',
                                  ));
                                } else if (e["label"] ==
                                    "Data Science And Database") {
                                  Get.to(DataScienceAndDatabasePage(
                                    selectedCategory: '',
                                  ));
                                } else if (e["label"] == "Web Technologies") {
                                  Get.to(WebTechnologyPage(
                                    selectedCategory: '',
                                  ));
                                }
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "New Arrivals",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(
                      () => Row(
                        children: bookController.bookData
                            .map(
                              (e) => BookCard(
                                title: e.title!,
                                coverUrl: e.coverUrl!,
                                ontap: () {
                                  Get.to(BookDetails(
                                    book: e,
                                  ));
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Your Interests",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => Column(
                      children: List.generate(
                        (bookController.bookData.length / 2).ceil(),
                        (index) {
                          int startIndex = index * 2;
                          int endIndex = startIndex + 2;
                          if (endIndex > bookController.bookData.length) {
                            endIndex = bookController.bookData.length;
                          }
                          return Row(
                            children: bookController.bookData
                                .sublist(startIndex, endIndex)
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      // Navigate to BookDetails when the tile is tapped
                                      Get.to(BookDetails(book: e));
                                    },
                                    child: BookTile(
                                      title: e.title!,
                                      coverUrl: e.coverUrl!,
                                      author: e.author!,
                                      rating: e.rating!,
                                      numberofRating: e.numberofRating ?? 0,
                                      pages: e.pages!,
                                      category: '',
                                      onTap: () {
                                        Get.to(BookDetails(book: e));
                                      },
                                      bookId: '',
                                      ontap: () {},
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ).toList(),
                    ),
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
