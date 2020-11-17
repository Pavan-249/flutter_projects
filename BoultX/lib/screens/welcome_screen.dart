import 'package:flutter/material.dart';
import 'components.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
    controller.addStatusListener((status) {
      print(status);
    });
    animation = ColorTween(end: Colors.blueAccent, begin: Colors.pinkAccent)
        .animate(controller);
    animation.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'alpha',
                  child: Container(
                      child: Image.asset('images/logo.png'),
                      height:
                          50 //animation.value * 100, //controller.value * 100,
                      ),
                ),
                Expanded(
                  child: ColorizeAnimatedTextKit(
                    colors: [Colors.amber[200], Colors.orange, Colors.red],
                    text: ['BOULT_X', 'The Social App', 'BOULT_X'],
                    speed: Duration(milliseconds: 140),
                    textStyle: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Shojumaru'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                color: Colors.lightBlueAccent,
                text: Text('Login'),
                onPressed: () {
                  Navigator.pushNamed(context, 'login_screen');
                }),
            RoundedButton(
                color: Colors.cyan[300],
                text: Text('Register'),
                onPressed: () {
                  Navigator.pushNamed(context, 'registration_screen');
                }),
          ],
        ),
      ),
    );
  }
}
