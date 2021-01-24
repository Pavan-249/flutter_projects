import 'package:flutter/material.dart';
import 'package:mydoc/doctor_screen.dart';
import 'registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'networking.dart';
import 'package:app_settings/app_settings.dart';
import 'dart:io';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

int error = 0;
int myInd;
bool spinner = false;
String time;

String calcTime() {
  return time;
}

void checkup(BuildContext context) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
    }
  } catch (_) {
    AppSettings.openWIFISettings();
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void initState() {
    super.initState();
    checkup(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Myhome(),
      ),
    );
  }
}

String email = '';
String password = '';

class Myhome extends StatefulWidget {
  @override
  _MyhomeState createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    void validate() async {
      try {
        setState(() {
          spinner = true;
        });
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        var result = user.user.metadata.lastSignInTime.toString();
        time = result.substring(0, 10);

        if (user != null) {
          //clearTextInput();
          setState(() {
            spinner = false;
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => (DoctorScreen())));
        }
        setState(() {
          spinner = false;
        });
      } catch (e) {
        print(e);
        setState(() {
          spinner = false;
        });
        setState(() {
          error = 1;
        });
      }
    }

    return ModalProgressHUD(
      inAsyncCall: spinner,
      child: Stack(
        children: [
          Container(
            //color: Color(0xff4488fa),
            decoration: BoxDecoration(
                gradient: SweepGradient(
                    tileMode: TileMode.repeated,
                    colors: [Color(0xffde6262), Color(0xffffb88c)])),
          ),
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 50, left: 20),
                    width: 400.0,
                    height: 190,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/docimg.JPG'),
                          radius: 50,
                        ),
                        Container(
                          //padding: EdgeInsets.only(left: 30),
                          //width: 250.0,
                          child: TypewriterAnimatedTextKit(
                            totalRepeatCount: 5,
                            speed: Duration(milliseconds: 150),
                            onTap: () {
                              print("Tap Event");
                            },
                            text: ["LeDocteur"],
                            textStyle: TextStyle(
                              fontSize: 50.0,
                              fontFamily: "Canterbury",
                              decorationColor: Colors.green,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        // ScaleAnimatedTextKit(
                        //   repeatForever: true,
                        //   duration: Duration(seconds: 7),
                        //   // isRepeatingAnimation: true,
                        //   // totalRepeatCount: 35,
                        //   onTap: () {},
                        //   text: ["DocApp"],
                        //   textStyle: TextStyle(
                        //       fontSize: 70.0,
                        //       fontFamily: "Canterbury",
                        //       color: Colors.red),
                        //   textAlign: TextAlign.start,
                        // ),
                      ],
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(0, 35, 12, 0),
                  //   height: 130,
                  //   width: 270,
                  //   child: Image(
                  //     image: AssetImage("images/mydoc.JPG"),
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(80, 115, 12, 0),
                  //   child: CircleAvatar(
                  //     backgroundImage: AssetImage("images/docimg.JPG"),
                  //     radius: 60,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: SweepGradient(
                        colors: [Color(0xff000428), Color(0xff004e92)])),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        TextField(
                            style: TextStyle(
                                color: Colors.red[600],
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                            cursorColor: Colors.red,
                            decoration: InputDecoration(
                                errorText: error == 1 ? '' : '',
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 15),
                                hintText: "Enter E-mail",
                                icon: Icon(
                                  Icons.email_sharp,
                                  color: Colors.amber,
                                ),
                                filled: true,
                                fillColor: Colors.amberAccent,
                                focusColor: Colors.yellow,
                                hoverColor: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                email = value;
                                error = 0;
                              });
                            }),
                        TextField(
                            obscureText: true,
                            cursorColor: Colors.red,
                            style: TextStyle(
                                color: Colors.red[600],
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                //errorText:
                                errorText: error == 1
                                    ? 'Invalid email or password'
                                    : '',
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 20),
                                icon: Icon(
                                  Icons.lock_sharp,
                                  color: Colors.amber,
                                ),
                                filled: true,
                                hintText: "Enter password",
                                fillColor: Colors.amberAccent,
                                enabled: true,
                                focusColor: Colors.yellow,
                                hoverColor: Colors.white),
                            onChanged: (val) {
                              setState(() {
                                password = val;
                                error = 0;
                              });
                            }),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        GestureDetector(
                          onTap: () {
                            validate();
                          },
                          child: Container(
                            child: Center(
                              child: Text(
                                'Sign in',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            height: 28,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.amberAccent),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Text(
                'New User?',
                style: TextStyle(
                    color: Colors.amberAccent,
                    decoration: TextDecoration.underline,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                'Register with',
                style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )),
              Row(
                children: [
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(left: 95, top: 10),
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/google.jpg'),
                            fit: BoxFit.cover),
                        shape: BoxShape.circle,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        spinner = true;
                      });

                      signInWithGoogle().then((result) {
                        if (result != null) {
                          myInd = result.indexOf("lastSignInTime: ");
                          time = result.substring(myInd + 16, myInd + 26);
                          setState(() {
                            spinner = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => (DoctorScreen())));
                        } else {
                          print('');
                        }
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (RegistrationScreen())));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 60, top: 10),
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/email.png'),
                            fit: BoxFit.cover),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
