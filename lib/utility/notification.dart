

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'dart:io' show File, Platform;

class NotificationApi {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initializationSettings;
  NotificationApi._() {
    init();
  }

  init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      _requestIosPermission();
    }
    initializePlatformSpecify();
  }

  initializePlatformSpecify() {
    try{
      var initializationSettingAndroid =
      const AndroidInitializationSettings("ic_stat_name_crm");

      ReceicvedNotification receicvedNotificatin;
      var initializationSettingIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          receicvedNotificatin = ReceicvedNotification(
              id: id, body: body, title: title, payload: payload);
        },
      );
      initializationSettings = InitializationSettings(
          android: initializationSettingAndroid, iOS: initializationSettingIOS);
    }catch(e){
      print(e.toString());
    }

  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
          onNotificationClick(payload);
        });
  }

  _requestIosPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> showNotification(id,title,body,payload) async {
    try{
      var androidChannelSpecify = const AndroidNotificationDetails(
        "Channel_Id1",
        "Channel_Name2",
        channelDescription: "Channel_Description2",
        importance: Importance.max,
        priority: Priority.high,
        icon: 'ic_stat_name_crm',
        color:Color.fromARGB(20, 4, 94, 116),
      );
      var iosChannelSpecify = IOSNotificationDetails();
      var platformChannelSpecifies = NotificationDetails(
          android: androidChannelSpecify, iOS: iosChannelSpecify);
      await flutterLocalNotificationsPlugin.show(
          id,
          title,
          body ,
          platformChannelSpecifies,
          payload: payload);
    }catch(e){
      print(e);
    }

  }
}

NotificationApi notificationApi = NotificationApi._();

class ReceicvedNotification {
  late final int? id;
  late final String? body;
  late final String? title;
  late final String? payload;

  ReceicvedNotification(
      {required this.id,
        required this.body,
        required this.title,
        required this.payload});
}

  // Future<void> showDailyAtTime() async {
  //   var time = Time(21, 3, 0);
  //   var androidChannelSpecifics = AndroidNotificationDetails(
  //     'CHANNEL_ID 4',
  //     'CHANNEL_NAME 4',
  //     "CHANNEL_DESCRIPTION 4",
  //     importance: Importance.Max,
  //     priority: Priority.High,
  //   );
  //   var iosChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics =
  //   NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.showDailyAtTime(
  //     0,
  //     'Test Title at ${time.hour}:${time.minute}.${time.second}',
  //     'Test Body', //null
  //     time,
  //     platformChannelSpecifics,
  //     payload: 'Test Payload',
  //   );
  // }
  //
  // Future<void> showWeeklyAtDayTime() async {
  //   var time = Time(21, 5, 0);
  //   var androidChannelSpecifics = AndroidNotificationDetails(
  //     'CHANNEL_ID 5',
  //     'CHANNEL_NAME 5',
  //     "CHANNEL_DESCRIPTION 5",
  //     importance: Importance.Max,
  //     priority: Priority.High,
  //   );
  //   var iosChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics =
  //   NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
  //     0,
  //     'Test Title at ${time.hour}:${time.minute}.${time.second}',
  //     'Test Body', //null
  //     Day.Saturday,
  //     time,
  //     platformChannelSpecifics,
  //     payload: 'Test Payload',
  //   );
  // }
  //
  // Future<void> repeatNotification() async {
  //   var androidChannelSpecifics = AndroidNotificationDetails(
  //     'CHANNEL_ID 3',
  //     'CHANNEL_NAME 3',
  //     "CHANNEL_DESCRIPTION 3",
  //     importance: Importance.Max,
  //     priority: Priority.High,
  //     styleInformation: DefaultStyleInformation(true, true),
  //   );
  //   var iosChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics =
  //   NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.periodicallyShow(
  //     0,
  //     'Repeating Test Title',
  //     'Repeating Test Body',
  //     RepeatInterval.EveryMinute,
  //     platformChannelSpecifics,
  //     payload: 'Test Payload',
  //   );
  // }
  //
  // Future<void> scheduleNotification() async {
  //   var scheduleNotificationDateTime = DateTime.now().add(Duration(seconds: 5));
  //   var androidChannelSpecifics = AndroidNotificationDetails(
  //     'CHANNEL_ID 1',
  //     'CHANNEL_NAME 1',
  //     "CHANNEL_DESCRIPTION 1",
  //     icon: 'secondary_icon',
  //     sound: RawResourceAndroidNotificationSound('my_sound'),
  //     largeIcon: DrawableResourceAndroidBitmap('large_notf_icon'),
  //     enableLights: true,
  //     color: const Color.fromARGB(255, 255, 0, 0),
  //     ledColor: const Color.fromARGB(255, 255, 0, 0),
  //     ledOnMs: 1000,
  //     ledOffMs: 500,
  //     importance: Importance.Max,
  //     priority: Priority.High,
  //     playSound: true,
  //     timeoutAfter: 5000,
  //     styleInformation: DefaultStyleInformation(true, true),
  //   );
  //   var iosChannelSpecifics = IOSNotificationDetails(
  //     sound: 'my_sound.aiff',
  //   );
  //   var platformChannelSpecifics = NotificationDetails(
  //     androidChannelSpecifics,
  //     iosChannelSpecifics,
  //   );
  //   await flutterLocalNotificationsPlugin.schedule(
  //     0,
  //     'Test Title',
  //     'Test Body',
  //     scheduleNotificationDateTime,
  //     platformChannelSpecifics,
  //     payload: 'Test Payload',
  //   );
  // }
  //
  // Future<void> showNotificationWithAttachment() async {
  //   var attachmentPicturePath = await _downloadAndSaveFile(
  //       'https://via.placeholder.com/800x200', 'attachment_img.jpg');
  //   var iOSPlatformSpecifics = IOSNotificationDetails(
  //     attachments: [IOSNotificationAttachment(attachmentPicturePath)],
  //   );
  //   var bigPictureStyleInformation = BigPictureStyleInformation(
  //     FilePathAndroidBitmap(attachmentPicturePath),
  //     contentTitle: '<b>Attached Image</b>',
  //     htmlFormatContentTitle: true,
  //     summaryText: 'Test Image',
  //     htmlFormatSummaryText: true,
  //   );
  //   var androidChannelSpecifics = AndroidNotificationDetails(
  //     'CHANNEL ID 2',
  //     'CHANNEL NAME 2',
  //     'CHANNEL DESCRIPTION 2',
  //     importance: Importance.High,
  //     priority: Priority.High,
  //     styleInformation: bigPictureStyleInformation,
  //   );
  //   var notificationDetails =
  //   NotificationDetails(androidChannelSpecifics, iOSPlatformSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     'Title with attachment',
  //     'Body with Attachment',
  //     notificationDetails,
  //   );
  // }
  //
  // _downloadAndSaveFile(String url, String fileName) async {
  //   var directory = await getApplicationDocumentsDirectory();
  //   var filePath = '${directory.path}/$fileName';
  //   var response = await http.get(url);
  //   var file = File(filePath);
  //   await file.writeAsBytes(response.bodyBytes);
  //   return filePath;
  // }
  //
  // Future<int> getPendingNotificationCount() async {
  //   List<PendingNotificationRequest> p =
  //   await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  //   return p.length;
  // }
  //
  // Future<void> cancelNotification() async {
  //   await flutterLocalNotificationsPlugin.cancel(0);
  // }
  //
  // Future<void> cancelAllNotification() async {
  //   await flutterLocalNotificationsPlugin.cancelAll();
  // }


