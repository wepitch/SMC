import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myapp/home_page/drawer/drawer_1.dart';
import 'package:myapp/home_page/homepagecontainer_2.dart';
import 'package:myapp/home_page/notification_page/noti.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/utils.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:myapp/widget/custom_webniar_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CounsellorDetailsProvider counsellorDetailsProvider =
      CounsellorDetailsProvider();

  @override
  void initState() {
    super.initState();
    setName();
    getAllInfo();
    counsellorDetailsProvider =
        Provider.of<CounsellorDetailsProvider>(context, listen: false);
  }

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

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      drawer: const Drawer1(),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
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
              padding:
                  EdgeInsets.fromLTRB(27 * fem, 8 * fem, 25 * fem, 23 * fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
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
                            padding: EdgeInsets.fromLTRB(
                                12 * fem, 7 * fem, 12 * fem, 12.66 * fem),
                            width: 110 * fem,
                            height: 114 * fem,
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
                                    margin: const EdgeInsets.only(bottom: 5),
                                    width: 32,
                                    height: 62,
                                    child: Image.asset(
                                      'assets/page-1/images/untitled-design-5-1.png',
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Counsellor',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 12 * ffem,
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
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 23 * fem, 0 * fem),
                                  padding: EdgeInsets.fromLTRB(
                                      15 * fem, 4 * fem, 9 * fem, 6 * fem),
                                  width: 110 * fem,
                                  height: 114 * fem,
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
                                                    style: TextButton.styleFrom(
                                                      padding: EdgeInsets.zero,
                                                    ),
                                                    child: Container(),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                child: SizedBox(
                                                  width: 82 * fem,
                                                  height: 58 * fem,
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
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 7 * fem, 0 * fem),
                                        child: Text(
                                          'Entrance \nPreparation',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 12 * ffem,
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
                                      20 * fem, 8 * fem, 20 * fem, 13 * fem),
                                  width: 110 * fem,
                                  height: 114 * fem,
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
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 9 * fem),
                                        width: 68 * fem,
                                        height: 66 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/mask-group-SbT.png',
                                          width: 68 * fem,
                                          height: 66 * fem,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 1 * fem, 0 * fem),
                                        child: Text(
                                          'Connect',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 12 * ffem,
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
                    width: double.infinity,
                    height: 113 * fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
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
                            height: 114 * fem,
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
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                    padding: EdgeInsets.fromLTRB(
                                        30 * fem, 8 * fem, 30 * fem, 1 * fem),
                                    width: double.infinity,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SizedBox(
                                        width: 68 * fem,
                                        height: 62 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/hostel-1-1.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 2 * fem, 1 * fem, 0),
                                  child: Text(
                                    'Student \nAccommodation',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 12 * ffem,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              23 * fem, 2 * fem, 0 * fem, 0 * fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
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
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 6 * fem),
                                          width: 68 * fem,
                                          height: 62 * fem,
                                          child: Image.asset(
                                            'assets/page-1/images/mask-group-Z9B.png',
                                            width: 68 * fem,
                                            height: 62 * fem,
                                          ),
                                        ),
                                        Container(
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
                                              fontSize: 12 * ffem,
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 120,
                  maxWidth: 390,
                ),
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
                              image: DecorationImage(image: NetworkImage(e)),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
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
            Padding(
              padding:
                  const EdgeInsets.only(left: 14, right: 14, bottom: 0, top: 8),
              child: Column(
                children: [
                  buildCustomWebinarCard(),
                  buildCustomWebinarCard(),
                  buildCustomWebinarCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  CustomWebinarCard buildCustomWebinarCard() {
    return const CustomWebinarCard(
        enableAutoScroll: true,
        showDuration: false,
        title: "Learn more about CUET and IPMAT",
        isRegisterNow: true,
        btnTitle: "Register Now",
        time: "15 Sep @ 2:00 PM Onwards",
        duration: "60",
        participants: "Unlimited",
        bannerImg: "assets/page-1/images/webinarBanner.png");
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
                          GestureDetector(
                            onTap: (){
                              Share.share('https://play.google.com/store/apps/details?id=com.sortmycollege');
                            },
                            child: CircleAvatar(
                              backgroundColor: const Color(0xff7F90F7),
                              child: Center(
                                child: Image.asset(
                                  "assets/page-1/images/group-38-oFX.png",
                                  color: Colors.white,
                                  height: 14,
                                ),
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

  void onTapgotocounsellor(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const HomePageContainer_2()));
  }
}
List<String> dummyImagesSlider = [
  "https://res.cloudinary.com/drqangxt5/image/upload/v1707392532/vwoxcoxnthnqzf6gr6dk.png",
  "https://res.cloudinary.com/drqangxt5/image/upload/v1707395734/hg6qrgwoxunplx8nulyo.png",
  "https://res.cloudinary.com/drqangxt5/image/upload/v1707470820/hw3dtgyzidkdxmfn9okf.png",
  "https://res.cloudinary.com/drqangxt5/image/upload/v1707388826/ivt6y17a9pknj5fvdp8t.png",
];