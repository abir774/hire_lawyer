import 'package:flutter/cupertino.dart';

class RegisterController {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
   bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  String verifyInput() {
    String result ="";
    if(emailController.text.isEmpty || ! validateEmail(emailController.text)){
      result+="Veuillez verifier l'email";
    }
    else if(usernameController.text.isEmpty){
      result+="Veuillez verifier le nom de l'utilisateur";
    }
    else if(passwordController.text.isEmpty){
      result+= "Veuillez verifier le mot de passe ";
    }
    return result;
  }
}
