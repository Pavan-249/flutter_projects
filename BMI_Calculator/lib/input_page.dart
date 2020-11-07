import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'reusable.dart';
import 'clr_checker.dart';
import 'results.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

clr_palette clr = new clr_palette();

class calc_1 extends StatefulWidget {
  @override
  _calc_1State createState() => _calc_1State();
}

void alterr(BuildContext context) {
  Alert(context: context, desc: 'flutter', title: 'alert_arumugam').show();
}

class _calc_1State extends State<calc_1> {
  Gender sex1 = Gender.Female, sex2 = Gender.Male;
  double d1 = 180;
  int weight = 50;
  int age = 18;
  List input_vls = [];
  List input_values() {
    input_vls.add(d1);
    input_vls.add(weight);
    return input_vls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI CALCULATOR"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Reuse(
                      colour: Color(clr.chk_color1(sex1)),
                      card: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.marsStroke,
                                size: 100,
                                color: Color(0xFFFF1654),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                if (sex1 == Gender.Male) {
                                  sex1 = Gender.Female;
                                } else {
                                  sex1 = Gender.Male;
                                  sex2 = Gender.Male;
                                }
                              });
                            },
                            splashColor: Colors.amber,
                          ),
                          Text(
                            "Male",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.indigo[900],
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      )),
                ),
                Expanded(
                  child: Reuse(
                      colour: Color(clr.chk_color2(sex2)),
                      card: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.venus,
                                size: 100,
                                color: Color(0xFFFF1654),
                              ),
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  if (sex2 == Gender.Female) {
                                    sex2 = Gender.Male;
                                  } else {
                                    sex2 = Gender.Female;
                                    sex1 = Gender.Female;
                                  }
                                },
                              );
                            },
                            splashColor: Colors.amber,
                          ),
                          Text(
                            "Female",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.indigo[900],
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            child: Reuse(
              colour: Color(0xff00ffef),
              card: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Height",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.indigo[900],
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        d1.toString(),
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Architect',
                          color: Color(0xFFFF1654),
                        ),
                      ),
                      Text(
                        'CM',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Architect',
                          color: Color(0xFFFF1654),
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    autofocus: true,
                    value: d1.roundToDouble(),
                    min: 120,
                    max: 220,
                    onChanged: (double d2) {
                      setState(() {
                        d1 = d2.roundToDouble();
                      });
                    },
                    activeColor: Color(0xFFFF1654),
                    inactiveColor: Colors.indigo[900],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Reuse(
                    colour: Color(0xFF39FF14),
                    card: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        Text(
                          "Weight",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.indigo[900],
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 25,
                          width: 10,
                        ),
                        SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Expanded(
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  child: Icon(
                                    Icons.add_circle_rounded,
                                    color: Color(0xFFFF1654),
                                    size: 50,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      weight = clr.weight_counter(
                                          counter: weight, x: 1);
                                    });
                                  },
                                ),
                              ),
                              Text(
                                weight.toString(),
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Architect',
                                  color: Color(0xFFFF1654),
                                ),
                              ),
                              Expanded(
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  child: Icon(
                                    Icons.do_disturb_on_rounded,
                                    color: Color(0xFFFF1654),
                                    size: 50,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      weight = clr.weight_counter(
                                          counter: weight, y: 1);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Reuse(
                      colour: Color(0xFF39FF14),
                      card: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Age",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.indigo[900],
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Expanded(
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  child: Icon(
                                    Icons.add_circle_rounded,
                                    color: Color(0xFFFF1654),
                                    size: 50,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      age = clr.age_counter(age: age, z: 1);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                age.toString(),
                                style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Architect',
                                  color: Color(0xFFFF1654),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  child: Icon(
                                    Icons.do_disturb_on_rounded,
                                    color: Color(0xFFFF1654),
                                    size: 50,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      age = clr.age_counter(age: age, w: 1);
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              color: Color(0xFFFF1654),
              padding: EdgeInsets.only(left: 80 , top: 10),
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              height: 60,
              child: Text(
                'CALCULATE',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            onTap: () {
              setState(() {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            new Resultpage(l: input_values())));
              });
            },
          ),
        ],
      ),
    );
  }
}
