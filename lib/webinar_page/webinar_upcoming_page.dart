import 'package:flutter/material.dart';
import 'package:myapp/webinar_page/webinar_past_page.dart';

class WebinarUpcomingPage extends StatelessWidget {
  const WebinarUpcomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                EdgeInsets.only(top: index == 0 ? 30 : 27, right: 16, left: 16),
            child: const CustomWebinarCard(
                showDuration: false,
                title: "Learn more about CUET and IPMAT",
                isRegisterNow: true,
                btnTitle: "Register Now",
                time: "15 Sep @ 2:00 PM Onwards",
                duration: "60",
                participants: "Unlimited",
                bannerImg: "assets/page-1/images/webinarBanner.png"),
          );
        });
  }
}
