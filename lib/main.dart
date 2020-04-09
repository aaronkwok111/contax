import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
//import 'package:custom_radio/custom_radio.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      color: Colors.blue,
      home: new Splash(),
    );
  }
}
class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}
class SplashState extends State<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      // var dateEncoded = prefs.getString('pickedDate');
      //DateTime date = jsonDecode(dateEncoded);
      int timeMillis = prefs.getInt('DATE');
      DateTime date = DateTime.fromMillisecondsSinceEpoch(timeMillis);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Home(date)));
    } else {
      /*DateTime dateDecoded = DateTime.now();
       String dateEncoded = jsonEncode(dateDecoded);
       prefs.setString('pickedDate', )*/
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroScreen()));
    }
  }
  void setDays(int days) async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setInt('days',days);
  }
  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 200), () {
      checkFirstSeen();
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Loading...'),
      ),
    );
  }
}
