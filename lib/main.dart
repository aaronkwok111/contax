import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
      int pickedDay = prefs.getInt('DAYS');
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Home(date,pickedDay)));
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
  int pickedDays;
  DateTime daysCase;
  Home(selectedDate,pickedDays,daysCase)
  {
    this.selectedDate = selectedDate;
    this.pickedDays = pickedDays;
    this.daysCase = daysCase;
    if((this.selectedDate.difference(DateTime.now()).inDays/pickedDays).abs() <0 || (this.selectedDate.difference(DateTime.now()).inDays/pickedDays).abs() >=1)
      {
        this.pickedDays = 1000;
      }
    if((this.daysCase.difference(DateTime.now()).inDays/pickedDays).abs() <0 || (this.daysCase.difference(DateTime.now()).inDays/pickedDays).abs() >=1)
    {
      this.pickedDays = 1000;
    }
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.indigo[800],
      body: SingleChildScrollView(
        child: Column(
            children:<Widget>[
              Container(
                  padding:EdgeInsets.fromLTRB(25,50,0,0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("HELLO",
                          style: TextStyle(color: Colors.white,fontSize:28, fontFamily: 'Roboto', fontWeight: FontWeight.bold, letterSpacing: 3))
                  )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(25,0,0,0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Nice to see you",
                          style: TextStyle(color: Colors.indigo[100], fontSize:21, fontFamily:'Roboto'))
                  )
              ),

              Align(
                child:Container(
                  padding: EdgeInsets.fromLTRB(0,20,0,30),
                  width:150,
                  height:150.0,
                  child: FloatingActionButton(
                    child: Text('Track My Contacts',
                        style: TextStyle(fontSize: 7.0)),
                    backgroundColor: Colors.indigoAccent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => config()),
                      );
                    },
                  ),
                )
              ),
              Container(
                child:CircularPercentIndicator(
                  radius: 275.0,
                  lineWidth: 18.0,
                  animation: true,
                  percent: (selectedDate.difference(DateTime.now()).inDays/pickedDays).abs(),
                  center:

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        '${selectedDate.difference(DateTime.now()).inDays.abs()}',
                        style:
                        new TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 75.0),
                      ),
                      new Text(
                        'DAYS LEFT BITCH ASS',
                        style:
                        new TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 15.0),
                      )
                    ],
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.indigoAccent,
                  backgroundColor: Colors.indigo[100],
                ),
              ),
              Container(
                padding: EdgeInsets.all(30),
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
                  progressColor: Colors.indigoAccent,
                  backgroundColor: Colors.indigo[100],
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
                  progressColor: Colors.indigoAccent,
                  backgroundColor: Colors.indigo[100],
                ),
              )
            ]
        )
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
      int timeMil = picked.millisecondsSinceEpoch;
      prefs.setInt('DATE',timeMil);
      print("success");
    }
  }
  Future<Null> _selectDateCase(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int timeMil = picked.millisecondsSinceEpoch;
      prefs.setInt('DATE_CASE',timeMil);
      print("case");
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.indigo[800],
      body: SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                width: 200.0,
                height: 200.0,
                child: FloatingActionButton(
                  heroTag: "c",
                    backgroundColor: Colors.indigoAccent,
                    child: Text("When did you last change your contacts",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 8.0)),
                    onPressed: () => _selectDate(context)
                )
            ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        padding:EdgeInsets.all(10),
                        width:100.0,
                        height: 100.0,
                        child: FloatingActionButton(
                          heroTag: "a",
                          child:Text('Biweekly'),
                          backgroundColor: Colors.indigoAccent,
                          onPressed: (){
                            SharedPreferences.getInstance().then((prefs){
                              prefs.setInt("DAYS", 14);
                            });
                          },
                        )
                    ),
                    Container(
                        padding:EdgeInsets.all(10),
                        width:100.0,
                        height: 100.0,
                        child: FloatingActionButton(
                          heroTag: "b",
                          backgroundColor: Colors.indigoAccent,
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
            ),
            Container(
                width: 200.0,
                height: 200.0,
                child: FloatingActionButton(
                    heroTag: "c",
                    backgroundColor: Colors.indigoAccent,
                    child: Text("When did you last change your case",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 8.0)),
                    onPressed: () => _selectDateCase(context)
                )
            ),
            Container(
                width: 200.0,
                height: 200.0,
                child: FloatingActionButton(
                  heroTag: "d",
                  backgroundColor: Colors.indigoAccent,
                    child: Text("NEXT",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 8.0)),
                    onPressed: () {
                      SharedPreferences.getInstance().then((prefs){
                        int dateMillis = prefs.getInt('DATE');
                        DateTime date = DateTime.fromMillisecondsSinceEpoch(dateMillis);
                        int days = prefs.getInt('DAYS');
                        int caseMillis = prefs.getInt('DATE_CASE');
                        DateTime caseDate = DateTime.fromMillisecondsSinceEpoch(caseMillis);
                        print(date);
                        print(days);
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home(date,days,caseDate))
                        );

                      });
                    }
            ),
            )
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int dateMillis = picked.millisecondsSinceEpoch;
      prefs.setInt('DATE',dateMillis);
      int pickedDays = prefs.getInt('DAYS');
      int caseMillis = prefs.getInt('DATE_CASE');
      DateTime caseDate = DateTime.fromMillisecondsSinceEpoch(caseMillis);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder:(context) => Home(picked,pickedDays,caseDate)
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
                    SharedPreferences.getInstance().then((prefs){
                      int pickedDays = prefs.getInt('DAYS');
                      int dateMillis = prefs.getInt('DATE');
                      DateTime date = DateTime.fromMillisecondsSinceEpoch(dateMillis);
                      int caseMillis = prefs.getInt('DATE_CASE');
                      DateTime caseDate = DateTime.fromMillisecondsSinceEpoch(caseMillis);
                      Navigator.push(context,MaterialPageRoute(
                          builder:(context) => Home(date,pickedDays,caseDate)));
                    });

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
