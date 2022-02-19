import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SenderBubble extends StatelessWidget {
  const SenderBubble({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 110,bottom: 5),
      child: Column(

        children: [


          Container(

            child: Align(

                alignment: Alignment.bottomLeft,
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.8),
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20),bottomLeft: Radius.circular(20) )
                  ),
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(

                      "Le Lorem Ipsum est simplement du faux texte employé dans laLorem Ipsum est simplement du faux texte employé dans la composition et la ",

                    ),
                  ),


                )
            ),
          ),
          Transform.translate(
            offset: Offset(112, 0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}