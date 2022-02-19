import 'package:flutter/cupertino.dart';

class NoInternetConnection extends StatefulWidget {


  @override
  _NoInternetConnectionState createState() => _NoInternetConnectionState();
}

class _NoInternetConnectionState extends State<NoInternetConnection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Expanded(
                flex: 2,
                child: Image.asset('assets/images/no-connection.jpg')),
            Expanded(child: Image.asset('assets/images/alert.png')),
            Expanded(
              child: Center(child: Text("Pas de connexion internet veuillez la vérifier pour continuer.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'EBGaramond',
                fontSize: size.height * 0.03
              ),)),
            )
          ],
        )
      ,);
  }
}
