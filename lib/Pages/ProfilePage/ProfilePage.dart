import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/Components/BackButton.dart';
import 'package:ebook_app/Components/BookTile.dart';
import 'package:ebook_app/Controller/BookController.dart';
import 'package:ebook_app/Pages/AddNewBook/AddNewBook.dart';
import 'package:ebook_app/Pages/WelcomePage.dart';
import 'package:ebook_app/utils/color_utils.dart';
import 'package:ebook_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage(
      {Key? key,
      required Null Function(dynamic imageUrl, dynamic imageBytes)
          onUpdateImage,
      String? imageUrl,
      Uint8List? imageBytes})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final BookController bookController = Get.put(BookController());
  ImagePicker _imagePicker = ImagePicker();
  String? _imageUrl;
  Uint8List? _image;
  String? _userEmail; // Add _userEmail variable here
  late User _user; // Declare user variable here

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    loadProfilePicture();
  }

  // Function to load the user's profile picture from Firestore
  Future<void> loadProfilePicture() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .get();
    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        setState(() {
          _imageUrl = data['profilePicUrl'];
          _userEmail = _user.email;
        });
      }
    }
  }

  // Function to select and upload image
  Future<void> selectImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List? imageBytes = await pickedFile.readAsBytes();

      setState(() {
        _image = imageBytes;
      });

      // Upload image to Firebase Storage
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child('${_user.uid}.jpg');
      UploadTask uploadTask = ref.putFile(File(pickedFile.path));
      TaskSnapshot storageTaskSnapshot =
          await uploadTask.whenComplete(() => null);
      String url = await storageTaskSnapshot.ref.getDownloadURL();

      // Save image URL to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .set({'profilePicUrl': url}, SetOptions(merge: true));

      // Set the profile picture URL in the state
      setState(() {
        _imageUrl = url;
        _userEmail = _user.email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddNewBook());
        },
        child: Icon(
          Icons.add,
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
                            Text(
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
                                  icon: Icon(
                                    Icons.login,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 60),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 64,
                                  backgroundImage: _image != null
                                      ? MemoryImage(_image!)
                                      : _imageUrl != null
                                          ? NetworkImage(_imageUrl!)
                                          : const NetworkImage(
                                                  'https://cdn-icons-png.flaticon.com/512/3682/3682281.png')
                                              as ImageProvider<Object>,
                                ),
                                Positioned(
                                  bottom: -10,
                                  left: 80,
                                  child: IconButton(
                                    onPressed: selectImage,
                                    icon: const Icon(Icons.add_a_photo),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          _userEmail != null
                              ? _userEmail!.substring(0, 5) +
                                  Random().nextInt(10).toString()
                              : "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                        ),
                        Text(
                          _userEmail ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
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
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Your Books",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500))
                    ],
                  ),
                  SizedBox(height: 20),
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
                                      onTap: () {},
                                      bookId: '',
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
