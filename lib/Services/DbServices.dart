import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hire_lawyer/Models/Users.dart';

class DbServices {
  var userCollection = FirebaseFirestore.instance.collection('users');

  saveUser(Cusers user)async{
   try{
     await   userCollection.doc(user.uid).set(user.Tojson());
   }catch(e){

   }
  }
}
