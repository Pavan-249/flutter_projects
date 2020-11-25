import 'dart:io';

import 'package:digiclck/Networking.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

var apikey = 'bb109f830fc74f34b705334b49ac14da';
var url = 'https://newsapi.org/v2/top-headlines?country=in';

NetworkHelper networkHelper = NetworkHelper('$url&apiKey=$apikey');

List<String> l_news = ['Hello', 'Hold On...'];
List<String> l_imgs = [];
List<dynamic> l_cnt_imgs = [
  NetworkImage(
      'https://e0.365dm.com/20/05/2048x1152/skysports-brendon-mccullum_4986141.jpg'),
  NetworkImage(
      'https://e0.365dm.com/20/05/2048x1152/skysports-brendon-mccullum_4986141.jpg')
];
int counter = 0;
int cntr = 0;
bool pinner = false;
String datetime;
var date;
var time;

class News_Screen extends StatefulWidget {
  @override
  _News_ScreenState createState() => _News_ScreenState();
}

class _News_ScreenState extends State<News_Screen> {
  Future<void> getNews() async {
    try {
      var news = await networkHelper.jDecode();
      if (news != null) {
        for (int i = 0; i < 20; i++) {
          var news_body = news['articles'][i]['title'];
          var news_imgs = news['articles'][i]['urlToImage'];
          l_imgs.add(news_imgs);
          l_news.add(news_body.toString());
        }
      } else {
        print('moeen');
      }
    } catch (e) {
      print('erumai nee dhanna');
    }
  }

  String getTime() {
    setState(() {
      datetime = DateTime.now().toString();
      date = datetime.substring(0, 11);
      time = datetime.substring(11, 16);
    });
  }

  void spin() {
    setState(() {
      pinner = false;
    });
  }

  void spinner() {
    setState(() {
      pinner = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    getNews();
    getTime();
    imgDisplay(counter);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.indigo[900],
        body: ModalProgressHUD(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 500,
                  //width: 400,
                  color: Colors.indigo[900],
                  child: Center(
                      child: Text(
                    l_news[cntr],
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.amber,
                        fontFamily: 'Carter',
                        fontWeight: FontWeight.w900),
                  )),
                ),
              ),
              Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: l_cnt_imgs[counter], fit: BoxFit.fill),
                ),
              ),
              Container(
                color: Colors.indigo[900],
                height: 50,
                child: Center(
                  child: Text(
                    'Courtesy:BBC News',
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
              ),
              Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        child: Image(
                          image: AssetImage('assets/left.jpg'),
                        ),
                        onTap: () {
                          setState(() {
                            if (counter > 0 && cntr > 0) {
                              counter--;
                              cntr--;
                            } else {
                              print(counter);
                            }
                          });
                        }),
                    Text(
                      time,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                          fontFamily: 'Carter'),
                    ),
                    GestureDetector(
                        child: Image(
                          image: AssetImage('assets/right.jpg'),
                        ),
                        onTap: () {
                          setState(() {
                            if (counter < l_cnt_imgs.length &&
                                cntr < l_imgs.length) {
                              counter++;
                              cntr++;
                            } else {
                              print(counter);
                            }
                          });
                        }),
                  ],
                ),
              )
            ],
          ),
          inAsyncCall: pinner,
        ),
      ),
    );
  }
}

void imgDisplay(int i) async {
  try {
    var img = await NetworkImage(l_imgs[i - 1]);
    l_cnt_imgs.add(img);
  } catch (e) {
    print('e');
  }
}
