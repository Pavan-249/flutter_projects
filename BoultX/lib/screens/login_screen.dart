import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
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
      'Invalid Email or Password',
      style: TextStyle(color: Colors.red, fontSize: 20),
    ),
  ),
];

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  String user, password;
  final auth = FirebaseAuth.instance;
  AnimationController controller;
  Animation animation;
  User fire;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFF69B4),
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
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(decorationColor: Colors.black),
                onChanged: (value) {
                  user = value;
                  setState(() {
                    crct = 0;
                  });
                  //Do something with the user input.
                },
                decoration: kdecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
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
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        spinner = true;
                      });
                      try {
                        final n_user = await auth.signInWithEmailAndPassword(
                            email: user, password: password);
                        if (n_user != null) {
                          Navigator.pushNamed(context, 'chat_screen');
                        }
                        setState(() {
                          spinner = false;
                        });
                      } catch (e) {
                        setState(() {
                          crct = 1;
                          spinner = false;
                        });
                        print('Invalid Email or Password');
                      }
                      //Implement login functionality.
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Log In',
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
