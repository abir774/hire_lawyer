import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hire_lawyer/ClientsModules/LawyersView/Lawyers.dart';

class buildHomePage extends StatefulWidget {
  final bool connected;
  final String userName;
  final Function press;
  const buildHomePage({this.connected, this.press, this.userName});
  @override
  _buildHomePageState createState() => _buildHomePageState();
}

class _buildHomePageState extends State<buildHomePage> {
  String userName = "";
  List<Content> contentList = [
    Content(
        image: 'assets/images/family-room.png', footer: 'Droit de la famille'),
    Content(image: 'assets/images/home.png', footer: 'Loi de properiété'),
    Content(image: 'assets/images/prison.png', footer: 'Loi criminele'),
    Content(
        image: 'assets/images/traffic.png',
        footer: 'Infractiosn de la circulation'),
    Content(image: 'assets/images/injury.png', footer: 'Blessurre personelle'),
    Content(
        image: 'assets/images/employement.png', footer: 'Droit de travaille'),
  ];
  Future<void> getUserData() async {
    final FirebaseAuth auth = await FirebaseAuth.instance;
    final User user = await auth.currentUser;
    final uid = user.uid;
    var snapshotName =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      userName = snapshotName["name"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffEAEDEF),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundColor:
                          widget.connected == true ? Colors.green : Colors.red,
                      radius: 40,
                      child: InkWell(
                        onTap: widget.press,
                        child: CircleAvatar(
                          child: Image.asset('assets/images/logo.png'),
                          backgroundColor: Colors.white,
                          radius: 35,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    /* child:FutureBuilder(
                      future: insertUserFireStore(),
                      builder: (context,snapshot){
                      },
                    ),*/
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Bienvenue ${user["name"]}.",
                          style: TextStyle(
                              fontSize: size.height * 0.035,
                              fontFamily: "EBGaramond"),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage("${user["url"]}."),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: contentList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (2),
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  itemBuilder: (context, int index) {
                    return contentList[index];
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final String image;
  final String footer;
  const Content({
    Key key,
    this.image,
    this.footer,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Lawyers(
                  footer: footer,
                )));
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                flex: 2,
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                )),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  footer,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*
import 'package:flutter/cupertino.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hire_lawyer/ClientsModules/LawyersView/Lawyers.dart';

import '../../empty.dart';


class buildHomePage extends StatefulWidget {
  final bool connected;
  final String userName;
  final Function press;

  const buildHomePage({

this.connected, this.press, this.userName});

  @override

  _buildHomePageState createState() => _buildHomePageState();
}

class _buildHomePageState extends State<buildHomePage> {
String userName="";

  List<Content> contentList = [
    Content(image: 'assets/images/family-room.png', footer: 'Droit de la famille'),
    Content(image: 'assets/images/home.png', footer: 'Consultation Medicale'),
    Content(image: 'assets/images/traffic.png', footer: 'Consultation nutritionel'),
    Content(image: 'assets/images/injury.png', footer: 'Consultation religieux'),
    Content(image: 'assets/images/employement.png', footer: 'Consultation sportive'),
    Content(image: 'assets/images/employement.png', footer: 'Consultation administrative'),
    Content(image: 'assets/images/employement.png', footer: 'Consultation familiale'),
    Content(image: 'assets/images/employement.png', footer: 'Consultation économique'),
    Content(image: 'assets/images/employement.png', footer: 'Consultation pédagogique'),
  ];


  Future<void> getUserData()async{
    final FirebaseAuth auth = await FirebaseAuth.instance;
    final User user = await auth.currentUser;
    final uid = user.uid;
    var snapshotName = await FirebaseFirestore.instance.collection('users').doc(uid).get();
setState(() {
  userName =snapshotName["name"];

});

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          color:  Color(0xffEAEDEF),

        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 30,
                        child: InkWell(
                          onTap: widget.press,
                          child: CircleAvatar(
                            child: Image.asset('assets/images/logo.png'),
                            backgroundColor: Colors.white,
                            radius: 27,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,


                       child:Row(
                         children: [

                           Text(
                            "Bienvenue ,$userName",
                            style: TextStyle(
                                fontSize: size.height * 0.035, fontFamily: "NewsCycle-Bold"),
                      ),
                         ],
                       ),
                    ),
                  ),
                  Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepPurpleAccent

                    ),
                    child: IconButton(
                      icon: Icon(Icons.notifications_none,color: Colors.white,),
                    ),
                  ),

                ],
              ),
            ),


            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: contentList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (3), crossAxisSpacing: 10, mainAxisSpacing: 15),
                  itemBuilder: (context, int index) {
                    return contentList[index];
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class Content extends StatelessWidget {
  final String image;
  final String footer;
  const Content({
    Key key,
    this.image,
    this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      Navigator.of(context).push( MaterialPageRoute(builder: (context)=>Lawyers(footer: footer,)));

      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                flex: 2,
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                )),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(footer,
                textAlign: TextAlign.center,),
              ),
            )
          ],
        ),
      ),
    );
  }
}

*/
