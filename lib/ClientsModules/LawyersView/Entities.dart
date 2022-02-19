
import 'package:flutter/cupertino.dart';

class Family extends StatelessWidget {
  final List<Lawyer> informations;
  const Family({this.informations});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Property extends Family {

  Property({List <Lawyer> informations}):super(informations:informations);


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Criminal extends Family {

  Criminal({List <Lawyer> informations}):super(informations:informations);


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Infaractions extends Family {

  Infaractions({List <Lawyer> informations}):super(informations:informations);


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Injury extends Family {

  Injury({List <Lawyer> informations}):super(informations:informations);


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Employment extends Family {

  Employment({List <Lawyer> informations}):super(informations:informations);


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Lawyer extends StatelessWidget {
  final String name;
  final double profilPic;
  final String adresse;
  const Lawyer({
    Key key,
    this.name,
    this.profilPic,
    this.adresse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(name),
    );
  }
}
