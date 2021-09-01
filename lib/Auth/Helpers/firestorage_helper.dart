import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FireStorageHelper {
  FireStorageHelper._();
  static FireStorageHelper fireStorageHelper = FireStorageHelper._();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImage(File file,
      [String folderName = 'profiles']) async {
    //-android/memory/aziz/gallery/camera/22-09-2020.jpg.
    //1* make a reference for this file in firebase storage
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    String path = 'images/profiles/$fileName';
    Reference reference = firebaseStorage.ref(path);
    //2* upload file to the defined reference
    await reference.putFile(file);
    //3* get the Url
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }
}
