import 'package:flutter/material.dart';
import 'package:thirai/result_screen.dart';

var search;

class Movie_Scr extends StatelessWidget {
  dynamic get_search() {
    return search;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/avengers.gif'),
                    fit: BoxFit.fill)),
          ),
          Container(
            margin: EdgeInsets.all(25),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Enter movie to search for..',
                  filled: true,
                  fillColor: Colors.amber,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              autocorrect: true,
              onChanged: (value) => {
                search = value,
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(155, 80, 0, 0),
                child: FlatButton(
                  child: Text('Fetch'),
                  color: Colors.greenAccent[400],
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Result_screen(),
                        ));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
