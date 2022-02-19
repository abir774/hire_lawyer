import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReceiverBubble extends StatelessWidget {
  final message;
  const ReceiverBubble({
    Key key, this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50,bottom: 5),
      child: Column(

        children: [


          Container(

            child: Align(

                alignment: Alignment.bottomLeft,
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.8),
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20),bottomRight: Radius.circular(20) )
                  ),
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(

                    "$message"

                    ),
                  ),


                )
            ),
          ),
          Transform.translate(
            offset: Offset(-192, 0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}