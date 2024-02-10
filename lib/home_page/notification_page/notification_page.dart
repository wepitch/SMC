import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/route_manager.dart';
import 'package:myapp/home_page/notification_page/noti.dart';
import 'package:myapp/home_page/notification_page/notification_database_helper.dart';
import 'package:myapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  List<Map<String, dynamic>> notificationsList = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;
    if (data is RemoteMessage) {
      final payload = data.data;
      _addNotificationToList(payload);
    }
    if (data is NotificationResponse) {
      final payload = jsonDecode(data.payload!);
      _addNotificationToList(payload);
    }

    return const Scaffold();
  }

  void _loadNotifications() async {
    final notifications = await DatabaseHelper.getNotificationData();
    setState(() {
      notificationsList.addAll(
          notifications.map((notification) => notification.toMap()).toList());
    });
  }

  void _addNotificationToList(Map<String, dynamic> payload) {
    setState(() {
      notificationsList.insert(0, payload);
    });
  }
}

class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // get the device fcm token
    final token = await _firebaseMessaging.getToken();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("Background Notification Tapped");
        Get.to(const Notification2());
      }
    });
    FirebaseMessaging.onBackgroundMessage((message) async {});
    print("device token: $token");
    //Get.to(const Notification2());
  }

  static Future localNotiInit() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,

    );
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );
  }

  // static void onNotificationTap(
  //   NotificationResponse notificationResponse,
  // ) {
  //   final Map<String, dynamic> notificationData = {
  //     'id': notificationResponse.id ?? '',
  //     'payload': notificationResponse.payload,
  //   };
  //   MessageScreenState().notificationsList.insert(0, notificationData);
  //   Get.to(const Notification2());
  // }

  static void onNotificationTap(NotificationResponse notificationResponse) async {
    final Map<String, dynamic> notificationData = {
      'id': notificationResponse.id ?? '',
      'payload': notificationResponse.payload,

    };

    await saveNotification(notificationData);
    Get.to(const Notification2());
  }

  static Future<void> saveNotification(Map<String, dynamic> notificationData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];
    notifications.insert(0, json.encode(notificationData));
    prefs.setStringList('notifications', notifications);
  }


  // static void onNotificationTap(NotificationResponse notificationResponse) {
  //   navigatorKey.currentState!.pushNamed("/notification", arguments: notificationResponse);
  // }

  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
    String date = DateTime.now().toString();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('title', title);
    sharedPreferences.setString('body', body);
    sharedPreferences.setString('date', date);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("Background Notification Tapped");
        navigatorKey.currentState!.pushNamed("/message", arguments: message);
      }
    });
  }
}
