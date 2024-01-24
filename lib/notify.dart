// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:myapp/home_page/notification_page/noti.dart';
// import 'package:myapp/home_page/notification_page/notification_page.dart';
// import 'package:myapp/utils.dart';
//
// class NotificationPage extends StatefulWidget {
//   const NotificationPage({super.key});
//
//   @override
//   State<NotificationPage> createState() => _NotificationPageState();
// }
//
// class _NotificationPageState extends State<NotificationPage> {
//   static FirebaseAuth auth = FirebaseAuth.instance;
//   List<Map<String, dynamic>> notifications = [];
//
//   @override
//   void initState() {
//
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       print("FirebaseMessaging.onMessageOpenedApp.listen");
//       if (message.notification != null) {
//         print(message.notification!.title);
//         print(message.notification!.body);
//         print("message.data22 ${message.data['_id']}");
//       }
//     });
//
//     FirebaseMessaging.onMessage.listen((message) {
//       print("FirebaseMessaging.onMessage.listen");
//       if (message.notification != null) {
//         print(message.notification!.title);
//         print(message.notification!.body);
//         PushNotifications.showSimpleNotification( title: message.notification!.title!, body:message.notification!.body! , payload: message.data['_id'],);
//
//         // Update the list of notifications
//         setState(() {
//           notifications.add({
//             'title': message.notification!.title,
//             'body': message.notification!.body,
//           });
//         });
//       }
//     });
//
//     super.initState();
//   //  getid();
//    // getToken();
//
//   }
//
//   // void getToken() async {
//   //   await FirebaseMessaging.instance.getToken().then((token) {
//   //     setState(() {
//   //       deviceToken = token!;
//   //       print('my token is $deviceToken');
//   //       LocalDataSaver.saveDeviceToken(token);
//   //     });
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xff1F0A68),
//         foregroundColor: Colors.white,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 0, top: 18, bottom: 18),
//           child: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Image.asset('assets/page-1/images/back.png'),
//           ),
//         ),
//         titleSpacing: 70,
//         title: Text(
//           "Notifications",
//           style: SafeGoogleFont("Inter", fontSize: 18, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: notifications.length,
//         itemBuilder: (context, index) {
//           var notificationData = notifications[index];
//           return ListTile(
//             contentPadding: const EdgeInsets.all(16),
//             title: Text(
//               notificationData['title'] ?? '',
//               style: SafeGoogleFont("Inter", fontSize: 18,color: Colors.black, fontWeight: FontWeight.w600),
//             ),
//             subtitle: Text(
//               notificationData['body'] ?? '',
//               style: SafeGoogleFont(
//                 "Inter",
//                 color: const Color(0xff626161),
//                 height: 1.5,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             shape: Border(
//               bottom: BorderSide(
//                 color: Colors.black.withOpacity(0.09),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// // Other parts of your code remain unchanged
//
