import 'package:flutter/material.dart';
import 'package:myapp/booking_page/booking_page.dart';
import 'package:myapp/home_page/counsellor_page/counsellor_select_listview_offline.dart';
import 'package:myapp/profile_page/profile_page.dart';

// import 'package:myapp/page-1/webinar-detail-second-full-view.dart';
// import 'package:myapp/page-1/webinar.dart';
import 'package:myapp/home_page/homepage.dart';
import 'package:myapp/webinar_page/webinar_page.dart';

// import 'package:myapp/page-1/news.dart';
// import 'package:myapp/page-1/profile.dart';

// import 'counsellor-select-new.dart';
// import 'counselor-dashboard-new-full-view.dart';
// import 'counselor-detailed-full-view.dart';
// import 'counselor-detailed-select-full-view.dart';
// import 'counselor-full-view.dart';
// import 'explore-first-feed.dart';

class HomePageContainer extends StatefulWidget {
  const HomePageContainer({super.key});

  @override
  State<HomePageContainer> createState() => _HomePageContainerState();
}

class _HomePageContainerState extends State<HomePageContainer> {
  int selectedIndex = 0;

  final Widget _home = const HomePage();

  final Widget _webNar = const WebinarPage();

  final Widget _booking = const BookingPage();

  // final Widget _news = News();

  final Widget _profile = const ProfilePage();

  /*Widget _news = News();

  Widget _profile = Profile();*/

  @override
  Widget build(BuildContext context) {
    // double baseWidth = 430;
    // double fem = MediaQuery.of(context).size.width / baseWidth;
    // double ffem = fem * 0.97;
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        iconSize: 22.0,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        selectedItemColor: const Color(0xff512DA8),
        unselectedItemColor: const Color(0xff565656),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: ImageIcon(
              AssetImage("assets/page-1/images/home.png"),
            ),
          ),
          BottomNavigationBarItem(
            label: "Webinar",
            icon: ImageIcon(
              AssetImage("assets/page-1/images/online-video-1-1-vXj.png"),
            ),
          ),
          BottomNavigationBarItem(
            label: "Booking",
            icon: ImageIcon(
              AssetImage("assets/page-1/images/booking.png"),
            ),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/page-1/images/newspaper-1-s6H.png"),
            ),
            label: "News",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/page-1/images/user-1-1-J3b.png"),
            ),
            label: "Profile",
          )
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return _home;
    } else if (selectedIndex == 1) {
      return _webNar;
    } else if (selectedIndex == 2) {
      return _booking;
    }
    /*else if (this.selectedIndex == 3) {
      return this._news;
    } */
    else if (selectedIndex == 4) {
      return _profile;
    } else {
      return _home;
    }
  }

  void onTapgotocounsellor(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const CounsellorListPage_offline()));
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
