import 'package:flutter/material.dart';
import 'input_page.dart';
//import 'input_page.dart';

class Resultpage extends StatefulWidget {
  final List l;
  Resultpage({@required this.l});

  @override
  _ResultpageState createState() => _ResultpageState();
}

class _ResultpageState extends State<Resultpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 90, vertical: 10),
        height: 60,
        color: Color(0xFFFF1654),
        child: GestureDetector(
          child: Text(
            'RECALCULATE',
            style: TextStyle(fontSize: 23, color: Colors.white),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => calc_1()),
            ).then((value) => setState(() {}));

            // Navigator.pop(context).then((value) => setState(() {}));;
          },
        ),
      ),
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFFF1654),
            ),
            height: 400,
            width: 150,
            //padding: EdgeInsets.symmetric(horizontal: 120, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SafeArea(
                  child: Text(
                    bmi_calc(widget.l),
                    style: TextStyle(fontSize: 60, fontFamily: 'Architect'),
                  ),
                ),
                /* SafeArea(
                  child: SizedBox(
                    height: 40,
                  ),
                ),*/
                Expanded(
                  child: Text(
                    bmi_review(widget.l),
                    style: TextStyle(fontSize: 50, fontFamily: 'Ltim'),
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                SafeArea(
                  child: Text(
                    bmi_tips(widget.l),
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

String bmi_calc(List lrs) {
  print(lrs);
  double dsc = lrs[1] / ((lrs[0] / 100) * (lrs[0] / 100));
  lrs.add(dsc);
  return dsc.toStringAsFixed(1);
}

String bmi_review(List lrs) {
  String value;
  if (lrs[2] > 30) {
    value = 'Obese';
  } else if (lrs[2] > 18 && lrs[2] < 26) {
    value = 'Normal';
  } else if (lrs[2] > 25 && lrs[2] < 31) {
    value = 'Overweight';
  } else {
    print(lrs[2]);
    value = 'Underweight';
  }
  lrs.add(value);
  return value;
}

String bmi_tips(List lrs) {
  String vlr;
  if (lrs[3] == 'Obese') {
    vlr = 'Consultation needed, follow a diet plan!';
  }
  if (lrs[3] == 'Normal') {
    vlr = 'You are healthy, keep exercising to stay fit!';
  }
  if (lrs[3] == 'Overweight') {
    vlr = 'Don\'t worry , exercising regularly can make you normal!';
  }
  if (lrs[3] == 'Underweight') {
    vlr = 'Start consuming food with high proteins and carbohydrates!';
  }
  lrs.add(vlr);
  return vlr;
}
