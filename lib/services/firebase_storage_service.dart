import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

Reference get firebaseStorage => FirebaseStorage.instance.ref();

class FirebaseStorageService extends GetxService{
  getImage(String? imgName){
    return null;
  }
  // try{
  //   firebaseStorage.child("")
  // }catch(e){
  //   return null;
  // }
}