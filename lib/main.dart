import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/home_page/homepagecontainer.dart';
import 'package:myapp/home_page/notification_page/news/provider/news_provider1.dart';
import 'package:myapp/home_page/notification_page/news/service/news_service.dart';
import 'package:myapp/home_page/notification_page/notification_page.dart';
import 'package:myapp/news/provider/news_provider.dart';
import 'package:myapp/news/service/news_api_service.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/other/dependency_injection.dart';
import 'package:myapp/other/provider/follower_provider.dart';
import 'package:myapp/other/provider/user_booking_provider.dart';
import 'package:myapp/page-1/shared.dart';
import 'package:myapp/page-1/splash_screen_2.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page/notification_page/noti.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// function to lisen to background changes
/*Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received");
    Get.to(const Notification2());
  }
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool? isLoggedIn = await MyApp.loggIn();
  runApp(MyApp(isLoggedIn: isLoggedIn!));
  DependencyInjection.init();


  /*PushNotifications.init();
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
  }*/
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  static Future<bool?> loggIn() async {
    return await SharedPre.getAuthLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FollowerProvider()),
        ChangeNotifierProvider(
          create: (context) => CounsellorDetailsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserBookingProvider(),
        ),
        ChangeNotifierProvider(
            create: (context) =>
                NewsProvider(newsApiService: NewsApiService())),
        ChangeNotifierProvider(
            create: (context) => NewsProvider1(newsService: NewsService())),
      ],
      child: GetMaterialApp(
          title: 'Flutter',
          debugShowCheckedModeBanner: false,
          scrollBehavior: MyCustomScrollBehavior(),
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          // routes: {
          //   '/': (context) => const SplashScreen2(),
          //   '/message': (context) => const Notification2(),
          //   // Add your other routes
          // },
          home: isLoggedIn ? const HomePageContainer() : const SplashScreen2(),
          builder: EasyLoading.init()),
    );
  }
}

Future<dynamic> getInitialRoute() async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  var token = shared.getString('token');
  if (token != null) {
    Get.to(const SplashScreen2());
  } else {
    Get.to(const HomePageContainer());
  }
}

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
