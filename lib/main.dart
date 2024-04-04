import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myapp/booking_page/checkout_screen.dart';
import 'package:myapp/home_page/homepagecontainer.dart';
import 'package:myapp/home_page/notification_page/news/provider/news_provider1.dart';
import 'package:myapp/home_page/notification_page/news/service/news_service.dart';
import 'package:myapp/news/provider/news_provider.dart';
import 'package:myapp/news/service/news_api_service.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/other/dependency_injection.dart';
import 'package:myapp/other/provider/follower_provider.dart';
import 'package:myapp/other/provider/user_booking_provider.dart';
import 'package:myapp/page-1/shared.dart';
import 'package:myapp/page-1/splash_screen_n.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool? isLoggedIn = await MyApp.loggIn();
  runApp(MyApp(isLoggedIn: isLoggedIn!));
  DependencyInjection.init();
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
          //home: CheckOutScreen(name: 'abc', id: '65fbcbb563ee42338a08b939'),
          home: isLoggedIn ? const HomePageContainer() : const SplashScreenNew(),
          builder: EasyLoading.init(
            builder: (context, child) {
              return Stack(
                children: [
                  child!,
                  Builder(
                    builder: (BuildContext context) {
                      if (isLoggedIn) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Fluttertoast.showToast(msg: 'Already Registered');
                        });
                      }
                      return Container();
                    },
                  ),
                ],
              );
            },
          )),
    );
  }
}
