import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_lawyer/Login/ActionButton.dart';
import 'package:hire_lawyer/Login/DividerBox.dart';
import 'package:hire_lawyer/Login/FormFieldPassword.dart';
import 'package:hire_lawyer/Login/LoginFinal.dart';
import 'package:hire_lawyer/Login/emailFormField.dart';
import 'package:hire_lawyer/Services/AuthServices.dart';
import 'package:hire_lawyer/Services/StorageServices.dart';
import 'package:hire_lawyer/Values/Strings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'infoMessage.dart';
import 'nameFormField.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  Storage storage = Storage();
  TextEditingController emailController = TextEditingController();
  TextEditingController LastName = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  Widget SuffixPassword = Icon(Icons.visibility);
  bool obscureText = true;
  bool loading = false;
  File _image;
  bool check = false;
  String extension = "";
  bool hasConnection = false;

  Future getProfileImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    final imageTemporary = File(image.path);
    setState(() {
      _image = imageTemporary;
      check = true;
    });
  }

  String verifyInput() {
    String result = "";
    if (usernameController.text.isEmpty) {
      result += "Veuillez verifier le Nom ";
    } else if (LastName.text.isEmpty) {
      result += "Veuillez verifier le Prénom ";
    } else if (emailController.text.isEmpty ||
        !validateEmail(emailController.text)) {
      result += "Veuillez verifier l'email";
    } else if (passwordController.text.isEmpty) {
      result += "Veuillez verifier Le mot de passe ";
    } else if (_image == null) {
      result += "l'image est obligatoire ";
    }
    return result;
  }

  registerUserVerification(BuildContext context) async {
    setState(() {
      loading = false;
    });
    String str = verifyInput();
    hasConnection = await InternetConnectionChecker().hasConnection;
    if (str.isNotEmpty) {
      InfoMessage(
        message: str,
        press: () {
          Navigator.pop(context);

          setState(() {
            loading = false;
          });
        },
      ).show(context);
    } else if (hasConnection == true) {
      setState(() {
        loading = true;
      });
      var image = FirebaseStorage.instance.ref(_image.path);
      var task = image.putFile(_image);
      var imageurl = await (await task).ref.getDownloadURL();
      AuthServices().signUp(emailController.text, passwordController.text,
          usernameController.text, LastName.text, imageurl.toString());

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white24,
                Colors.blueGrey,
              ],
            ),
          ),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Login()));
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                      SizedBox(
                        width: size.width * 0.15,
                      ),
                      Text(
                        ConstStrings.CreateAccountLabel,
                        style: TextStyle(
                            fontSize: size.height * 0.028,
                            fontFamily: "NewsCycle-Bold"),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white38,
                            radius: 80,
                            backgroundImage: _image == null
                                ? AssetImage('assets/images/user.png')
                                : FileImage(_image),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                bottom: 10, end: 2),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: IconButton(
                                  onPressed: () {
                                    getProfileImage();
                                  },
                                  icon: Icon(
                                    Icons.add_photo_alternate_sharp,
                                    color: Colors.blueAccent,
                                    size: size.height * 0.05,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      DividerBox(
                        size: size,
                        height: 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: check == false
                                ? Row(
                                    children: [
                                      Text("Image pas encore selectionnée"),
                                      Icon(
                                        Icons.dangerous_outlined,
                                        color: Colors.red,
                                      )
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Text("Image bien selectionnée"),
                                      Icon(
                                        Icons.done_all,
                                        color: Colors.green,
                                      )
                                    ],
                                  ),
                          ),
                        ],
                      ),
                      DividerBox(
                        size: size,
                        height: 0.02,
                      ),
                      nameFormField(
                        size: size,
                        controller: usernameController,
                        preixIcon: Icons.account_circle_sharp,
                        hintText: "Nom",
                      ),
                      nameFormField(
                        size: size,
                        controller: LastName,
                        preixIcon: Icons.account_circle_sharp,
                        hintText: "Prénom",
                      ),
                      emailFormField(
                        size: size,
                        controller: emailController,
                        prefixIcon: Icons.email_outlined,
                      ),
                      FormFieldPassword(
                        size: size,
                        controller: passwordController,
                        preixIcon: Icons.lock_outline,
                        obscuretext: obscureText,
                        suffixIcon: IconButton(
                          icon: obscureText
                              ? SuffixPassword
                              : Icon(Icons.visibility_off),
                          color: obscureText ? Colors.blueAccent : Colors.white,
                          onPressed: () {
                            setState(() {
                              this.obscureText = !obscureText;
                            });
                          },
                        ),
                      ),
                      !loading
                          ? BuildLoginButton(size, ConstStrings.CreateAccount,
                              () {
                              registerUserVerification(context);
                            })
                          : CircularProgressIndicator.adaptive(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}
