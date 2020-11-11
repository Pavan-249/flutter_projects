//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Error_handler extends StatefulWidget {
  @override
  _Error_handlerState createState() => _Error_handlerState();
}

class _Error_handlerState extends State<Error_handler> {
  @override
  Widget build(BuildContext context) {
    alterr(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Text('rocky'),
      ),
    );
  }
}

void alterr(BuildContext context) {
  Alert(
      context: context,
      title: 'Turn on Data',
      desc: 'Turn on location and Data',
      buttons: [
        DialogButton(
          color: Colors.blue,
          child: Text(
            '⚙️   Go to Settings',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onPressed: (() async {
            await AppSettings.openWIFISettings();
          }),
        ),
      ]).show();
}
