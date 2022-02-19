import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hire_lawyer/Login/DividerBox.dart';
import 'package:intl/intl.dart';

import '../ClientsModules/HomePage/HomePage.dart';
import '../Values/Strings.dart';
import 'Messenger.dart';

class buildMessages extends StatefulWidget {
  @override
  _buildMessagesState createState() => _buildMessagesState();
}

class _buildMessagesState extends State<buildMessages> {
  String uid;
  List result;
  List resultText;
  var user = GetStorage().read("user");
  ScrollController controller = new ScrollController();
  Future<void> getUserData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;

    setState(() {
      uid = user.email;
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
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
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
                        ConstStrings.Messages,
                        style: TextStyle(
                            fontSize: size.height * 0.028,
                            fontFamily: "NewsCycle-Bold"),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )),
              DividerBox(
                size: size,
                height: 0.05,
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: snapshotMessages
                    .collection('messages')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  List msg = [];

                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data.size != 0) {
                    final messages = snapshot.data.docs.reversed;

                    for (var message in messages) {
                      final getText = message.get('text');
                      final getSender = message.get('sender');
                      final getDestination = message.get('destination');
                      final getTime = message.get('time');
                      final Map<String, String> messageWidget = {
                        'getText': getText,
                        'getTime': DateFormat('kk:mm').format(
                            DateTime.parse(getTime.toDate().toString())),
                        'getSender': getSender,
                        'getDestination': getDestination,
                      };
                      if ((((messageWidget["getSender"] == uid) ||
                          (messageWidget["getDestination"] == uid)))) {
                        msg.add(messageWidget);
                      }
                    }

                    for (int i = 0; i < msg.length; i++) {
                      for (int j = i + 1; j < msg.length; j++) {
                        if ((msg[i]["getSender"] == msg[j]["getSender"]) &&
                                (msg[i]["getDestination"] ==
                                    msg[j]["getDestination"]) ||
                            (msg[i]["getSender"] == msg[j]["getDestination"]) &&
                                (msg[i]["getSender"] ==
                                    msg[j]["getDestination"])) {
                          msg[j] = {
                            'getText': '',
                            'getSender': '',
                            'getDestination': '',
                          };
                        }
                      }
                    }

                    for (int i = 0; i < msg.length; i++) {
                      if (msg[i]["getSender"] == "") {
                        msg.remove(msg[i]);
                        i--;
                      }
                    }
                    print(msg);
                  } else
                    return Column(
                      children: [
                        Image.asset('assets/images/msg.png'),
                        Text("Pas des messages encore.")
                      ],
                    );

                  return Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                        itemCount: msg.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Messenger(
                                        email: uid ==
                                                msg[index]["getDestination"]
                                            ? "${msg[index]["getSender"]}"
                                            : "${msg[index]["getDestination"]}",
                                        label: "test",
                                        profil:
                                            "https://www.bakerlaw.com/images/bio/dawson_todd_04121_imagethumb_296795.jpg",
                                      )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.bottomEnd,
                                        children: [
                                          CircleAvatar(
                                              radius: 33,
                                              backgroundImage:
                                                  uid == msg[index]["getSender"]
                                                      ? NetworkImage(
                                                          "${user["url"]}")
                                                      : NetworkImage(
                                                          "${user["url"]}")),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(bottom: 3, end: 3),
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.green.shade700,
                                              radius: 7,
                                            ),
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    width: size.width * 0.03,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${msg[index]["getText"]}"),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Text("${msg[index]["getTime"]}"),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        padding: EdgeInsets.all(20),
                        controller: controller,
                      )),
                    ],
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
