import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/models/BookModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class BookController extends GetxController {
  static BookController get to => Get.find(); // Define the static getter

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
  RxList<BookModel> _books = <BookModel>[].obs;
  List<BookModel> get books => _books;

  RxString imageUrl = "".obs;
  RxString pdfUrl = "".obs;
  int index = 0;
  bool isPdfUploaded = false;
  bool isImageUploaded = false;
  RxBool isImageUploading = false.obs;
  RxBool isPdfUploading = false.obs;
  RxBool isPostUploading = true.obs;
  RxList<BookModel> bookData = <BookModel>[].obs;
  Rx<BookModel?> selectedBook = Rx<BookModel?>(null);

  var currentUserBooks = RxList<BookModel>();

  @override
  void onInit() {
    super.onInit();
    getAllBooks();
    // selectedBook.value = initialSelectedBook; // Initialize with some initial value if needed
  }

  List<BookModel> getBooksByCategory(String category, languages) {
    return bookData.where((book) => book.category == category).toList();
  }

  void setBooks(List<BookModel> books) {
    _books.assignAll(books);
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
      Get.snackbar('Done!', 'Cover image selected');
    } else {
      Get.snackbar('Error', 'Cover image not selected');
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
    Get.snackbar('Success', 'Cover image uploaded successfully');
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
        aboutAuthor: aboutAuth.text,
        pages: int.parse(pages.text),
        language: language.text,
        rating: "",
        category: '',
        numberofRating: null,
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
      Get.snackbar('Success', 'Book uploaded successfully');

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
        Get.snackbar('Success', 'PDF uploaded successfully');
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

  void deleteBook(BookModel book, String coverUrl, String pdfUrl) async {
    if (book.id != null && book.id!.isNotEmpty) {
      try {
        // Delete the book document from Firestore
        await FirebaseFirestore.instance
            .collection('Books')
            .doc(book.id)
            .delete();

        // Delete the cover image from Firebase Storage if the cover URL is not null
        if (book.coverUrl != null) {
          await FirebaseStorage.instance.refFromURL(book.coverUrl!).delete();
        }

        // Delete the PDF from Firebase Storage if the PDF URL is not null
        if (book.bookurl != null) {
          await FirebaseStorage.instance.refFromURL(book.bookurl!).delete();
        }

        // Show a snackbar or toast to indicate successful deletion
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Book deleted successfully')),
        );
      } catch (e) {
        print("Error deleting book: $e");
        // Handle error
        // Show a snackbar or toast to indicate deletion failure
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to delete book')),
        );
      }
    } else {
      print('Invalid book ID');
    }
  }
}
