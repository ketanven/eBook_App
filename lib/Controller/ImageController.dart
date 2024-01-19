import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ImageController extends GetxController {
  final ImagePicker picker = ImagePicker();
  RxString imagePath = "".obs;
  RxBool isLoading = false.obs;

  void pickImageFormCamera() async {
    isLoading.value = true;
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      print(image.path);
      uploadImageToDatabase(File(image.path));
    } else {
      print("Image not Picked");
    }
  }

  void uploadImageToDatabase(File file) async {
    var uuid = Uuid();
    var fileName = uuid.v1();
    var storageRef = FirebaseStorage.instance.ref().child("File/$fileName");
    var uploadTask = storageRef.putFile(file);
    await uploadTask.whenComplete(() => null);
    print("Image");
    storageRef.getDownloadURL().then((value) {
      print(value);
      imagePath.value = value;
    });
    isLoading.value = false;
  }
}
