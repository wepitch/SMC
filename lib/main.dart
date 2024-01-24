import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/home_page/notification_page/notification_database_helper.dart';
import 'package:myapp/home_page/notification_page/notification_page.dart';
import 'package:myapp/news/provider/news_provider.dart';
import 'package:myapp/news/service/news_api_service.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/other/dependency_injection.dart';
import 'package:myapp/other/provider/user_booking_provider.dart';
import 'package:myapp/page-1/splash_screen_2.dart';
import 'package:myapp/phone/phone_otp_screen.dart';
import 'package:myapp/profile_page/profile_page.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'home_page/homepage.dart';
import 'home_page/notification_page/noti.dart';

// import 'package:myapp/page-1/student-community-NJD.dart';
// import 'package:myapp/page-1/courses.dart';
// import 'package:myapp/page-1/detailed-cb.dart';
// import 'package:myapp/page-1/detailed-feed.dart';
// import 'package:myapp/page-1/news.dart';
// import 'package:myapp/page-1/detailed-news.dart';
// import 'package:myapp/page-1/detailed-vocational-courses.dart';
// import 'package:myapp/page-1/detailed-counsellor.dart';
// import 'package:myapp/page-1/detailed-webinar.dart';
// import 'package:myapp/page-1/course-boosters.dart';
// import 'package:myapp/page-1/entrance-prepration.dart';
// import 'package:myapp/page-1/detailed-entrance-prepration.dart';
// import 'package:myapp/page-1/splash-screen.dart';
// import 'package:myapp/page-1/welcome-screen.dart';
// import 'package:myapp/page-1/sign-up.dart';
// import 'package:myapp/page-1/otp.dart';
// import 'package:myapp/page-1/dob-new.dart';
// import 'package:myapp/page-1/login.dart';
// import 'package:myapp/page-1/homepagecontainer.dart';
// import 'package:myapp/page-1/counsellor-select-new.dart';
// import 'package:myapp/page-1/ep.dart';
// import 'package:myapp/page-1/ep-zCq.dart';
// import 'package:myapp/page-1/vocational-courses.dart';
// import 'package:myapp/page-1/vocational-courses-rW5.dart';
// import 'package:myapp/page-1/vocational-courses-W2V.dart';
// import 'package:myapp/page-1/vocational-courses-1st-pge.dart';
// import 'package:myapp/page-1/calender.dart';
// import 'package:myapp/page-1/calender-grp.dart';
// import 'package:myapp/page-1/calender-XQM.dart';
// import 'package:myapp/page-1/calender-R7F.dart';
// import 'package:myapp/page-1/accommodatino-search.dart';
// import 'package:myapp/page-1/accommodatino-pg-.dart';
// import 'package:myapp/page-1/accommodatino-hostel-.dart';
// import 'package:myapp/page-1/conncet.dart';
// import 'package:myapp/page-1/payment-screen-1.dart';
// import 'package:myapp/page-1/community-fisrt.dart';
// import 'package:myapp/page-1/flat-community.dart';
// import 'package:myapp/page-1/flat-enquiry.dart';
// import 'package:myapp/page-1/community-detailed.dart';
// import 'package:myapp/page-1/webinar-detail-second-full-view.dart';
// import 'package:myapp/page-1/counselor-detailed-full-view.dart';
// import 'package:myapp/page-1/counselor-detailed-select-full-view.dart';
// import 'package:myapp/page-1/save-profile-send-enquiry.dart';
// import 'package:myapp/page-1/ep-detailed-full-view.dart';
// import 'package:myapp/page-1/ep-detailed-pg-full-view.dart';
// import 'package:myapp/page-1/pg-details-full-view.dart';
// import 'package:myapp/page-1/ep-detailed-full-view-hW9.dart';
// import 'package:myapp/page-1/counselor-dashboard-new-full-view.dart';
// import 'package:myapp/page-1/student-dashboard-full-view.dart';
// import 'package:myapp/page-1/counselor-full-view.dart';
// import 'package:myapp/page-1/vocational-courses-full-view.dart';
// import 'package:myapp/page-1/payment-screen-2.dart';
// import 'package:myapp/page-1/payment-success.dart';
// import 'package:myapp/page-1/payment-failed.dart';
// import 'package:myapp/page-1/webinar-first.dart';
// import 'package:myapp/page-1/webinar.dart';
// import 'package:myapp/page-1/webinar-wmB.dart';
// import 'package:myapp/page-1/career-booster.dart';
// import 'package:myapp/page-1/explore-first-feed.dart';
// import 'package:myapp/page-1/explore-detail-feed.dart';
// import 'package:myapp/page-1/image-1.dart';
// import 'package:myapp/page-1/rectangle-113.dart';
// import 'package:myapp/page-1/rectangle-114.dart';
// import 'package:myapp/page-1/image-2.dart';
// import 'package:myapp/page-1/image-3.dart';
// import 'package:myapp/page-1/image-4.dart';
// import 'package:myapp/page-1/image-5.dart';
// import 'package:myapp/page-1/image-6.dart';
// import 'package:myapp/page-1/.dart';
// import 'package:myapp/page-1/image-7.dart';
// import 'package:myapp/page-1/group-92.dart';
// import 'package:myapp/page-1/group-32.dart';
// import 'package:myapp/page-1/whatsapp-image-2023-08-23-at-810-1.dart';
// import 'package:myapp/page-1/vocational-course-offline-full-view.dart';
// import 'package:myapp/page-1/share.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// function to lisen to background changes
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DatabaseHelper.createDatabase();
  runApp(const MyApp());
  DependencyInjection.init();

  // on background notification tapped


  PushNotifications.init();
  PushNotifications.localNotiInit();
  // Listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });

  // for handling in terminated state
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CounsellorDetailsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserBookingProvider(),
        ),
        ChangeNotifierProvider(
            create: (context) =>
                NewsProvider(newsApiService: NewsApiService())),
      ],
      child: GetMaterialApp(
          title: 'Flutter',
          debugShowCheckedModeBanner: false,
          scrollBehavior: MyCustomScrollBehavior(),
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          routes: {
            '/': (context) => const SplashScreen2(),
            '/message': (context) => const MessageScreen()
          },
          // home: const Scaffold(
          //   body: SplashScreen2(),
          // ),
          builder: EasyLoading.init()),
    );
  }
}

//
// Future<void> backgroundHandler(RemoteMessage message) async {
//   if (message.notification != null) {
//     print(message.notification!.title);
//     print(message.notification!.body);
//     //print("message.data11 ${message.data}");
//     LocalNotificationService.createanddisplaynotification(message);
//   }
// }

// _initializeFirebase() async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//   var result = await FlutterNotificationChannel.registerNotificationChannel(
//       description: 'For Showing Message Notification',
//       id: 'chats',
//       importance: NotificationImportance.IMPORTANCE_HIGH,
//       name: 'Chats',
//       visibility: NotificationVisibility.VISIBILITY_PUBLIC,
//       allowBubbles: true,
//       enableVibration: true,
//       enableSound: true,
//       showBadge: true);
//   log('\nNotification Channel Result: $result');
// }
// import 'dart:convert';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'firebase_options.dart';
// import 'home_page/homepage.dart';
// import 'home_page/notification_page/noti.dart';
// import 'home_page/notification_page/notification_page.dart';
//
// final navigatorKey = GlobalKey<NavigatorState>();
//
// // function to lisen to background changes
// Future _firebaseBackgroundMessage(RemoteMessage message) async {
//   if (message.notification != null) {
//     print("Some notification Received");
//   }
// }
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   // on background notification tapped
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     if (message.notification != null) {
//       print("Background Notification Tapped");
//       navigatorKey.currentState!.pushNamed("/message", arguments: message);
//     }
//   });
//
//   PushNotifications.init();
//   PushNotifications.localNotiInit();
//   // Listen to background notifications
//   FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
//
//   // to handle foreground notifications
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     String payloadData = jsonEncode(message.data);
//     print("Got a message in foreground");
//     if (message.notification != null) {
//       PushNotifications.showSimpleNotification(
//           title: message.notification!.title!,
//           body: message.notification!.body!,
//           payload: payloadData);
//     }
//   });
//
//   // for handling in terminated state
//   final RemoteMessage? message =
//   await FirebaseMessaging.instance.getInitialMessage();
//
//   if (message != null) {
//     print("Launched from terminated state");
//     Future.delayed(Duration(seconds: 1), () {
//       navigatorKey.currentState!.pushNamed("/message", arguments: message);
//     });
//   }
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: navigatorKey,
//       title: 'Push Notifications',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       routes: {
//         '/': (context) => const HomePage(),
//         '/message': (context) => const Message()
//       },
//     );
//   }
// }
