import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:hire_lawyer/ClientsModules/Register/infoMessage.dart';

import 'Messages.dart';

final snapshotMessages = FirebaseFirestore.instance;
ScrollController controller = new ScrollController();

class Messenger extends StatefulWidget {
  final String label;
  final String profil;
  final String email;

  const Messenger({this.label, this.email, this.profil});

  @override
  _MessengerState createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> {
  String textMessage = "";
  String uid;
  bool isShowSticker = false;
  bool showKeyBoard = false;
  var focusNode = FocusNode();
  var inputFlex = 1;
  var numLines;

  ScrollController controller = new ScrollController();
  TextEditingController messageController = new TextEditingController();
  @override
  Future<void> getUserData() async {
    String uid;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;

    setState(() {
      this.uid = user.email;
    });
    return uid;
  }

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
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 60,
                  color: Color(0xffEAEDEF),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            await SystemChannels.textInput
                                .invokeMethod('TextInput.hide');

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => buildMessages()));
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.green,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage("${widget.profil}"),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Text(
                        "${widget.label}",
                        style: TextStyle(
                            fontSize: size.height * 0.028,
                            fontFamily: "NewsCycle-Bold"),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )),
            Expanded(
                flex: 10,
                child: Container(
                  child: Column(
                    children: [
                      MessageStreamBuilder(
                        email: widget.email,
                      )
                    ],
                  ),
                )),
            Expanded(
              flex: inputFlex,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xff3ba58a),
                            borderRadius: BorderRadius.circular(30)),
                        child: GestureDetector(
                          onTap: () {},
                          child: IconButton(
                            icon: Icon(Icons.camera_alt_outlined,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: RawKeyboardListener(
                          focusNode: focusNode,
                          onKey: (event) {
                            if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                              setState(() {
                                /* inputFlex=inputFlex+1;*/
                                numLines = '\n'
                                        .allMatches(messageController.text)
                                        .length +
                                    1;

                                if (numLines < 3) {
                                  inputFlex = numLines;
                                }
                              });
                            }
                          },
                          child: TextField(
                            maxLines: null,
                            onChanged: (value) {
                              textMessage = value;
                            },
                            keyboardType: TextInputType.multiline,
                            controller: messageController,
                            decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                suffixIcon: GestureDetector(
                                  onTap: () async {},
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.emoji_emotions_outlined,
                                    ),
                                  ),
                                ),
                                hintText: "   Ecrire un message",
                                hintStyle: TextStyle(
                                  color: Colors.blueAccent,
                                ),
                                fillColor: Color(
                                    0xffe6ebf5), // the color of the inside box field
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.circular(30), //borderradius
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.circular(30), //borderradius
                                )),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Color(0xff00a984),
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (messageController.text.endsWith(" ")) {
                              InfoMessage(
                                press: () {
                                  Navigator.pop(context);
                                },
                                message:
                                    "Message ne doit pas contenir espace seulement",
                              ).show(context);
                            } else if (messageController.text.isEmpty) {
                              InfoMessage(
                                press: () {
                                  Navigator.pop(context);
                                },
                                message: "Message ne peut pas etre vide",
                              ).show(context);
                            } else {
                              messageController.clear();

                              snapshotMessages.collection('messages').add({
                                'text': "$textMessage",
                                'destination': "${widget.email}",
                                'sender': "$uid",
                                'time': FieldValue.serverTimestamp(),
                              });
                              setState(() {
                                inputFlex = 1;
                              });
                            }
                          },
                          color: Colors.blueAccent,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageLine extends StatefulWidget {
  final String getText;
  final String getSender;
  final String getDestination;
  final String getTime;
  final bool check;

  const MessageLine({
    Key key,
    @required this.getText,
    this.getSender,
    this.getDestination,
    this.check,
    this.getTime,
  }) : super(key: key);

  @override
  _MessageLineState createState() => _MessageLineState();
}

class _MessageLineState extends State<MessageLine> {
  Future<void> getUserData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;

    return user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment:
            widget.check ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: widget.check
                ? BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15))
                : BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
            color: widget.check ? Color(0xff5a40a1) : Color(0xffe6ebf5),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                "${widget.getText}",
                style: TextStyle(
                    fontSize: 20,
                    color: widget.check ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//tous les messages
class MessageStreamBuilder extends StatefulWidget {
  final String email;
  const MessageStreamBuilder({
    Key key,
    @required this.email,
  }) : super(key: key);
  @override
  _MessageStreamBuilderState createState() => _MessageStreamBuilderState();
}

class _MessageStreamBuilderState extends State<MessageStreamBuilder> {
  String uid;
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
    return StreamBuilder<QuerySnapshot>(
      stream:
          snapshotMessages.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> msg = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = snapshot.data.docs.reversed;
        for (var message in messages) {
          final getText = message.get('text');
          final getSender = message.get('sender');
          final getDestination = message.get('destination');
          final getTime = message.get('time');

          if ((getSender == uid && getDestination == widget.email) ||
              (getSender == widget.email && getDestination == uid)) {
            final messageWidget = MessageLine(
              getText: getText,
              getSender: getSender,
              getDestination: getDestination,
              check: uid == getSender ? true : false,
            );

            msg.add(messageWidget);
          }
        }
        SchedulerBinding.instance.addPostFrameCallback((_) {
          controller.animateTo(controller.position.minScrollExtent,
              duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        }); //scroll to the end of listview
        return Expanded(
            child: ListView(
          reverse: true,
          padding: EdgeInsets.all(20),
          controller: controller,
          children: msg,
        ));
      },
    );
  }
}
