import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_lawyer/Login/LoginFinal.dart';
import 'package:hire_lawyer/Services/AuthServices.dart';

import '../Login/ActionButton.dart';
import '../Login/emailFormField.dart';
import '../Values/Strings.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool check;
  void showcustomSnackBar(BuildContext context) {
    final snackbar = SnackBar(
      content: Text('Conusltez votre courrier électronique'),
      backgroundColor: Colors.green,
      shape: StadiumBorder(),
      elevation: 0,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }

  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white30,
                Colors.blueGrey,
              ],
            ),
          ),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Login()));
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                      SizedBox(
                        width: size.width * 0.15,
                      ),
                      Text(
                        "Mot de passe oubliée",
                        style: TextStyle(
                            fontSize: size.height * 0.028,
                            fontFamily: "NewsCycle-Bold"),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 10),
                child: Container(
                  child: Text(
                    "Entrer votre E-mail et vous recevrez un e-mail de récupération",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
              ),
              emailFormField(
                size: size,
                controller: emailController,
                prefixIcon: Icons.email_outlined,
              ),
              BuildLoginButton(size, ConstStrings.Reset, () async {
                check =
                    await AuthServices().resetPassword(emailController.text);
                if (check) {
                  showcustomSnackBar(context);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
