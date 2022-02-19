import 'package:flutter/cupertino.dart';

class DividerBox extends StatelessWidget {
  const DividerBox({
    Key key,
    @required this.size, this.height,
  }) : super(key: key);

  final Size size;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * height,
    );
  }
}