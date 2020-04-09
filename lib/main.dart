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
class Home extends StatelessWidget {

  DateTime selectedDate;
  Home(selectedDate)
  {
    this.selectedDate = selectedDate;
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
          children:<Widget>[
            Container(
                padding:EdgeInsets.fromLTRB(0,20,0,0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Hello!",
                        style: TextStyle(fontSize:40))
                )
            ),
            Container(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Nice to see you",
                        style: TextStyle(fontSize:25))
                )
            ),
            Container(
              width:125,
              height:125.0,
              child: FloatingActionButton(
                child: Text('Track My Contacts',
                    style: TextStyle(fontSize: 10.0)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => config()),
                  );
                },
              ),
            ),
            Container(
              child:CircularPercentIndicator(
                radius: 250.0,
                lineWidth: 13.0,
                animation: true,
                percent: .7, //(selectedDate.difference(DateTime.now()).inDays/30).abs(),
                center:
                new Text(
                  '${selectedDate.difference(DateTime.now()).inDays.abs()}',
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.blue,
              ),
            ),
            Text(
                'hello'
            ),

            Row(
                children: <Widget>[
                  Container(
                    child:CircularPercentIndicator(
                      radius: 150.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: 0.7,
                      center: new Text(
                        "70.0%",
                        style:
                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.blue,
                    ),
                  ),
                  Container(
                    child:CircularPercentIndicator(
                      radius: 150.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: 0.7,
                      center: new Text(
                        "70.0%",
                        style:
                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.blue,
                    ),
                  )
                ]
            )
          ]
      ),
    );
  }
}
