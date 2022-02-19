import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hire_lawyer/ClientsModules/HomePage/HomePage.dart';
import 'package:hire_lawyer/LawyersModules/LawyerHomePage.dart';
import 'package:hire_lawyer/Login/LoginFinal.dart';
import 'package:hire_lawyer/onboardingPage/Onboarding.dart';

class SplasScreen extends StatefulWidget {
  @override
  _SplasScreenState createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var auth = GetStorage().read("auth");

    var type_auth = GetStorage().read("type_auth");
    var resultSeen = GetStorage().read("seen");
    Timer(
      Duration(seconds: 2),
      () => Get.to(() => resultSeen == 1
          ? (auth == 1
              ? (type_auth == 1 ? HomePage() : HomePageLawyer())
              : Login())
          : Onboarding()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo.png',
                width: size.width * 0.9,
              ),
            ),
            Container(
              child: const Text(
                "Hire Lawyer ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Teko-Medium',
                ),
              ),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    ));
  }
}
