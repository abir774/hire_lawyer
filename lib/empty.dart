import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ClientsModules/HomePage/HomePage.dart';

class PlaceHolder extends StatefulWidget {
  final String footer;

  const PlaceHolder({Key key, this.footer}) : super(key: key);

  @override
  _PlaceHolderState createState() => _PlaceHolderState();
}

class _PlaceHolderState extends State<PlaceHolder> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
                        " ${widget.footer}",
                        style: TextStyle(
                            fontSize: size.height * 0.028,
                            fontFamily: "NewsCycle-Bold"),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )),
            ],
          )

      ),
    );
  }
}
