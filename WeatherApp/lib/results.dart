import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:new_geolocation/geolocation.dart';
//import 'package:location/location.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  /*void getLocation() async {
    print('hi');
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    LocationPermission permission = await Geolocator.requestPermission();
    print(position);
    print('raci');
  }*/
  void getLocation() async {
    LocationResult result = await Geolocation.lastKnownLocation();
    print('hey');
    if (result.isSuccessful) {
      // location request successful, location is guaranteed to not be null
      double lat = result.location.latitude;
      double lng = result.location.longitude;
      print(lat);
      print(lng);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            color: Colors.red,
          ),
        ),
        //Text(getLocation(),
        FlatButton(
          onPressed: () {
            setState(() {
              getLocation();
            });
          },
          child: Text('hello hey'),
          color: Colors.amber,
        )
      ],
    );
  }
}
