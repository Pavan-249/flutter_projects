import 'package:flutter/material.dart';
import 'question.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Question_paper qp = Question_paper();

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

  List<Widget> ver = [
    Icon(
      Icons.ac_unit,
      color: Colors.blue,
    ),
  ];

  List<Widget> ckr = [
    Center(
      child: Text(
        'You are all done',
        style: TextStyle(
            fontSize: 30, color: Colors.black, backgroundColor: Colors.blue),
      ),
    )
  ];

  void alterr(BuildContext contex) {
    if (dare == 11) {
      print(dare);
      Alert(context: contex, desc: 'fluuter', title: 'hey');
    }
  }

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
    List checker() {
      if (dare < 11) {
        return ver;
      } else {
        alterr(context);
        return ckr;
        //return ckr;
      }
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,
            title: Text(
              '✺✺ QUIZAPP ✺✺',
              style: TextStyle(color: Colors.redAccent[400], fontSize: 45),
            ),
            backgroundColor: Colors.amber[400],
          ),
          backgroundColor: Colors.black87,
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
                      qp.qns[dare],
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
                            setState(() {
                              alterr(context);
                              bool b = qp.ans[dare];
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
                              alterr(context);
                              bool b = qp.ans[dare];
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
                            Column(
                              children: [
                                Text(
                                  "You got $counter right!",
                                  style: TextStyle(
                                      color: Colors.redAccent[400],
                                      fontSize: 30,
                                      fontWeight: FontWeight.w900,
                                      backgroundColor: Colors.amber[400]),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: checker(),
                            ),
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
