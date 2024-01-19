import 'package:ebook_app/Components/BookCard.dart';


import 'package:ebook_app/Components/BookTile.dart';


import 'package:ebook_app/Controller/BookController.dart';


import 'package:ebook_app/Pages/BookDetails/BookDetails.dart';


import 'package:ebook_app/Pages/HomePage/widgets/Appbar.dart';


import 'package:ebook_app/Pages/HomePage/widgets/CategoryWidget.dart';


import 'package:ebook_app/Pages/HomePage/widgets/MyInputTextField.dart';


import 'package:ebook_app/models/Data.dart';


import 'package:ebook_app/utils/color_utils.dart';


import 'package:flutter/material.dart';


import 'package:flutter_svg/svg.dart';


import 'package:get/get.dart';


import 'package:lottie/lottie.dart';


class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);


  @override

  Widget build(BuildContext context) {

    BookController bookController = Get.put(BookController());


    // Avoid calling functions that modify state during build


    WidgetsBinding.instance?.addPostFrameCallback((_) {

      bookController.getUserBook();

    });


    return Scaffold(

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

              height: 535,

              child: Column(

                children: [

                  SizedBox(height: 30),

                  HomeAppBar(),

                  SizedBox(height: 10),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Container(

                        height: 250,

                        width: 250,

                        child: Lottie.asset("Assets/Animation/Animation4.json"),

                      ),

                    ],

                  ),

                  MyInputTextField(),

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

                              iconPath: e["Icon"] ?? "",

                              btnName: e["label"]!,

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

                        "Trending",

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

                                  Get.to(BookDetails(book: e));

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

                                  (e) => BookTile(

                                    ontap: () {

                                      Get.to(BookDetails(book: e));

                                    },

                                    title: e.title!,

                                    coverUrl: e.coverUrl!,

                                    author: e.author!,

                                    rating: e.rating!,

                                    numberofRating: e.numberofRating ?? 0,

                                    pages: e.pages!,

                                    category: '',

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

