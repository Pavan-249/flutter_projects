import 'package:flutter/material.dart';

class CityError extends StatefulWidget {
  @override
  _CityErrorState createState() => _CityErrorState();
}

class _CityErrorState extends State<CityError> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'City Not Found,Try again!!',
              style: TextStyle(color: Colors.white70),
            ),
            backgroundColor: Colors.pink,
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/tenor.gif'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    color: Colors.pink,
                    child: GestureDetector(
                      child: Center(
                        child: Text(
                          'Return',
                          style: TextStyle(color: Colors.white70, fontSize: 45),
                        ),
                      ),
                      onTap: (() {
                        setState(() {
                          Navigator.pop(context);
                        });
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
