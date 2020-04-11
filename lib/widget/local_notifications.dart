import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:login/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LocalNotificationWidget extends StatefulWidget {
  @override
  _LocalNotificationWidgetState createState() =>
      _LocalNotificationWidgetState();
}
class _LocalNotificationWidgetState extends State<LocalNotificationWidget> {
  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    final settingsAndroid = AndroidInitializationSettings('icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int dateMillis = prefs.getInt('DAYS');
    DateTime selectedDate = DateTime.fromMillisecondsSinceEpoch(dateMillis);
    int caseMillis = prefs.getInt('DATE_CASE');
    DateTime daysCase = DateTime.fromMillisecondsSinceEpoch(caseMillis);
    int pickedDays = prefs.getInt("DAYS");
    if(pickedDays == 14) {
      selectedDate.add(Duration(days:14));
    }
    else{
      selectedDate.add(Duration(days:30));
    }
    dateMillis = selectedDate.millisecondsSinceEpoch;
    prefs.setInt('DATE', dateMillis);

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home(selectedDate, pickedDays, daysCase)),
    );

  }


}