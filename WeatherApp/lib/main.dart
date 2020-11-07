import 'package:flutter/material.dart';
import 'results.dart';

void main() {
  return runApp(first_weather());
}

class first_weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: Container(
        color: Colors.purpleAccent[700],
        child: FlatButton(
          child: Text("Check location"),
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultPage()),
              );
            });
          },
        ),
      ),
    );
  }
}
