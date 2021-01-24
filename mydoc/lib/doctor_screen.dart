import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mydoc/datafile.dart';
import 'package:screenshot/screenshot.dart';
import 'package:cool_alert/cool_alert.dart';
import 'login_screen.dart';
import 'package:path_provider/path_provider.dart';

List l1 = [], l2 = [];

LoginScreen loginScreen = LoginScreen();
String newValue;
ScreenshotController screenshotController = ScreenshotController();
int ptr = 2;
var ans = 0;
final List<FlSpot> allSpots = [];
List<FlSpot> final_spots = [];
void listget() {
  double r1, r2;
  int i;
  for (i = 0; i < (l2.length) / 5; i++) {
    r1 = l1[i];
    r2 = l2[i];
    allSpots.add(FlSpot(r1, r2));
  }
}

void myTime() {
  try {
    String str = calcTime();
    int year = int.parse(str.substring(0, 4));
    int month = int.parse(str.substring(5, 7));
    int date = int.parse(str.substring(8, 10));
    DateTime now = DateTime.now();
    final DateTime dateTime = DateTime(year, month, date);
    ans = dateTime.difference(now).inDays;
  } catch (e) {
    print(e);
  }
}

List<FlSpot> mySpot() {
  if (ptr == 0) {
    final_spots = allSpots.sublist(0, 15);
  }
  if (ptr == 1) {
    final_spots = allSpots.sublist(0, 20);
  }
  if (ptr == 2) {
    final_spots = allSpots.sublist(0, 40);
  }
  if (ptr == 3) {
    final_spots = allSpots.sublist(0, 48);
  }
  return final_spots;
}

class DoctorScreen extends StatelessWidget {
  static final riKey1 = const Key('__RIKEY1__');
  static final riKey2 = const Key('__RIKEY2__');
  static final riKey3 = const Key('__RIKEY3__');
  Widget build(BuildContext context) {
    checkup(context);
    clct();
    clctval();
    listget();
    myTime();
    List data = rData();
    var value;
    var time;
    var value_max, time_max;
    value = data[0].val[0];
    value_max = data[0].val.length;
    time = data[0].time[0];
    time_max = data[0].time.length;
    return Scaffold(
      body: MyDoc(),
      backgroundColor: Colors.indigoAccent[400],
    );
  }
}

class MyDoc extends StatefulWidget {
  @override
  _MyDocState createState() => _MyDocState();
}

String dropdownValue = 'Flexion';

class _MyDocState extends State<MyDoc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: SweepGradient(
              tileMode: TileMode.repeated,
              colors: [Color(0xff141e30), Color(0xff243b55)])),
      child: Column(
        children: [
          Container(
            //color: Colors.pink,
            //width: double.infinity,
            height: 105,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment
                        .topLeft, //startAngle: 0, endAngle: 3.18 * 8.5,
                    //tileMode: TileMode.clamp,
                    colors: [
                  Color(0xff2b5876),
                  //Color(0xffba5370),
                  Color(0xffba5370)
                ])),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(left: 10, top: 20),
                height: 60.0,
                width: 60.0,
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/Jerry_Mouse.png'),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      data[0].name,
                      style: TextStyle(color: Colors.amber[200], fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      data[0].id,
                      style: TextStyle(color: Colors.amber[400], fontSize: 15),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, bottom: 15),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30, top: 30),
                      //padding: EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Last Active:',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '$ans Days Ago',
                            style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.transparent),
            //color: Colors.red,
            margin: EdgeInsets.only(right: 200),
            child: DropdownButton<String>(
              dropdownColor: Colors.pink,
              value: dropdownValue,
              icon: Icon(
                Icons.arrow_downward,
                color: Colors.amber,
              ),
              iconSize: 35,
              elevation: 16,
              style: TextStyle(color: Colors.amber, fontSize: 15),
              onChanged: (newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['Flexion', 'Finch', 'Smith', 'Warner']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Screenshot(
            controller: screenshotController,
            child: Container(
              margin: EdgeInsets.all(30),
              color: Colors.cyan,
              height: 350,
              width: 500,
              child: LineChart(
                LineChartData(
                    gridData: FlGridData(show: true),
                    minX: 6,
                    maxX: 13,
                    minY: 0,
                    maxY: 10,
                    lineBarsData: [LineChartBarData(spots: mySpot())]),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                color: Colors.pink,
                height: 30,
                width: 170,
                child: Row(
                  children: [
                    GestureDetector(
                      child: Text(
                        '1D',
                        style: TextStyle(color: Colors.amber),
                      ),
                      onTap: () {
                        setState(() {
                          ptr = 0;
                        });
                      },
                    ),
                    SizedBox(
                      width: 23,
                    ),
                    GestureDetector(
                      child: Text(
                        '1W',
                        style: TextStyle(color: Colors.amber),
                      ),
                      onTap: () {
                        setState(() {
                          ptr = 1;
                        });
                      },
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    GestureDetector(
                      child: Text(
                        '1M',
                        style: TextStyle(color: Colors.amber),
                      ),
                      onTap: () {
                        setState(() {
                          ptr = 2;
                        });
                      },
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    GestureDetector(
                      child: Text(
                        'Max',
                        style: TextStyle(color: Colors.amber),
                      ),
                      onTap: () {
                        setState(() {
                          ptr = 3;
                        });
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
                child: GestureDetector(
                  onTap: () async {
                    final directory = (await getExternalStorageDirectory())
                        .path; //from path_provide package
                    String fileName = DateTime.now().toIso8601String();
                    var path = '$directory/$fileName.png';
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.success,
                      text: "Screenshot saved successfully!!",
                    );
                    screenshotController.capture(path: path);
                  },
                  child: Icon(
                    Icons.download_rounded,
                    color: Colors.pink,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 50,
          ),
          Container(
            margin: EdgeInsets.only(left: 115),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_left_rounded,
                  color: Colors.pink,
                  size: 80,
                ),
                Icon(
                  Icons.arrow_right_rounded,
                  color: Colors.pink,
                  size: 80,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              CoolAlert.show(
                context: context,
                type: CoolAlertType.warning,
                confirmBtnText: 'Log out',
                cancelBtnText: 'Cancel',
                onConfirmBtnTap: () {
                  FirebaseAuth.instance.signOut();
                  //Navigator.of(context).pushReplacementNamed('/second');
                  // Navigator.popAndPushNamed(context,
                  //     MaterialPageRoute(builder: (context) => (LoginScreen())));
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.pop(context);
                },
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 300),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
              child: Icon(
                Icons.undo_rounded,
                color: Colors.pink,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// void ss() {

// }

void clct() {
  for (int i = 0; i < data[0].val.length - 1; i++) {
    double d1 = data[0].val[i].toDouble() / 1500;
    if (d1 != null) l1.add(d1);
  }
}

void clctval() {
  for (int i = 0; i < data[0].time.length - 1; i++) {
    double d2 = data[0].time[i].toDouble() / 7;
    if (d2 != null) l2.add(d2);
  }
}
