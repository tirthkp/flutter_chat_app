import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  final ImagePicker picker = ImagePicker();
  final store = FirebaseStorage.instance;
  final String userImage =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';

  Future<String> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.path;
    } else {
      return '';
    }
  }

  Future<String> uploadFileToFirebase(String imagePath) async {
    final path = "files/$imagePath";
    final file = File(imagePath);

    if (imagePath != '') {
      try {
        final ref = store.ref().child(path).putFile(file);
        final uploadTask = await ref.whenComplete(
          () {},
        );
        final downloadImageUrl = await uploadTask.ref.getDownloadURL();
        return downloadImageUrl;
      } catch (e) {
        return '';
      }
    }
    return '';
  }
}
