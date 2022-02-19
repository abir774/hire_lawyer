import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LawyerPersonalProfile.dart';
import 'lawyerMessages.dart';


class HomePageLawyer extends StatefulWidget {
  @override

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageLawyer> {
  int currentIndex = 0;
  bool connected=true;
  String user;
  List <BottomNavyBarItem>items=[

    BottomNavyBarItem(
      icon: Stack(
        children: [
          Icon(Icons.email_outlined),
          CircleAvatar(
            radius: 5,
            backgroundColor: Colors.red,
            child: Text("1",style: TextStyle(
                fontSize: 5,
                fontWeight: FontWeight.bold
            ),),
          ),
        ],
      ),
      title: Text("Messages"),
      activeColor: Colors.green,
    ),
    BottomNavyBarItem(
      icon:Icon(Icons.account_circle_outlined),
      title: Text("Profil"),
      activeColor: Colors.deepPurpleAccent,
    ),

  ];

  @override

  Widget build(BuildContext context) {

    List pages=[

      MessagesLawyer(),
      LawyerPersonalProfile(),


    ];
    return Scaffold(

      body: SafeArea(

        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight:  Radius.circular(40),bottomLeft:  Radius.circular(40),)
          ),
          child: pages[currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        onItemSelected: (int value) {
          setState(() {
            currentIndex=value;
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
