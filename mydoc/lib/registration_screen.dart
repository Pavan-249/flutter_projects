import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'doctor_screen.dart';
import 'package:firebase_core/firebase_core.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String email = '', password = '';
int error = 0;
bool spinner = false;

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
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
        final newUser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (newUser != null) {
          setState(() {
            spinner = false;
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => (DoctorScreen())));
        }
      } catch (e) {
        setState(() {
          error = 1;
          spinner = false;
        });
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ModalProgressHUD(
          inAsyncCall: spinner,
          child: Stack(
            children: [
              Container(
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
                                  fontSize: 50,
                                  fontFamily: "Canterbury",
                                  decorationColor: Colors.green,
                                  color: Colors.red,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                                    hintText: "Enter E-mail",
                                    // errorText: error == 1
                                    //     ? 'Invalid email or password'
                                    //     : '',
                                    icon: Icon(
                                      Icons.email_sharp,
                                      color: Colors.amber,
                                    ),
                                    filled: true,
                                    fillColor: Colors.amberAccent,
                                    focusColor: Colors.yellow,
                                    hoverColor: Colors.white),
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                    error = 0;
                                  });
                                }),
                            SizedBox(
                              height: 26,
                            ),
                            TextField(
                                obscureText: true,
                                cursorColor: Colors.red,
                                style: TextStyle(
                                    color: Colors.red[600],
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    //errorText:
                                    errorText: error == 1
                                        ? 'Invalid email or password'
                                        : '',
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
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                    error = 0;
                                  });
                                }),
                            GestureDetector(
                              onTap: () {
                                validate();
                              },
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'Sign up',
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
                  GestureDetector(
                    child: Center(
                        child: Text(
                      'Sign in instead',
                      style: TextStyle(
                          color: Colors.amberAccent,
                          fontSize: 25,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold),
                    )),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
