import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/home_page/drawer/image_saved_screen.dart';
import 'package:myapp/home_page/email_sender.dart';
import 'package:myapp/home_page/help_screen.dart';

// import 'package:myapp/page-1/webinar-detail-second-full-view.dart';
// import 'package:myapp/page-1/webinar.dart';
import 'package:myapp/home_page/homepagecontainer_2.dart';
import 'package:myapp/home_page/notification_page/news/ui/news_information_screen.dart';
import 'package:myapp/home_page/notification_page/noti.dart';
import 'package:myapp/home_page/notification_page/notification_page.dart';
import 'package:myapp/main.dart';
import 'package:myapp/notify.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/profile_page/profile_page.dart';
import 'package:myapp/page-1/splash_screen_2.dart';
import 'package:myapp/webinar_page/webinar_page.dart';
import 'package:myapp/webinar_page/webinar_past_page.dart';
import 'package:myapp/utils.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:myapp/widget/custom_webniar_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'counsellor-select-new.dart';
// import 'counsellor_select_listview_offline.dart';
// import 'counselor-dashboard-new-full-view.dart';
// import 'counselor-detailed-full-view.dart';
// import 'counselor-detailed-select-full-view.dart';
// import 'counselor-full-view.dart';
// import 'explore-first-feed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  late Timer _timer;

  //String value = '';

  CounsellorDetailsProvider counsellorDetailsProvider =
  CounsellorDetailsProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_startTimer();
    setName();
    getAllInfo();
    _pageController = PageController(initialPage: _currentIndex);
    counsellorDetailsProvider =
        Provider.of<CounsellorDetailsProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  late final Map<String, dynamic> notificationData;

  String username = "";
  String path = '';

  void getAllInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("name") ?? "N/A";
    path = prefs.getString("profile_image_path") ?? "N/A";
    setState(() {});
  }

  void saveImagePathToPrefs(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("profile_image_path", path);
  }

  void setName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name") ?? "N/A";
    setState(() {});
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < 2) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 2),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: Drawer(
        width: 262,
        backgroundColor: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 164,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xff1F0A68),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 28,
                    ),
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: path != null
                                  ? Image.file(File(path), fit: BoxFit.cover)
                                  : const Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 38, right: 26),
                      child: Text(
                        name,
                        style: SafeGoogleFont(
                          "Inter",
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ListTile(
                        leading: Image.asset(
                          "assets/page-1/images/drawerHomeIcon.png",
                          height: 19,
                        ),
                        title: Text(
                          "Home",
                          style: SafeGoogleFont(
                            "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        shape: Border(
                            bottom: BorderSide(
                              color: Colors.black.withOpacity(0.09),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
              //   child: Column(
              //     children: [
              //       ListTile(
              //         leading: Image.asset(
              //           "assets/page-1/images/drawerAboutUs.png",
              //           height: 20,
              //         ),
              //         title: Text(
              //           "About Us",
              //           style: SafeGoogleFont(
              //             "Inter",
              //             fontSize: 14,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //         shape: Border(
              //             bottom: BorderSide(
              //           color: Colors.black.withOpacity(0.09),
              //         )),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HelpScreen()));
                      },
                      child: ListTile(
                        leading: Image.asset(
                          "assets/page-1/images/drawerHelp.png",
                          height: 19,
                        ),
                        title: Text(
                          "Help?",
                          style: SafeGoogleFont(
                            "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        shape: Border(
                            bottom: BorderSide(
                              color: Colors.black.withOpacity(0.09),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.asset(
                        "assets/page-1/images/drawerPhsychoTest.png",
                        height: 19,
                      ),
                      title: Text(
                        "Psychometric Test",
                        style: SafeGoogleFont(
                          "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      shape: Border(
                          bottom: BorderSide(
                            color: Colors.black.withOpacity(0.09),
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FeedScreen(
                                  name: '',
                                  id: '',
                                )));
                      },
                      leading: const Icon(
                        Icons.save_alt,
                        size: 18,
                      ),
                      title: Text(
                        "Saved",
                        style: SafeGoogleFont(
                          "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      shape: Border(
                          bottom: BorderSide(
                            color: Colors.black.withOpacity(0.09),
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Alert!'),
                          content: const Text('Are you sure to logout!'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel')),
                            TextButton(
                              onPressed: () async {
                                await _logout();
                                if (mounted) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const SplashScreen2()));
                                }
                              },
                              child: const Text('Logout'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout,
                      size: 17,
                    ),
                    title: Text(
                      'Logout',
                      style: SafeGoogleFont(
                        "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    shape: Border(
                      bottom: BorderSide(
                        color: Colors.black.withOpacity(0.09),
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),
              Image.asset(
                "assets/page-1/images/sortmycollege-logo-1.png",
                height: 61,
                width: 229,
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: Text(
                'Hello, $username',
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(
              width: 30,
            )
          ],
        ),
        backgroundColor: const Color(0xff1F0A68),
        foregroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30, top: 18, bottom: 18),
          child: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Image.asset(
              'assets/page-1/images/group-59.png',
            ),
          ),
        ),
        bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 12), child: Container()),
        titleSpacing: 1,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Notification2(),
                ),
              );
            },
            child: Image.asset(
              'assets/page-1/images/bell.png',
              width: 18,
              height: 18,
            ),
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Container(
        // autogroupwwimtT3 (AXyHNJmCtiEztNKuY5WWim)
        padding:
        EdgeInsets.fromLTRB(27 * fem, 8 * fem, 25 * fem, 23 * fem),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Container(
            //   // group6p5o (453:7)
            //   margin: EdgeInsets.fromLTRB(
            //       322.84 * fem, 0 * fem, 1 * fem, 17.66 * fem),
            //   width: double.infinity,
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Container(
            //         // groupY1o (442:47)
            //         margin: EdgeInsets.fromLTRB(
            //             0 * fem, 0.16 * fem, 7 * fem, 0 * fem),
            //         width: 13.16 * fem,
            //         height: 13.16 * fem,
            //         child: Image.asset(
            //           'assets/page-1/images/group-Qyf.png',
            //           width: 13.16 * fem,
            //           height: 13.16 * fem,
            //         ),
            //       ),
            //       // Text(
            //       //   // filterScy (442:51)
            //       //   'Filter',
            //       //   style: SafeGoogleFont(
            //       //     'Inter',
            //       //     fontSize: 14 * ffem,
            //       //     fontWeight: FontWeight.w400,
            //       //     height: 1.2125 * ffem / fem,
            //       //     color: const Color(0xff000000),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            Container(
              // autogroupnoa9nB3 (AXyEx8HnJQq7KYRJqLNoa9)
              margin: EdgeInsets.fromLTRB(
                  0 * fem, 0 * fem, 2 * fem, 29 * fem),
              width: double.infinity,
              height: 113 * fem,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      onTapgotocounsellor(context);
                    },
                    child: Container(
                      // autogroupfspu6hX (AXyFA37bt2ojAabTr9Fspu)
                      padding: EdgeInsets.fromLTRB(
                          12 * fem, 7 * fem, 12 * fem, 12.66 * fem),
                      width: 110 * fem,
                      height: 113 * fem,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              // untitleddesign51zH7 (1115:125)
                              margin: const EdgeInsets.only(bottom: 5),
                              // margin: EdgeInsets.fromLTRB(
                              //     0 * fem, 5 * fem, 1 * fem, 8.34 * fem),
                              width: 35,
                              height: 64,
                              child: Image.asset(
                                'assets/page-1/images/untitled-design-5-1.png',
                                // fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            // counsellorhxD (993:189)
                            'Counsellor',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 13 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.2125 * ffem / fem,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // autogroupebw1SQ1 (AXyFHhZVzFQXkZZUnCebW1)
                    padding: EdgeInsets.fromLTRB(
                        23 * fem, 2 * fem, 0 * fem, 0 * fem),
                    height: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            EasyLoading.showToast("Coming Soon..",
                                toastPosition:
                                EasyLoadingToastPosition.bottom);
                          },
                          child: Container(
                            // frame2xt9 (993:183)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 23 * fem, 0 * fem),
                            padding: EdgeInsets.fromLTRB(
                                15 * fem, 4 * fem, 9 * fem, 6 * fem),
                            width: 110 * fem,
                            height: 113 * fem,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 4),
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ],
                            ),

                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    // autogroupdj6r2ND (AXyFQCNg83Pn2mHvneDj6R)
                                    margin: EdgeInsets.fromLTRB(0 * fem,
                                        0 * fem, 0 * fem, 7 * fem),
                                    width: double.infinity,
                                    height: 62 * fem,
                                    child: Stack(
                                      children: [
                                        Align(
                                          child: SizedBox(
                                            width: 72 * fem,
                                            height: 55 * fem,
                                            child: TextButton(
                                              onPressed: () {},
                                              style:
                                              TextButton.styleFrom(
                                                padding:
                                                EdgeInsets.zero,
                                              ),
                                              child: Container(),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          child: SizedBox(
                                            width: 86 * fem,
                                            height: 60 * fem,
                                            child: Image.asset(
                                              'assets/page-1/images/untitled-design-6-1.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  // entrancepreparationYjs (993:185)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 7 * fem, 0 * fem),
                                  child: Text(
                                    'Entrance \nPreparation',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 13 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2125 * ffem / fem,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                          // frame7dmK (993:211)
                          onPressed: () {
                            EasyLoading.showToast("Coming Soon..",
                                toastPosition:
                                EasyLoadingToastPosition.bottom);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                20 * fem, 4 * fem, 20 * fem, 13 * fem),
                            width: 110 * fem,
                            height: 113 * fem,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 4),
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // maskgroupJ6m (444:76)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 9 * fem),
                                  width: 70 * fem,
                                  height: 69 * fem,
                                  child: Image.asset(
                                    'assets/page-1/images/mask-group-SbT.png',
                                    width: 70 * fem,
                                    height: 69 * fem,
                                  ),
                                ),
                                Container(
                                  // connectc7T (993:213)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 1 * fem, 0 * fem),
                                  child: Text(
                                    'Connect',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 13 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2125 * ffem / fem,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              // autogroup7xnyWyX (AXyFiXBUYzjxZbFhtM7Xny)
              width: double.infinity,
              height: 113 * fem,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    // frame5kN5 (993:194)
                    onPressed: () {
                      EasyLoading.showToast("Coming Soon..",
                          toastPosition: EasyLoadingToastPosition.bottom);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 10 * fem),
                      width: 110 * fem,
                      height: 113 * fem,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                              // autogroups5t7M6y (AXyG8RfJzhJsr5YqqWS5T7)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 1 * fem),
                              padding: EdgeInsets.fromLTRB(
                                  26 * fem, 8 * fem, 26 * fem, 1 * fem),
                              width: double.infinity,
                              child: Align(
                                // hostel115Hs (1174:123)
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: 70 * fem,
                                  height: 66 * fem,
                                  child: Image.asset(
                                    'assets/page-1/images/hostel-1-1.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // vocationalcoursesmyK (993:193)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 2 * fem, 1 * fem, 0),
                            // constraints: BoxConstraints(
                            //     // maxWidth: 70 * fem,
                            //     ),

                            child: Text(
                              'Student \nAccommodation',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 13 * ffem,
                                fontWeight: FontWeight.w700,
                                // height: 1.2125 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // autogroupjfdb5BP (AXyFrbnM5WRB7dwrS8JFDB)
                    padding: EdgeInsets.fromLTRB(
                        23 * fem, 2 * fem, 0 * fem, 0 * fem),
                    height: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          // frame4bvR (993:191)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 25 * fem, 0 * fem),
                          child: TextButton(
                            onPressed: () {
                              EasyLoading.showToast("Coming Soon..",
                                  toastPosition:
                                  EasyLoadingToastPosition.bottom);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                  19 * fem, 4 * fem, 19 * fem, 3 * fem),
                              width: 110 * fem,
                              height: 113 * fem,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 4,
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // maskgroup43K (993:204)
                                    margin: EdgeInsets.fromLTRB(0 * fem,
                                        0 * fem, 0 * fem, 6 * fem),
                                    width: 72 * fem,
                                    height: 66 * fem,
                                    child: Image.asset(
                                      'assets/page-1/images/mask-group-Z9B.png',
                                      width: 72 * fem,
                                      height: 66 * fem,
                                    ),
                                  ),
                                  Container(
                                    // vocationalcoursesmyK (993:193)
                                    margin: EdgeInsets.fromLTRB(0 * fem,
                                        0 * fem, 1 * fem, 0 * fem),
                                    constraints: BoxConstraints(
                                      maxWidth: 71 * fem,
                                    ),
                                    child: Text(
                                      'Vocational \nCourses',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 13 * ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2125 * ffem / fem,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        /* TextButton(
                                // frame64hX (993:202)
                                onPressed: () {},
                                style: TextButton.styleFrom (
                                  padding: EdgeInsets.zero,
                                ),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(6*fem, 6*fem, 7*fem, 13*fem),
                                  height: double.infinity,

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // maskgroupxH7 (444:78)
                                        margin: EdgeInsets.fromLTRB(1*fem, 0*fem, 0*fem, 4*fem),
                                        width: 70*fem,
                                        height: 72*fem,
                                        child: Image.asset(
                                          'assets/page-1/images/mask-group-FbP.png',
                                          width: 70*fem,
                                          height: 72*fem,
                                        ),
                                      ),
                                      Text(
                                        // careerboosterfhK (993:203)
                                        'Career Booster',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont (
                                          'Inter',
                                          fontSize: 13*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.2125*ffem/fem,
                                          color: const Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Container(
      //   color: Colors.white,
      //   // autogroup2op7o2q (AXyGFfxEgcqGTznj9r2oP7)
      //   width: 450 * fem,
      //   height: 166 * fem,
      //   child: const Stack(
      //     children: [
      //       // Positioned(
      //       //   // rectangle53iQh (442:6)
      //       //   child: Align(
      //       //     child: SizedBox(
      //       //       width: 200.63 * fem,
      //       //       height: 350.66 * fem,
      //       //       child: Container(
      //       //         decoration: BoxDecoration(
      //       //           color: Colors.white,
      //       //           borderRadius: BorderRadius.only(
      //       //             topLeft: Radius.circular(15 * fem),
      //       //             topRight: Radius.circular(15 * fem),
      //       //           ),
      //       //           boxShadow: [
      //       //             BoxShadow(
      //       //               color: const Color(0x19000000),
      //       //               offset: Offset(0 * fem, -1 * fem),
      //       //               blurRadius: 1 * fem,
      //       //             ),
      //       //           ],
      //       //         ),
      //       //       ),
      //       //     ),
      //       //   ),
      //       // ),
      //       // Positioned(
      //       //     top: 120,
      //       //     child: SizedBox(
      //       //       height: 107,
      //       //       width: MediaQuery.sizeOf(context).width,
      //       //       child: ListView.builder(
      //       //           itemCount: dummyImagesSlider.length,
      //       //           scrollDirection: Axis.horizontal,
      //       //           physics: const BouncingScrollPhysics(),
      //       //           itemBuilder: (context, index) {
      //       //             var item = dummyImagesSlider[index];
      //       //             return Container(
      //       //               width: 145,
      //       //               height: 107,
      //       //               margin: const EdgeInsets.only(left: 20),
      //       //               decoration: BoxDecoration(
      //       //                   borderRadius: BorderRadius.circular(10),
      //       //                   image: DecorationImage(
      //       //                       fit: BoxFit.cover,
      //       //                       image: NetworkImage(item))),
      //       //             );
      //       //           }),
      //       //     )),
      Align(
        // image slider
        child: Container(
          constraints: const BoxConstraints(
            maxHeight: 120,
            maxWidth: 390,
          ),
          // color: Colors.red,
          decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12)),
          width: 390 * fem,
          height: 120 * fem,
          child: ImageSlideshow(
            autoPlayInterval: 6000,
            isLoop: true,
            indicatorColor: Colors.black,
            indicatorBackgroundColor: Colors.white,
            children: dummyImagesSlider
                .map((e) => Container(
              width: 390 * fem,
              height: 120 * fem,
              decoration: BoxDecoration(
                borderRadius:
                const BorderRadius.all(Radius.circular(16)),
                // image: DecorationImage(
                //   image: ImageN(e),
                //   fit: BoxFit.cover,
                // )),
                image: DecorationImage(image: AssetImage(e)),
              ),
            ))
                .toList(),
          ),
        ),
      ),
      //       // Positioned(
      //       //   // careerboostersU7b (444:66)
      //       //   left: 20.3735351562 * fem,
      //       //   top: 186.3397827148 * fem,
      //       //   child: Align(
      //       //     child: SizedBox(
      //       //       width: 118 * fem,
      //       //       height: 19 * fem,
      //       //       child: Text(
      //       //         'Career Boosters',
      //       //         style: SafeGoogleFont(
      //       //           'Inter',
      //       //           fontSize: 15 * ffem,
      //       //           fontWeight: FontWeight.w600,
      //       //           height: 1.2125 * ffem / fem,
      //       //           color: const Color(0xff1f0a68),
      //       //         ),
      //       //       ),
      //       //     ),
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // ),
      // Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: SizedBox(
      //     height: 100,
      //     child: PageView(
      //       children: [
      //         imageScroll(),
      //         imageScroll1(),
      //       ],
      //     ),
      //   ),
      // ),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: EdgeInsets.only(left: 28.0 * fem),
        child: const Row(
          children: [
            Icon(
              Icons.person_2_outlined,
              size: 20,
            ),
            // Image.asset(
            //   'assets/page-1/images/person_icon.png',
            //   fit: BoxFit.fill,
            //   height: 16,
            //   width: 16,
            // ),
            SizedBox(
              width: 16,
            ),
            Text(
              'Popular Workshops',
              style: TextStyle(
                color: Color(0xFF1F0A68),
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 12,
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.28,
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            profileCard(),
            profileCard(),
            profileCard(),
          ],
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Padding(
        padding: EdgeInsets.only(left: 28.0 * fem),
        child: const Row(
          children: [
            Icon(
              Icons.person_pin_outlined,
              size: 18,
            ),
            // Image.asset(
            //   'assets/page-1/images/person_mes.png',
            //   fit: BoxFit.cover,
            //   height: 18,
            //   width: 18,
            // ),
            SizedBox(
              width: 16,
            ),
            Text(
              'Trending Webinars',
              style: TextStyle(
                color: Color(0xFF1F0A68),
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            )
          ],
        ),
      ),
      const Padding(
        padding:
        EdgeInsets.only(left: 14, right: 14, bottom: 0, top: 8),
        child: CustomWebinarCard(
            enableAutoScroll: true,
            showDuration: false,
            title: "Learn more about CUET and IPMAT",
            isRegisterNow: true,
            btnTitle: "Register Now",
            time: "15 Sep @ 2:00 PM Onwards",
            duration: "60",
            participants: "Unlimited",
            bannerImg: "assets/page-1/images/webinarBanner.png"),
      ),
      const Padding(
        padding:
        EdgeInsets.only(left: 14, right: 14, bottom: 0, top: 8),
        child: CustomWebinarCard(
            enableAutoScroll: true,
            showDuration: false,
            title: "Learn more about CUET and IPMAT",
            isRegisterNow: true,
            btnTitle: "Register Now",
            time: "15 Sep @ 2:00 PM Onwards",
            duration: "60",
            participants: "Unlimited",
            bannerImg: "assets/page-1/images/webinarBanner.png"),
      ),
      const Padding(
        padding:
        EdgeInsets.only(left: 14, right: 14, bottom: 0, top: 8),
        child: CustomWebinarCard(
            enableAutoScroll: true,
            showDuration: false,
            title: "Learn more about CUET and IPMAT",
            isRegisterNow: true,
            btnTitle: "Register Now",
            time: "15 Sep @ 2:00 PM Onwards",
            duration: "60",
            participants: "Unlimited",
            bannerImg: "assets/page-1/images/webinarBanner.png"),
      ),

      // InkWell(
      //   onTap: () async {
      //     const email = 'mailto :nsheoran2005@gmail.com';
      //     final Uri emailLaunchUri = Uri(
      //       scheme: 'mailto',
      //       path: email,
      //     );
      //     await launch(emailLaunchUri.toString());
      //   },
      //   child: Container(
      //     height: 60,
      //     decoration: const BoxDecoration(
      //       color: Color(0xBAE3398C),
      //     ),
      //     child: const Center(
      //       child: SizedBox(
      //         width: 370,
      //         height: 44,
      //         child: Text.rich(
      //           TextSpan(
      //             children: [
      //               TextSpan(
      //                 text: 'Need Help? ',
      //                 style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 18,
      //                   fontFamily: 'Inter',
      //                   fontWeight: FontWeight.w700,
      //                   height: 0,
      //                 ),
      //               ),
      //               TextSpan(
      //                 text: '
      //                 style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 16,
      //                   fontFamily: 'Inter',
      //                   fontWeight: FontWeight.w700,
      //                   height: 0,
      //                 ),
      //               ),
      //             ],
      //           ),
      //           textAlign: TextAlign.center,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      ],
    ),
    ),
    );
  }

  Widget profileCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 5, 12, 18),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 38,
                    backgroundImage: AssetImage(
                      "assets/page-1/images/Rectangle 101.png",
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Anshika Mehra',
                            style: TextStyle(
                              color: Color(0xFF1F0A68),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.08,
                          ),
                          CircleAvatar(
                            backgroundColor: const Color(0xff7F90F7),
                            child: Center(
                              child: Image.asset(
                                "assets/page-1/images/group-38-oFX.png",
                                color: Colors.white,
                                height: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      const SizedBox(
                        width: 190.25,
                        child: Text(
                          'Importance of CUET',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/page-1/images/clock-circular-outline-Ra1.png",
                            // color: Colors.black,
                            height: 12,
                            width: 12,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const SizedBox(
                            width: 121.13,
                            child: Text(
                              ' Session at 8:00pm',
                              style: TextStyle(
                                color: Color(0xFF414040),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0.08,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 13,
                            height: 13,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/page-1/images/calender.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const SizedBox(
                            width: 121.13,
                            child: Text(
                              '27th Dec 2023',
                              style: TextStyle(
                                color: Color(0xFF414040),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0.08,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                AssetImage("assets/page-1/images/rate.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const SizedBox(
                            width: 121.13,
                            child: Text(
                              ' 10/-',
                              style: TextStyle(
                                color: Color(0xFF414040),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0.08,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 0.47,
                width: double.infinity,
                color: const Color(0xffAFAFAF).withOpacity(.78),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 120.14,
                    height: 36.09,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          color: Colors.black.withOpacity(0.7400000095367432),
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const SizedBox(
                      width: 119.09,
                      height: 16.05,
                      child: Center(
                        child: Text(
                          'Visit Profile',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF262626),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0.07,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 36,
                    decoration: ShapeDecoration(
                      color: const Color(0xff1F0A68),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const SizedBox(
                      width: 119.09,
                      height: 16.05,
                      child: Center(
                        child: Text(
                          'Book Now',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0.07,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  Future _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen2()),
            (route) => false,
      );
    }
  }

  void onTapgotocounsellor(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const HomePageContainer_2()));
    //Navigator.push(context, MaterialPageRoute(builder: (context) => Webnar()));
  }

  void onTapGettingstarted2(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const WebinarPage()));
  }

  void onTapGettingstarted3(BuildContext context) {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => const ExplorerFeed()));
  }
}

List<String> dummyImagesSlider = [
  "assets/page-1/images/21da4647-c95a-44d9-b78e-40655d4946bc 1.png",
  "assets/page-1/images/attendthebest.png",
  "assets/page-1/images/bookyoursession.jpg",
];
// "https://static.vecteezy.com/system/resources/previews/001/937/644/original/online-education-application-learning-worldwide-on-computer-mobile-website-background-social-distance-concept-the-classroom-training-course-library-illustration-flat-vector.jpg",
// "https://www.insidehighered.com/sites/default/server_files/media/iStock-520374378.jpg",
// "https://static.vecteezy.com/system/resources/previews/001/937/697/large_2x/online-education-application-learning-worldwide-on-computer-mobile-website-background-social-distance-concept-the-classroom-training-course-library-illustration-flat-vector.jpg",
// "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOTciyMbprbWG5VSfWg4egySaj_arRCDzvu_FhbmUvvNBvpK2TBKmbtcSgqw&s",
// "https://t4.ftcdn.net/jpg/06/46/86/13/240_F_646861362_vLO3dVv2dta7qS2x2sfRInk2IppVO9KC.jpg",
// "https://t4.ftcdn.net/jpg/06/04/35/23/240_F_604352318_HlPTHiTe3P8icJVfZ6io7LAC7TjVnCjQ.jpg",