import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/webinar_page/webinar_details_page.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/widget/custom_webniar_card_widget.dart';

class WebinarPastPage extends StatefulWidget {
  const WebinarPastPage({super.key});

  @override
  State<WebinarPastPage> createState() => _WebinarPastPageState();
}

class _WebinarPastPageState extends State<WebinarPastPage> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                EdgeInsets.only(top: index == 0 ? 30 : 27, right: 16, left: 16),
            child: const CustomWebinarCard1(
                showDuration: false,
                title: "Learn more about CUET and IPMAT",
                isRegisterNow: false,
                btnTitle: "Happend 3 Days ago",
                time: "15 Sep @ 2:00 PM Onwards",
                duration: "60",
                participants: "Unlimited",
                bannerImg: "assets/page-1/images/webinarBanner.png"),
          );
        });
  }
}


Widget customEnrollButton(
    {required VoidCallback onPresssed,
    required String title,
    required BuildContext context}) {
  return SizedBox(
    height: 30,
    width: 60,
    child: Container(
      decoration: BoxDecoration(
          color: const Color(0xff1F0A68),
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Colors.grey,
              spreadRadius: 0.1,
              offset: Offset(0, 3),
            )
          ]),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: SafeGoogleFont(
            "Inter",
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget customRegisterNowBtn(
    {required VoidCallback onPressed,
    required String title,
    required bool isRegisterNow}) {
  return SizedBox(
    height: 42,
    width: 200,
    child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          foregroundColor: isRegisterNow ? Colors.white : Colors.black,
          backgroundColor: isRegisterNow
              ? const Color.fromARGB(255, 189, 173, 241)
              : const Color.fromARGB(255, 214, 205, 247),
        ),
        child: Text(
          title,
          style: SafeGoogleFont(
            "Inter",
            fontSize: 15,
            fontWeight: isRegisterNow ? FontWeight.bold : FontWeight.w500,
          ),
        )),
  );
}
