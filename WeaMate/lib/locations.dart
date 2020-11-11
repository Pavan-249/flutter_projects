import 'package:WeaMate/secondpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'constant_s.dart';
import 'package:WeaMate/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:WeaMate/errorPagee.dart';

class Loc_met extends StatefulWidget {
  String weather_type;
  int temperature;
  String city;

  @override
  _Loc_metState createState() => _Loc_metState();
}

class _Loc_metState extends State<Loc_met> {
  double latitude;
  double longitude;
  void initState() {
    super.initState();
    getPosWeather();
  }

  Future<void> getPosWeather() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      latitude = position.latitude;
      longitude = position.longitude;
      NetworkHelper networkHelper = NetworkHelper(
          'http://$url?lat=$latitude&lon=$longitude&appid=4f98103af2434d7cce3163278ccf75ff&units=metric');
      var vrs = await networkHelper.helper();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SecondPage(
                    weather_info: vrs,
                  )));
    } catch (e) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Error_handler()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child: SpinKitChasingDots(
          color: Colors.red,
        ),
      ),
    );
  }
}
