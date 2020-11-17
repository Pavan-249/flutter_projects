import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

int crct = 0;
bool spinner = false;
List checker = [
  SizedBox(
    height: 24,
  ),
  Container(
    margin: EdgeInsets.all(15),
    height: 24,
    child: Text(
      'Invalid Email',
      style: TextStyle(color: Colors.red, fontSize: 20),
    ),
  ),
];

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  String user, password;
  final auth = FirebaseAuth.instance;
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    animation =
        ColorTween(begin: Colors.amber, end: Colors.red).animate(controller);
    animation.addListener(() {
      setState(() {});
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          controller.reverse();
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          controller.forward();
        });
      }
    });
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    setState(() {});
    Firebase.initializeApp();
    return Scaffold(
      backgroundColor: Color(0xff6495ed),
      body: ModalProgressHUD(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'alpha',
                child: Container(
                  height: 200.0,
                  child: Image(
                    image: AssetImage('images/logo.png'),
                    color: animation.value,
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  user = value;
                  setState(() {
                    crct = 0;
                  });
                  //Do something with the user input.
                },
                decoration: kdecoration.copyWith(hintText: 'Enter email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                  setState(() {
                    crct = 0;
                  });
                  //Do something with the user input.
                },
                decoration: kdecoration.copyWith(hintText: 'Enter password'),
              ),
              checker[crct],
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      var checker = EmailValidator.validate(user);
                      try {
                        if (checker == true) {
                          setState(() {
                            spinner = true;
                          });
                          print(user);
                          final new_user =
                              await auth.createUserWithEmailAndPassword(
                                  email: user, password: password);
                          Navigator.pushNamed(context, 'chat_screen');

                          setState(() {
                            spinner = false;
                          });
                        } else {
                          throw 'Invalid Email';
                        }
                      } catch (e) {
                        setState(() {
                          crct = 1;
                          spinner = false;
                        });
                        print(e);
                      }
                      //Implement registration functionality.
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        inAsyncCall: spinner,
      ),
    );
  }
}
