import 'package:flutter/material.dart';

class Reuse extends StatelessWidget {
  final Widget card;
  final Color colour;
  Reuse({this.card, @required this.colour});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: card,
      margin: EdgeInsets.all(10),
      //padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
