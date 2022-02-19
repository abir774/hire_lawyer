import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_lawyer/Login/DividerBox.dart';
import 'package:hire_lawyer/Values/Strings.dart';
import 'package:intl/intl.dart';

import 'LawyerMessenger.dart';

ScrollController controller = new ScrollController();
final snapshotMessages = FirebaseFirestore.instance;

class MessagesLawyer extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<MessagesLawyer> {
  String uid;
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
          color: Color(0xffEAEDEF),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    ConstStrings.Messages,
                    style: TextStyle(
                        fontSize: size.height * 0.028,
                        fontFamily: "NewsCycle-Bold"),
                    textAlign: TextAlign.center,
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
                    return Text("no messages");

                  return Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                        itemCount: msg.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MessengerLawyer(
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
                                              backgroundImage: NetworkImage(
                                                  "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8aHVtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80")),
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
