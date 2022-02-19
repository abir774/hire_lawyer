import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hire_lawyer/Login/DividerBox.dart';
import 'package:hire_lawyer/Login/LoginFinal.dart';
import 'package:hire_lawyer/Login/remember_controller.dart';

import '../Login/ActionButton.dart';
import '../Values/Strings.dart';
import 'HomePage/HomePage.dart';
import 'Register/infoMessage.dart';

class buildProfile extends StatefulWidget {
  @override
  _buildProfileState createState() => _buildProfileState();
}

class _buildProfileState extends State<buildProfile> {
  TextEditingController emailController = TextEditingController();
  var controller = RememberController();
  String name = "";
  String lastname = "";

  var user = GetStorage().read("user");
  Future<void> getUserData() async {
    final FirebaseAuth auth = await FirebaseAuth.instance;
    final User user = await auth.currentUser;
    final uid = user.uid;
    var snapshotName =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      emailController.text = snapshotName["Email"];
      name = snapshotName["name"];
      lastname = snapshotName["lastname"];
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffEAEDEF),
      body: Column(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  SizedBox(
                    width: size.width * 0.15,
                  ),
                  Text(
                    ConstStrings.Profile,
                    style: TextStyle(
                        fontSize: size.height * 0.028,
                        fontFamily: "NewsCycle-Bold"),
                    textAlign: TextAlign.center,
                  )
                ],
              )),
          DividerBox(
            size: size,
            height: 0.02,
          ),
          CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage("${user["url"]}"),
          ),
          DividerBox(
            size: size,
            height: 0.02,
          ),
          Text(
            "$name $lastname",
            style: TextStyle(color: Color(0xff5154b5), fontSize: 20),
          ),
          DividerBox(
            size: size,
            height: 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Container(
              height: size.height * 0.1,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "${user["email"]}",
                    hintStyle: TextStyle(
                      color: Colors.blueAccent,
                    ),
                    suffixIcon: Icon(Icons.email_outlined),
                    fillColor:
                        Colors.white10, // the color of the inside box field
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), //borderradius
                    )),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: BuildLoginButton(size, ConstStrings.Logout, () {
                InfoMessage(
                  message: "êtes-vous sûr de se déconnecter ?",
                  press: () async {
                    await FirebaseAuth.instance.signOut();
                    controller.Logout();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                ).show(context);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
