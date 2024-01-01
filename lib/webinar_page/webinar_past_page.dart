import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/webinar_page/webinar_details_page.dart';
import 'package:myapp/utils.dart';

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
            child: const CustomWebinarCard(
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

class CustomWebinarCard extends StatefulWidget {
  const CustomWebinarCard(
      {super.key,
      required this.isRegisterNow,
      required this.btnTitle,
      required this.time,
      required this.duration,
      required this.participants,
      required this.bannerImg,
      required this.title,
      required this.showDuration});

  final bool isRegisterNow;
  final String btnTitle;
  final String title;
  final String time;
  final String duration;
  final String participants;
  final String bannerImg;
  final bool showDuration;

  @override
  State<CustomWebinarCard> createState() => _CustomWebinarCardState();
}

class _CustomWebinarCardState extends State<CustomWebinarCard> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentIndex < 2) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 5),
          curve: Curves.easeInOut,
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: PageView(
        //controller: _pageController,
        // onPageChanged: (index){
        //   setState(() {
        //     _currentIndex=index;
        //   });
        // },
        children: [
          cardView(context),
          cardView(context),
          cardView(context),
        ],
      ),
    );
  }

  Widget cardView(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 190,
                  // width: 390,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(widget.bannerImg), fit: BoxFit.fill),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: SafeGoogleFont(
                          "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.time,
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                widget.showDuration
                                    ? "Career Institute : ${widget.duration}"
                                    : "Allen career institute,\n by Anshika Mehra - ${widget.participants}",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          customEnrollButton(
                              onPresssed: () {},
                              title: "Free Enroll",
                              context: context)
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: const Color(0xffAFAFAF),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xff7F90F7),
                            child: Center(
                              child: Image.asset(
                                "assets/page-1/images/group-38-oFX.png",
                                width: 17,
                                height: 17,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          customRegisterNowBtn(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const WebinarDetailsPage(),
                                  ),
                                );
                              },
                              title: widget.btnTitle,
                              isRegisterNow: widget.isRegisterNow)
                        ],
                      )
                    ],
                  ),
                ),
              ]),
        ),
      ],
    );
  }
}

Widget customEnrollButton(
    {required VoidCallback onPresssed,
    required String title,
    required BuildContext context}) {
  return SizedBox(
    height: 30,
    width: 67,
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
    width: 220,
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
