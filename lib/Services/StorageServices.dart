import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class Storage{
  final firebase_storage.FirebaseStorage storage= firebase_storage.FirebaseStorage.instance;
 Future <void> uploadImage(String fileName,String filePath) async {
File file=File(filePath);
try{
await storage.ref('files/clients/$fileName').putFile(file);

}catch(e){
  print(e);
}
  }
}