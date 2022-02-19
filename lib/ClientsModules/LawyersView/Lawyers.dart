import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_lawyer/ClientsModules/HomePage/HomePage.dart';
import 'package:hire_lawyer/Login/DividerBox.dart';
import 'package:hire_lawyer/Messages/Messenger.dart';

class Lawyers extends StatefulWidget {
  final String footer;
  const Lawyers({this.footer});

  @override
  _LawyersState createState() => _LawyersState();
}

class _LawyersState extends State<Lawyers> {
  List lawyersList = [""];
  Map test = {};

  String getIndex() {
    String index;
    switch (widget.footer) {
      case "Droit de la famille":
        index = "family_law";
        break;
      case "Loi de properiété":
        index = "orperty_law";
        break;
      case "Loi criminele":
        index = "criminal_law";
        break;
      case "Infractiosn de la circulation":
        index = "infraction_law";
        break;
      case "Blessurre personelle":
        index = "personal_injury";
        break;
      case "Droit de travaille":
        index = "labour_law";
        break;
    }
    return index;
  }

  Future<void> getUserData() async {
    final FirebaseAuth auth = await FirebaseAuth.instance;

/*
    var snapshotNametest = await FirebaseFirestore
        .instance
        .collection('lawyers')
        .doc("family_law")
        .collection("1")
        .doc("2")
        .snapshots()
        .listen((event) {
      lawyersList.clear();
      Map<dynamic, dynamic> firestoreInfo = event.data();

      firestoreInfo.forEach((key, value) async {
        var lawyer = Cusers.fromJson(value);
        lawyersList.add(lawyer);
      });

      });*/
    var snapshot = await FirebaseFirestore.instance
        .collection('lawyers')
        .doc(getIndex())
        .collection("1")
        .get();
    Map map = Map<String, dynamic>();
    for (int i = 0; i < snapshot.docs.length; i++) {
      map["$i"] = snapshot.docs[i].data();
    }

    return map;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
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
                    " ${widget.footer}",
                    style: TextStyle(
                        fontSize: size.height * 0.028,
                        fontFamily: "NewsCycle-Bold"),
                    textAlign: TextAlign.center,
                  )
                ],
              )),
          DividerBox(size: size, height: 0.05),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                      future: getUserData(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.05,
                                    ),
                                    Container(
                                      height: size.height * 0.22,
                                      width: size.width * 0.8,
                                      child: Stack(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              await Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => Messenger(
                                                          label:
                                                              "${snapshot.data['$index']['name']} ${snapshot.data['$index']['lastname']} ",
                                                          email:
                                                              "${snapshot.data['$index']['email']}",
                                                          profil:
                                                              "${snapshot.data['$index']['url']}")));
                                            },
                                            child: Container(
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Colors.white70,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                elevation: 3,
                                                child: Container(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 15, left: 40),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              clipBehavior: Clip
                                                                  .antiAliasWithSaveLayer,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              child:
                                                                  Image.network(
                                                                "${snapshot.data['$index']['url']}",
                                                                fit:
                                                                    BoxFit.fill,
                                                                height:
                                                                    size.height *
                                                                        0.1,
                                                                width: 100,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.05,
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      "${snapshot.data['$index']['name']} ${snapshot.data['$index']['lastname']} ",
                                                                      style: TextStyle(
                                                                          fontSize: size.height *
                                                                              0.02,
                                                                          fontFamily:
                                                                              "EBGaramond"),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                            "${snapshot.data['$index']['rate']}"),
                                                                        Icon(
                                                                          Icons
                                                                              .star_rate_sharp,
                                                                          color:
                                                                              Colors.amber,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: size.height *
                                                              0.01,
                                                        ),
                                                        Text(
                                                          "${snapshot.data['$index']['desc']}",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Transform.translate(
                                            offset: Offset(-15, 20),
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  "${index + 1}",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              height: 60,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: Color(0xff8E9FFC)
                                                      .withOpacity(0.9),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              });
                        } else
                          return Center(child: CircularProgressIndicator());
                      }),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
/*return LawyersLabels(
                                    footer:"${snapshot.data['$index']['name']} ${snapshot.data['$index']['lastname']} ",
                                    image: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                                  );*/

/*  color:  Color(0xffEAEDEF),*/
