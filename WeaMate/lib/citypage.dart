import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

class CityPage extends StatefulWidget {
  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  var str;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.pink,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/sat.gif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
              child: TextField(
                showCursor: true,
                cursorColor: Colors.orange[900],
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(
                      Icons.location_city_outlined,
                      color: Colors.white70,
                      size: 50,
                    ),
                    fillColor: Colors.blueAccent[700],
                    hintText: 'Enter City Name',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none)),
                onChanged: (value) {
                  str = value;
                },
              ),
            ),
            SizedBox(
              height: 10,
              width: 20,
            ),
            Container(
              width: 800,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blueAccent[700],
              ),
              margin: EdgeInsets.fromLTRB(150, 130, 95, 0),
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              // left: 160, top: 130, right: 10, bottom: 0),
              child: GestureDetector(
                child: Text(
                  'Get Weather',
                  style: TextStyle(color: Colors.amberAccent, fontSize: 20),
                ),
                // color: Colors.black,
                onTap: () {
                  if (str != null) {
                    Navigator.pop(context, str);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
