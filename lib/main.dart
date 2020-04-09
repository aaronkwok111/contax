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
class IntroScreen extends StatelessWidget {
  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      /*var jsonEncoded  = jsonEncode(picked);
      prefs.setString('DATE',jsonEncoded);
      String d = prefs.getString('DATE');*/
      int timeMil = picked.millisecondsSinceEpoch;
      prefs.setInt('DATE',timeMil);
      int a = prefs.getInt('DATE');
      DateTime date = DateTime.fromMillisecondsSinceEpoch(a);
      print(date);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder:(context) => new Home(picked)
          )
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text('This is the intro page'),

            Container(
                width: 200.0,
                height: 200.0,
                child: FloatingActionButton(
                    child: Text("When did you last change your contacts",
                        style: TextStyle(fontSize: 10.0)),
                    onPressed: () => _selectDate(context)
                )
            ),
          ],
        ),
      ),
    );
  }
}
class config extends StatelessWidget {
  int days = 1;
  DateTime selectedDate = DateTime.now();
  String date;
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      /*SharedPreferences prefs = await SharedPreferences.getInstance();
      var jsonEncoded  = jsonEncode(picked);
      prefs.setString('pickeddate',jsonEncoded);*/
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int dateMillis = picked.millisecondsSinceEpoch;
      prefs.setInt('DATE',dateMillis);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder:(context) => Home(picked)
          )
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: <Widget>[
              Center(
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Go back!'),
                ),
              ),
              Container(
                  child: RaisedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('select date'),
                  )
              ),
              Row(
                children: <Widget>[
                  Container(
                      width:100.0,
                      height: 100.0,
                      child: FloatingActionButton(
                        heroTag: "a",
                        child:Text('Biweekly'),
                        onPressed: (){
                          SharedPreferences.getInstance().then((prefs){
                            prefs.setInt("DAYS", 14);
                          });
                        },
                      )
                  ),
                  Container(
                      width:100.0,
                      height: 100.0,
                      child: FloatingActionButton(
                        heroTag: "b",
                        child:Text('Monthly'),
                        onPressed: (){
                          SharedPreferences.getInstance().then((prefs){
                            prefs.setInt('DAYS', 30);
                          });

                        },
                      )
                  )
                ],
              )

            ]
        )
    );
  }
}
