import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/webinar_page/webinar_details_page.dart';
import 'package:myapp/webinar_page/webinar_past_page.dart';

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
        required this.showDuration,
        this.enableAutoScroll = false,
      });

  final bool isRegisterNow;
  final String btnTitle;
  final String title;
  final String time;
  final String duration;
  final String participants;
  final String bannerImg;
  final bool showDuration;
  final bool enableAutoScroll;
  @override
  State<CustomWebinarCard> createState() => _CustomWebinarCardState();
}

class _CustomWebinarCardState extends State<CustomWebinarCard> {
    int _currentIndex = 0;
   PageController _pageController = PageController(initialPage: 0);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    if(widget.enableAutoScroll) {
      //_startTimer();
      _pageController = PageController(initialPage: _currentIndex);

    }
  }


@override
void dispose() {
  _pageController.dispose();
  super.dispose();
}

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentIndex < 2) {
        _pageController.nextPage(
          duration: const Duration(seconds: 6),
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
      height: MediaQuery.of(context).size.height * 0.6,
      child: PageView(
      controller: _pageController,
      onPageChanged: (index) {
    setState(() {
    _currentIndex = index;
    });
    },
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
        Row(
          children: [
            Expanded(
              child: Card(
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
            ),
            GestureDetector(
              onTap: (){
                if (_currentIndex < 2) {
                  _pageController.animateToPage(
                    _currentIndex + 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
                child: const Icon(Icons.arrow_forward_ios)),
          ],
        ),
      ],
    );
  }
}


class CustomWebinarCard1 extends StatefulWidget {
  const CustomWebinarCard1(
      {super.key,
        required this.isRegisterNow,
        required this.btnTitle,
        required this.time,
        required this.duration,
        required this.participants,
        required this.bannerImg,
        required this.title,
        required this.showDuration,
        this.enableAutoScroll = false,
      });

  final bool isRegisterNow;
  final String btnTitle;
  final String title;
  final String time;
  final String duration;
  final String participants;
  final String bannerImg;
  final bool showDuration;
  final bool enableAutoScroll;
  @override
  State<CustomWebinarCard1> createState() => _CustomWebinarCard1State();
}

class _CustomWebinarCard1State extends State<CustomWebinarCard1> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: cardView(context),
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