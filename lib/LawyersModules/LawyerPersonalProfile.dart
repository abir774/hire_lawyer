import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_lawyer/ClientsModules/Register/infoMessage.dart';
import 'package:hire_lawyer/Login/ActionButton.dart';
import 'package:hire_lawyer/Login/DividerBox.dart';
import 'package:hire_lawyer/Login/LoginFinal.dart';
import 'package:hire_lawyer/Values/Strings.dart';

class LawyerPersonalProfile extends StatefulWidget {
  @override
  _buildProfileState createState() => _buildProfileState();
}

class _buildProfileState extends State<LawyerPersonalProfile> {
  TextEditingController emailController = TextEditingController();
  String profile = "";
  Future<void> getUserData() async {
    final FirebaseAuth auth = await FirebaseAuth.instance;
    final User user = await auth.currentUser;
    final uid = user.uid;

    var snapshotName =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      emailController.text = snapshotName["email"];
      profile = snapshotName["url"];
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
              child: Text(
                ConstStrings.Profile,
                style: TextStyle(
                    fontSize: size.height * 0.028,
                    fontFamily: "NewsCycle-Bold"),
                textAlign: TextAlign.center,
              )),
          DividerBox(
            size: size,
            height: 0.02,
          ),
          CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage("$profile"),
          ),
          DividerBox(
            size: size,
            height: 0.02,
          ),
          Text(
            "Fathi Ayari",
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
                    hintText: "${emailController.text}",
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
