import 'package:flutter/material.dart';
//import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  return runApp(quizApp());
}

class quizApp extends StatefulWidget {
  @override
  _quizAppState createState() => _quizAppState();
}

class _quizAppState extends State<quizApp> {
  int dare = 0;
  int counter = 0;
  List ver = [
    Icon(
      Icons.ac_unit,
      color: Colors.blue,
    ),
  ];
  List ans = [
    true,
    true,
    true,
    true,
    true,
    true,
    false,
    false,
    true,
    false,
    true,
    true,
  ];
  List qns = [
    "He was a skipper of NZ",
    "He plays for SRH ",
    "He is Mr.360",
    "He is a good fielder",
    "He is from Ireland",
    "He is from NewZealand",
    "He can swing the ball",
    "He is from South Africa",
    "He is a Left arm batsman",
    "He is a left arm seamer",
    "He had bowled a Super-Over",
    ""
  ];
  List<Icon> lr = [
    Icon(
      Icons.check,
      color: Colors.green,
    ),
    Icon(
      Icons.close,
      color: Colors.red,
    ),
    Icon(
      Icons.ac_unit,
      color: Colors.blue,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,
            title: Text(
              '✺QUIZAPP✺',
              style: TextStyle(color: Colors.redAccent[400], fontSize: 47),
            ),
            backgroundColor: Colors.amber[400],
          ),
          backgroundColor: Colors.black54,
          body: Container(
              alignment: AlignmentDirectional.topStart,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 100),
                    height: 220,
                    width: 220,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/img$dare.jpg'),
                      radius: 200,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                  ),
                  Container(
                    child: Text(
                      qns[dare],
                      style: TextStyle(
                          color: Colors.lightBlue[600],
                          fontSize: 40,
                          fontFamily: 'JosefinSans',
                          fontWeight: FontWeight.bold,
                          wordSpacing: 12),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 100,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FlatButton(
                          splashColor: Colors.amber,
                          onPressed: () {
                            //print("$dare");
                            setState(() {
                              bool b = ans[dare];
                              if (b == true) {
                                ver.add(lr[0]);

                                if (dare < 11) {
                                  dare++;
                                  counter++;
                                }
                              } else {
                                ver.add(lr[1]);
                                if (dare < 11) {
                                  dare++;
                                }
                              }
                            });
                          },
                          child: Text('True'),
                          color: Colors.green,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FlatButton(
                          splashColor: Colors.amber,
                          onPressed: () {
                            setState(() {
                              bool b = ans[dare];
                              if (b == false) {
                                ver.add(lr[0]);

                                if (dare < 11) {
                                  dare++;
                                  counter++;
                                }
                              } else {
                                ver.add(lr[1]);
                                if (dare < 11) {
                                  dare++;
                                }
                              }
                              //fun1();
                            });
                          },
                          child: Text('False'),
                          color: Colors.red,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ver[dare],
                            Column(
                              children: [
                                Text(
                                  "You got $counter right!",
                                  style: TextStyle(
                                      color: Colors.redAccent[400],
                                      fontSize: 30,
                                      fontWeight: FontWeight.w900,
                                      backgroundColor: Colors.amber[400]),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
