import 'package:flutter/material.dart';
import 'input_page.dart';

void main() {
  return runApp(calc());
}

calc_1 cl1 = new calc_1();

class calc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFFF1654),
        accentColor: Colors.amber,
        textTheme: TextTheme(
          body1: TextStyle(
            color: Colors.indigo[900],
          ),
        ),
        scaffoldBackgroundColor: Colors.black87,
      ),
      home: calc_1(),
    );
  }
}
