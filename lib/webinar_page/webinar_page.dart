import 'package:flutter/material.dart';
import 'package:myapp/booking_page/booking_page.dart';
import 'package:myapp/home_page/homepage.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/webinar_page/webinar_model.dart';
import 'package:myapp/webinar_page/webinar_past_page.dart';
import 'package:myapp/webinar_page/webinar_today_page.dart';
import 'package:myapp/webinar_page/webinar_upcoming_page.dart';
import 'package:myapp/utils.dart';

class WebinarPage extends StatefulWidget {
  const WebinarPage({super.key});

  @override
  State<WebinarPage> createState() => _WebinarPageState();
}

class _WebinarPageState extends State<WebinarPage> {
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
     SessionDate.dateTimeDif();
  }

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        foregroundColor: Colors.white,
        // titleSpacing: 60,
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 0, top: 18, bottom: 18),
        //   child: GestureDetector(
        //     onTap: () {
        //       Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => const HomePageContainer()));
        //     },
        //     child: Image.asset(
        //       'assets/page-1/images/back.png',
        //     ),
        //   ),
        // ),
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "Webinar",
            style: SafeGoogleFont("Inter",
                fontSize: 18, fontWeight: FontWeight.w600,color: Color(0xff1F0A68)),
          ),
        ),
        actions: [
          Image.asset(
            'assets/page-1/images/layer-3.png',
            width: 20,
            height: 20,
            color: Color(0xff1F0A68),
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
      body: Scaffold(
        backgroundColor: ColorsConst.whiteColor,
        body: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTab(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                      pageController.jumpToPage(selectedIndex);
                    },
                    title: "My Webinar",
                    isSelected: selectedIndex == 0),
                CustomTab(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                      pageController.jumpToPage(selectedIndex);
                    },
                    title: "Today",
                    isSelected: selectedIndex == 1),
                CustomTab(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                      pageController.jumpToPage(selectedIndex);
                    },
                    title: "Upcoming",
                    isSelected: selectedIndex == 2),
              ],
            ),
            Expanded(
                child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                WebinarPastPage(),
                WebinarTodayPage(),
                WebinarUpcomingPage(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

Widget customButton({
  required VoidCallback onPressed,
  required String title,
  required bool isPressed,
}) {
  return Card(
    elevation: 1,
    shadowColor: ColorsConst.whiteColor,
    child: SizedBox(
      height: 35,
      width: 100,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          backgroundColor: Colors.white,
          foregroundColor: isPressed ? Colors.black : const Color(0xff747474),
        ),
        child: Text(
          title,
          style: SafeGoogleFont(
            "Inter",
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}

// Widget customButton(
//     {required VoidCallback onPressed,
//     required String title,
//     required bool isPressed}) {
//   return SizedBox(
//     height: 35,
//     width: 110,
//     child: OutlinedButton(
//         onPressed: onPressed,
//         style: OutlinedButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(3),
//             ),
//             backgroundColor: const Color(0xffE7E7EB),
//             foregroundColor:
//                 isPressed ? Colors.black : const Color(0xff747474)),
//         child: Text(
//           title,
//           style: SafeGoogleFont("Inter",
//               fontSize: 12, fontWeight: FontWeight.w500),
//         )),
//   );
// }
