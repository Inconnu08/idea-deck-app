import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:idea_deck/constants.dart';
import 'package:idea_deck/screens/profile.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future initializetimezone() async {
  tz.initializeTimeZones();
}

class NotificationService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  BuildContext context;

  //initilize

  Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("ic_launcher");

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: notificationSelected);
  }

  //Instant Notifications
  Future instantNofitication() async {
    var android = AndroidNotificationDetails("id-1", "channeli", "description");

    var ios = IOSNotificationDetails();

    var platform = new NotificationDetails(android: android, iOS: ios);

    await _flutterLocalNotificationsPlugin.show(
        0, "Demo instant notification", "Tap to do something", platform,
        payload: "Welcome to demo app");
  }

  //Image notification
  Future imageNotification() async {
    var bigPicture = BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("ic_launcher"),
        largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
        contentTitle: "Demo image notification",
        summaryText: "This is some text",
        htmlFormatContent: true,
        htmlFormatContentTitle: true);

    var android = AndroidNotificationDetails("id", "channel", "description",
        styleInformation: bigPicture);

    var platform = new NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.show(
        0, "Demo Image notification", "Tap to do something", platform,
        payload: "Welcome to demo app");
  }

  //Stylish Notification
  Future stylishNotification() async {
    var android = AndroidNotificationDetails("id", "channel", "description",
        color: Colors.deepOrange,
        enableLights: true,
        enableVibration: true,
        largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
        styleInformation: MediaStyleInformation(
            htmlFormatContent: true, htmlFormatTitle: true));

    var platform = new NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.show(
        0, "Demo Stylish notification", "Tap to do something", platform);
  }

  //Scheduled Notification

  Future scheduledNotification(
      {@required String time,
      @required int qid,
      @required String brand}) async {
    await initializetimezone();
    // instantNofitication();
    //stylishNotification();
    // var locale = tz.getLocation('Bangladesh/Dhaka');
    // print(locale);
    // print('18/05/2021 9:31 PM');
    var d = DateFormat('d/M/yyyy h:m a').parse(time);
    // print(d.day);
    // tz.TZDateTime zonedTime =
    //     tz.TZDateTime.local(d.year, d.month, d.day, d.hour, d.minute);
    // print(zonedTime);
    // var interval = RepeatInterval.everyMinute;
    // var bigPicture = BigPictureStyleInformation(
    //     DrawableResourceAndroidBitmap("ic_launcher"),
    //     largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
    //     contentTitle: "Demo image notification",
    //     summaryText: "This is some text",
    //     htmlFormatContent: true,
    //     htmlFormatContentTitle: true);

    // var android = AndroidNotificationDetails("id", "channel", "description",
    //     styleInformation: bigPicture);

    // var androidChannel = AndroidNotificationDetails(
    //     'App', "Notifications", 'Customize',
    //     importance: Importance.max,
    //     priority: Priority.high,
    //     playSound: true,
    //     enableLights: true,
    //     ongoing: false,
    //     visibility: NotificationVisibility.public,
    //     styleInformation: bigPicture);
    // var iosChannel = IOSNotificationDetails();
    // var platfromChannel =
    //     NotificationDetails(android: androidChannel, iOS: iosChannel);
    var bigPicture = BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("trophy"),
        largeIcon: DrawableResourceAndroidBitmap("trophy_small"),
        contentTitle: "<h1>Winner has been announced!</h1>",
        summaryText: "Find out if you won the draw from Pizzahut",
        htmlFormatContent: true,
        htmlFormatContentTitle: true);

    var android = AndroidNotificationDetails(
      "com.ideadeck.idea_deck",
      "channel",
      "description",
      color: kPrimaryColor,
      enableLights: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      ongoing: false,
      visibility: NotificationVisibility.public,
      // largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
      styleInformation: bigPicture,
    );

    var platform = new NotificationDetails(android: android);
    // var platform =
    //     NotificationDetails(android: androidChannel, iOS: iosChannel);

    await _flutterLocalNotificationsPlugin.schedule(
      2,
      "Winner has been announced!",
      "Find out if you won the draw from $brand",
      d,
      platform,
      payload: qid.toString(),
      androidAllowWhileIdle: true,
    );
  }

  //Cancel notification

  Future cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  Future notificationSelected(String payload) async {
    print('payload $payload');
    Navigator.pushNamed(context, ProfileScreen.routeName);
  }
}
