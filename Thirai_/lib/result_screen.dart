import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thirai/movie_screen.dart';
import 'package:thirai/networking.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:marquee/marquee.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

String json_dec;
bool spinner = false;
var ry = '';
var poster = 'https://wallpapercave.com/wp/wp3188315.jpg';
var lang = '';
var awards = '';
var ratings = '';
var director = '';
var cast = 'We are loading ....meanwhile grab some popcorn';
var cust_string = 'Thanks for your patience...';

class Result_screen extends StatefulWidget {
  @override
  _Result_screenState createState() => _Result_screenState();
}

class _Result_screenState extends State<Result_screen> {
  @override
  void initState() {
    Movie_Scr movie_scr = Movie_Scr();
    json_dec = movie_scr.get_search().toString();
    setState(() {
      spinner = true;
    });
    UpdateUI();
  }

  dynamic UpdateUI() async {
    setState(() {
      spinner = true;
    });
    try {
      NetworkHelper networkHelper = await NetworkHelper(
          url: 'https://www.omdbapi.com/?t=$json_dec&apikey=a18820e0');
      var stub = await networkHelper.jDecode();
      ry = stub['Year'];
      director = stub['Director'];
      lang = stub['Language'];
      awards = stub['Awards'];
      cast = stub['Actors'];
      poster = stub['Poster'];
      ratings = stub['imdbRating'];
      cust_string =
          director + '   ' + ry + '    ' + lang + '   ' + awards + '  ';

      setState(() {
        spinner = false;
      });
      return stub;
    } catch (e) {
      alterr(context);
    }
  }

  void alterr(BuildContext context) {
    Alert(context: context, title: 'ramesh').show();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.blue,
      home: ModalProgressHUD(
        color: Colors.amber,
        child: MyApp(),
        inAsyncCall: spinner,
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(poster), fit: BoxFit.contain)),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 692, 0, 0),
            child: Marquee(
              crossAxisAlignment: CrossAxisAlignment.start,
              text: cust_string,
              style: TextStyle(fontFamily: 'Carter', fontSize: 25),
            ),
          ),
          Container(
            color: Colors.black,
            margin: EdgeInsets.fromLTRB(175, 642, 150, 0),
            child: Text(
              ratings,
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.amber,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Marquee(
              text: cast,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.pink,
                  fontSize: 25),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 20.0,
              velocity: 150.0,
              pauseAfterRound: Duration(milliseconds: 500),
              showFadingOnlyWhenScrolling: true,
              fadingEdgeStartFraction: 0.1,
              fadingEdgeEndFraction: 0.1,
              numberOfRounds: null,
              startPadding: 10.0,
              accelerationDuration: Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
        ],
      ),
    );
  }
}
