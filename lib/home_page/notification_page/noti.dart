// // // import 'package:firebase_messaging/firebase_messaging.dart';
// // // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // //
// // // class LocalNotificationService {
// // //   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
// // //       FlutterLocalNotificationsPlugin();
// // //
// // //   static void initialize() {
// // //     // initializationSettings  for Android
// // //     const InitializationSettings initializationSettings =
// // //         InitializationSettings(
// // //       android: AndroidInitializationSettings("@mipmap/ic_launcher"),
// // //     );
// // //
// // //     _notificationsPlugin.initialize(
// // //       initializationSettings,
// // //       onSelectNotification: (String? id) async {
// // //         print("onSelectNotification");
// // //         if (id!.isNotEmpty) {
// // //           print("Router Value1234 $id");
// // //
// // //           // Navigator.of(context).push(
// // //           //   MaterialPageRoute(
// // //           //     builder: (context) => DemoScreen(
// // //           //       id: id,
// // //           //     ),
// // //           //   ),
// // //           // );
// // //         }
// // //       },
// // //     );
// // //   }
// // //
// // //   static void createanddisplaynotification(RemoteMessage message) async {
// // //     try {
// // //       if (message.notification?.android?.channelId == 'call') {
// // //         final id = 1; //DateTime.now().millisecondsSinceEpoch ~/ 1000;
// // //         const NotificationDetails notificationDetails = NotificationDetails(
// // //           android: AndroidNotificationDetails(
// // //             "happyU", // channel id
// // //             "pushnotificationappchannel", //channel name
// // //             importance: Importance.high,
// // //             enableVibration: true,
// // //             playSound: true,
// // //             sound: RawResourceAndroidNotificationSound('notification'),
// // //             priority: Priority.high,
// // //           ),
// // //         );
// // //
// // //         await _notificationsPlugin.show(
// // //           id,
// // //           message.notification!.title,
// // //           message.notification!.body,
// // //           notificationDetails,
// // //           payload: message.data['_id'],
// // //         );
// // //       } else {
// // //         final id = 1; //DateTime.now().millisecondsSinceEpoch ~/ 1000;
// // //         const NotificationDetails notificationDetails = NotificationDetails(
// // //           android: AndroidNotificationDetails(
// // //             "happyU", //channel id
// // //             "pushnotificationappchannel", //channel name
// // //             importance: Importance.high,
// // //             sound: RawResourceAndroidNotificationSound('chatnotification'),
// // //             // priority: Priority.high,
// // //           ),
// // //         );
// // //
// // //         await _notificationsPlugin.show(
// // //           id,
// // //           message.notification!.title,
// // //           message.notification!.body,
// // //           notificationDetails,
// // //           payload: message.data['_id'],
// // //         );
// // //       }
// // //     } on Exception catch (e) {
// // //       print(e);
// // //     }
// // //   }
// // // }
// // import 'dart:convert';
// //
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// //
// // class MessageScreen extends StatefulWidget {
// //   const MessageScreen({super.key});
// //
// //   @override
// //   State<MessageScreen> createState() => MessageScreenState();
// // }
// //
// // class MessageScreenState extends State<MessageScreen> {
// //   Map payload = {};
// //   @override
// //   Widget build(BuildContext context) {
// //     final data = ModalRoute.of(context)!.settings.arguments;
// //     if (data is RemoteMessage) {
// //       payload = data.data;
// //     }
// //     if (data is NotificationResponse) {
// //       payload = jsonDecode(data.payload!);
// //     }
// //
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Your Message")),
// //       body: Center(child: Text(payload.toString())),
// //     );
// //   }
// // }
// //
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class NotifyScreen1 extends StatefulWidget {
//   @override
//   _NotifyScreen1State createState() => _NotifyScreen1State();
// }
//
// class _NotifyScreen1State extends State<NotifyScreen1> {
//   List<Map<String, dynamic>> notificationsList = [];
//   DatabaseHelper databaseHelper = DatabaseHelper();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadNotifications();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Notifications")),
//       body: ListView.builder(
//         itemCount: notificationsList.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(notificationsList[index]['title'] ?? ''),
//             subtitle: Text(notificationsList[index]['body'] ?? ''),
//             trailing: Text(
//               '${notificationsList[index]['date']} ${notificationsList[index]['time']}',
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void _loadNotifications() async {
//     final notifications = await databaseHelper.getNotifications();
//     setState(() {
//       notificationsList.addAll(notifications);
//     });
//   }
// }
//
//
//
