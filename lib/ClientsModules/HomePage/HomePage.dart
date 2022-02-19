import 'dart:io';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Messages/Messages.dart';
import '../ProfileClient.dart';
import 'Pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  bool connected = true;
  String user;
  Widget Positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: Text(
            " Oui",
            style: TextStyle(
              color: Color(0xffEAEDEF),
            ),
          )),
    );
  }

  Widget Negative(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(" Non"));
  }

  List<BottomNavyBarItem> items = [
    BottomNavyBarItem(
      icon: Icon(Icons.home_outlined),
      title: Text("Acceuil"),
      activeColor: Colors.cyan,
    ),
    BottomNavyBarItem(
      icon: Stack(
        children: [
          Icon(Icons.email_outlined),
          CircleAvatar(
            radius: 5,
            backgroundColor: Colors.red,
            child: Text(
              "1",
              style: TextStyle(fontSize: 5, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      title: Text("Messages"),
      activeColor: Colors.green,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.account_circle_outlined),
      title: Text("Profil"),
      activeColor: Colors.deepPurpleAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List pages = [
      buildHomePage(),
      buildMessages(),
      buildProfile(),
    ];
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          return showDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  content: Text(" êtes-vous sûr de sortir ?"),
                  actions: [Negative(context), Positive()],
                );
              });
        },
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            )),
            child: pages[currentIndex],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        onItemSelected: (int value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedIndex: currentIndex,
        items: items,
        backgroundColor: Color(0xffEAEDEF),
        showElevation: false,
      ),
    );
  }
}
