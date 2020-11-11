import 'package:flutter/material.dart';
import 'locations.dart';

void main() {
  runApp(FirstPage());
}

class FirstPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loc_met(),
    );
  }
}
