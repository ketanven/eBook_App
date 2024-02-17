import 'package:ebook_app/Components/BackButton.dart';
import 'package:ebook_app/Components/MultiLineTextFormField.dart';
import 'package:ebook_app/Components/MyTextFormField.dart';
import 'package:ebook_app/Controller/BookController.dart';
import 'package:ebook_app/config/color.dart';
import 'package:ebook_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Define a list of categories
List<String> categories = [
  'Programming Languages',
  'Computer Engineering Books',
  'Computer Science',
  'Data Science And Database',
  'Web Technologies',
];

class AddNewBook extends StatelessWidget {
  const AddNewBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookController bookController = Get.put(BookController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
                  hexStringToColor("5E61F4"),
                  hexStringToColor("5E61F4"),
                  hexStringToColor("9546C4"),
                ], center: Alignment.center),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyBackButton(),
                            const Text(
                              "Upload Your Books",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 70),
                          ],
                        ),
                        SizedBox(height: 60),
                        Container(
                          height: 190,
                          child: InkWell(
                            onTap: () {
                              bookController.pickImage();
                            },
                            child: Obx(
                              () => Container(
                                width: 135,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                                child: Center(
                                  child: bookController.isImageUploading.value
                                      ? CircularProgressIndicator(
                                          color: primaryColor,
                                        )
                                      : bookController.imageUrl.value.isEmpty
                                          ? Image.asset(
                                              "Assets/Icons/addImage.png")
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                bookController.imageUrl.value,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: bookController.pdfUrl.value.isEmpty
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: bookController.isPdfUploading.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: backgroundColor,
                              ),
                            )
                          : bookController.pdfUrl.value.isEmpty
                              ? InkWell(
                                  onTap: () {
                                    bookController.pickPDF();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.upload_sharp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background),
                                      SizedBox(width: 9),
                                      Text(
                                        "Upload PDF",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background),
                                      ),
                                    ],
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    bookController.pdfUrl.value = "";
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "Assets/Icons/delete.png",
                                        width: 20,
                                      ),
                                      SizedBox(width: 9),
                                      Text(
                                        "Delete PDF",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                    ),
                  ),
                  SizedBox(height: 20),
                  MyTextFormField(
                    labelText: "Book Title",
                    icon: Icons.book,
                    controller: bookController.title,
                  ),
                  SizedBox(height: 20),
                  MultiLineTextFormField(
                    labelText: "Description",
                    controller: bookController.des,
                  ),
                  SizedBox(height: 20),
                  MyTextFormField(
                    labelText: "Author Name 1",
                    icon: Icons.person,
                    controller: bookController.auth,
                  ),
                  SizedBox(height: 20),
                  MyTextFormField(
                    labelText: "Author Name 2(optional)",
                    icon: Icons.person,
                    controller: bookController.auth2,
                  ),
                  SizedBox(height: 20),
                  MyTextFormField(
                    labelText: "About Author",
                    icon: Icons.person,
                    controller: bookController.aboutAuth,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextFormField(
                          labelText: "Pages",
                          isNumber: true,
                          icon: Icons.pages_sharp,
                          controller: bookController.pages,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: MyTextFormField(
                          labelText: "LAN",
                          icon: Icons.language_rounded,
                          controller: bookController.language,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  MyTextFormField(
                    labelText: "File Path",
                    icon: Icons.file_copy,
                    controller: bookController.filepath,
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: bookController.category.text.isNotEmpty
                        ? bookController.category.text
                        : null,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      icon: Icon(Icons.category_rounded),
                      border: OutlineInputBorder(),
                    ),
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      bookController.category.text = newValue ?? '';
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 2,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          child: InkWell(
                            onTap: () {
                              // Cancel action
                              // You can add any custom logic here
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cancel,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                SizedBox(width: 8),
                                Text(
                                  "Cancel",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            onTap: () {
                              // Post action
                              bookController.createBook();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.post_add_rounded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                                SizedBox(width: 9),
                                Text(
                                  "Post",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
