import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

Reference get firebaseStorage => FirebaseStorage.instance.ref();

class FirebaseStorageService extends GetxService {
  Future<String?> getImage(String? imgName) async {
    if (imgName == null) {
      return null;
    }
    try {
      if (kDebugMode) {
        print(imgName);
      }
      var urlRef = firebaseStorage
          .child("question_paper_images")
          .child('${imgName.toLowerCase()}.png');
      var imgUrl = await urlRef.getDownloadURL();
      if (kDebugMode) {
        print(imgUrl);
      }
      return imgUrl;
    } catch (e) {
      return null;
    }
  }
}
