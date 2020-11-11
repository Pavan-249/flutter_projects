import 'package:WeaMate/cityerror.dart';
import 'package:WeaMate/networking.dart';
import 'package:flutter/material.dart';
import 'locations.dart';
import 'citypage.dart';
import 'cityerror.dart';

class SecondPage extends StatefulWidget {
  SecondPage({this.weather_info});
  var weather_info;
  @override
  _SecondPageState createState() => _SecondPageState();
}

Loc_met loc_met = Loc_met();
String w_city;
String w_desc;
var w_temp;
String w_temp1;
int w_id;

class _SecondPageState extends State<SecondPage> {
  void UpdateUI(dynamic weather_info) {
    setState(() {
      if (weather_info == null) {
        w_city = 'Unknown';
        w_desc = 'Unable to fetch weather \n at the moment';
        w_temp = 0;
        w_id = 001;
      }
      w_city = weather_info['name'];
      w_desc = weather_info['weather'][0]['main'];
      w_temp = weather_info['main']['temp'];
      w_temp1 = w_temp.toInt().toString();
      w_id = weather_info['weather'][0]['id'];
    });
  }

  double checker(int r) {
    if (r > 800) {
      return 9;
    } else if (r == 800) {
      return 8;
    } else if (r > 700) {
      return 7;
    } else if (r > 600) {
      return 6;
    } else if (r > 500) {
      return 5;
    } else if (r > 300) {
      return 3;
    } else if (r > 200) {
      return 8;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    UpdateUI(widget.weather_info);
    int c = checker(w_id).toInt();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/$c.gif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatButton(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                    child: Icon(
                      Icons.near_me,
                      color: Colors.deepPurpleAccent[700],
                      size: 50,
                    ),
                  ),
                  onPressed: (() async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Loc_met();
                    }));
                  }),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                    child: Icon(
                      Icons.location_city,
                      color: Colors.deepPurpleAccent[700],
                      size: 50,
                    ),
                  ),
                  onTap: (() async {
                    var citypg = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CityPage()));
                    try {
                      NetworkHelper networkHelper = NetworkHelper(
                          'http://api.openweathermap.org/data/2.5/weather?q=$citypg&appid=4f98103af2434d7cce3163278ccf75ff&units=metric');
                      var new_city = await networkHelper.helper();
                      setState(() {
                        widget.weather_info = new_city;
                        UpdateUI(widget.weather_info);
                      });
                    } catch (e) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CityError()));
                    }
                  }),
                ),
              ],
            ),
            Container(
                width: 500,
                margin: EdgeInsets.fromLTRB(150, 75, 0, 0),
                child: Text(
                  w_temp1 + '°',
                  style: TextStyle(
                      color: Colors.pink,
                      fontSize: 80,
                      fontFamily: 'Syne',
                      fontWeight: FontWeight.w900),
                )),
            Container(
              width: 500,
              margin: EdgeInsets.fromLTRB(30, 170, 0, 0),
              child: SafeArea(
                child: Text(
                  w_city,
                  style: TextStyle(
                      color: Colors.pink,
                      fontSize: 60,
                      fontFamily: 'Shadows',
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            Container(
              width: 500,
              margin: EdgeInsets.fromLTRB(50, 270, 0, 0),
              child: SafeArea(
                child: Text(
                  w_desc,
                  style: TextStyle(
                      color: Colors.pink,
                      fontSize: 60,
                      fontFamily: 'Shadows',
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
