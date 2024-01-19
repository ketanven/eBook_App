import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/models/BookModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:uuid/uuid.dart';

class BookController extends GetxController {
  // Text controllers for various input fields
  TextEditingController title = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController auth = TextEditingController();
  TextEditingController auth2 = TextEditingController();
  TextEditingController aboutAuth = TextEditingController();
  TextEditingController pages = TextEditingController();
  TextEditingController language = TextEditingController();
  TextEditingController filepath = TextEditingController();
  TextEditingController category = TextEditingController();

  ImagePicker imagePicker = ImagePicker();
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;

  final fAuth = FirebaseAuth.instance;
  RxString selectedBookTitle = ''.obs;

  RxString imageUrl = "".obs;
  RxString pdfUrl = "".obs;
  int index = 0;
  bool isPdfUploaded = false;
  bool isImageUploaded = false;
  RxBool isImageUploading = false.obs;
  RxBool isPdfUploading = false.obs;
  RxBool isPostUploading = true.obs;
  // RxList<BookModel> bookData = <BookModel>[].obs;
  Rx<BookModel?> selectedBook = Rx<BookModel?>(null);

  var bookData = RxList<BookModel>();
  var currentUserBooks = RxList<BookModel>();

  @override
  void onInit() {
    super.onInit();
    getAllBooks();
  }

  void setSelectedBook(BookModel book) {
    selectedBook.value = book;
    selectedBookTitle.value = book.title ?? '';
  }

  void getAllBooks() async {
    bookData.clear();
    var books = await db.collection("Books").get();
    for (var book in books.docs) {
      bookData.add(BookModel.fromJson(book.data()));
    }
  }

  void getUserBook() async {
    currentUserBooks.clear();
    var books = await db
        .collection("Book Uploaded")
        .doc(fAuth.currentUser!.uid)
        .collection("Books")
        .get();
    for (var book in books.docs) {
      currentUserBooks.add(BookModel.fromJson(book.data()));
    }
  }

  void pickImage() async {
    isImageUploading.value = true;
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      uploadImageToFirebase(File(image.path));
      isImageUploaded = true;
    } else {
      // Display a snackbar if the image is not selected
      Get.snackbar('Error', 'Cover image not selected');
      // Stop the circular progress bar
      isImageUploading.value = false;
    }
  }

  void uploadImageToFirebase(File image) async {
    var uuid = Uuid();
    var filename = uuid.v1();
    var storageRef = storage.ref().child("Images/$filename");
    var response = await storageRef.putFile(image);
    String downloadURL = await storageRef.getDownloadURL();
    imageUrl.value = downloadURL;
    print("Download URL: $downloadURL");
    isImageUploading.value = false;
  }

  void createBook() async {
    try {
      isPostUploading.value = true;
      var newBook = BookModel(
        id: "$index",
        title: title.text,
        description: des.text,
        coverUrl: imageUrl.value,
        bookurl: pdfUrl.value,
        author: auth.text,
        // author1: auth2.text,
        aboutAuthor: aboutAuth.text,
        pages: int.parse(pages.text),
        language: language.text,
        rating: "",
      );

      await db.collection("Books").add(newBook.toJson());
      addBookInUserDb(newBook);
      isPostUploading.value = false;

      title.clear();
      des.clear();
      aboutAuth.clear();
      pages.clear();
      language.clear();
      auth.clear();
      auth2.clear();
      filepath.clear();
      category.clear();

      imageUrl.value = "";
      pdfUrl.value = "";

      print("Book added to the db");
    } catch (error) {
      print("Error adding book to the db: $error");
    }
    getAllBooks();
    getUserBook();
  }

  void pickPDF() async {
    isPdfUploading.value = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.first.path!);
      isPdfUploaded = true;

      if (file.existsSync()) {
        Uint8List fileBytes = await file.readAsBytes();
        String fileName = result.files.first.name;
        print("File Bytes: $fileBytes");

        final response =
            await storage.ref().child("Pdf/$fileName").putData(fileBytes);

        final downloadURL = await response.ref.getDownloadURL();
        pdfUrl.value = downloadURL;
        print(downloadURL);
      } else {
        print("File does not exist");
      }
    } else {
      print("No file selected");
    }
    isPdfUploading.value = false;
  }

  void addBookInUserDb(BookModel book) async {
    await db
        .collection("Book Uploaded")
        .doc(fAuth.currentUser!.uid)
        .collection("Books")
        .add(book.toJson());
  }
}
