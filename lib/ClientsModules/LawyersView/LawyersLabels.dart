import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Messages/Messenger.dart';

class LawyersLabels extends StatelessWidget {
  final String image;
  final String footer;
  const LawyersLabels({
    Key key,
    this.image,
    this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Messenger(label:"$footer")));
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
                child:Container(

                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://user.oc-static.com/files/6001_7000/6410.jpg",
                    ),
                  ),
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