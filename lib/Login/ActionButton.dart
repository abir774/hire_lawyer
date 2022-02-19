import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Padding BuildLoginButton(Size size, String label, Function press) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 60),
    child: Container(
      height: size.height * 0.07,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: press,
        child: Text("$label"),
        style: ElevatedButton.styleFrom(
            primary: Color(0xff848DFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    ),
  );
}
