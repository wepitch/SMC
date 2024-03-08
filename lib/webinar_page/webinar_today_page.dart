import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/notify.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/widget/webinar_detail_page_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WebinarTodayPage extends StatelessWidget {
  const WebinarTodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding:
              EdgeInsets.only(top: index == 0 ? 15 : 2, right: 16, left: 16),
          child: CustomWebinarCard1(
            showDuration: true,
            title: "Learn more about CUET and IPMAT",
            isRegisterNow: index == 0 ? true : false,
            btnTitle: "Register Now",
            time: "15 Sep @ 2:00 PM Onwards",
            duration: "60",
            participants: "Unlimited",
            bannerImg: "assets/page-1/images/webinarBanner.png",
          ),
        );
      },
    );
  }
}

class CustomWebinarCard1 extends StatefulWidget {
  const CustomWebinarCard1({
    super.key,
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
  late SharedPreferences _prefs;
  bool _isRegistrationStarting = false;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    bool isStarting = _prefs.getBool('isRegistrationStarting') ?? false;

    if (isStarting) {
      DateTime savedTime = DateTime.fromMillisecondsSinceEpoch(
        _prefs.getInt('startingTimestamp') ?? 0,
      );

      DateTime currentTime = DateTime.now();
      if (currentTime.difference(savedTime).inSeconds >= 20) {
        await _updateRegistrationStatus(false);
      } else {
        setState(() {
          _isRegistrationStarting = true;
        });
      }
    }
  }

  Future<void> _updateRegistrationStatus(bool isStarting) async {
    setState(() {
      _isRegistrationStarting = isStarting;
    });

    if (isStarting) {
      await _prefs.setInt(
        'startingTimestamp',
        DateTime.now().millisecondsSinceEpoch,
      );
    } else {
      await _prefs.remove('startingTimestamp');
    }
    await _prefs.setBool('isRegistrationStarting', isStarting);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: cardView(context),
    );
  }

  Widget cardView(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   SlideRightRoute(const WebinarDetailsPageWidget()),
        // );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const WebinarDetailsPageWidget()));
      },
      child: Column(
        children: [
          Card(
            color: ColorsConst.whiteColor,
            surfaceTintColor: ColorsConst.whiteColor,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                    color: ColorsConst.redColor,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(widget.bannerImg),
                      fit: BoxFit.fill,
                    ),
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
                          // customEnrollButton(
                          //   onPresssed: () {},
                          //   title: "Free Enroll",
                          //   context: context,
                          // ),
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
                          GestureDetector(
                            onTap: (){
                              Share.share('https://play.google.com/store/apps/details?id=com.sortmycollege');
                            },
                            child: CircleAvatar(
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
                          ),
                          customRegisterNowBtn(
                            onPressed: () async {
                              if (!_isRegistrationStarting) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Do you want to register for the webinar?',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            launchUrlString(
                                                'https://app.zoom.us/wc/join/6876923575?fromPWA=1&pwd=GCbNDEgI1W9UmcjX4H3A5NlhJbv0Gs.1&_x_zm_rtaid=dMkrHAzTSv2KH-k63GFIIg.1709188412516.3a0d504b72c1403587e5715af973a35f&_x_zm_rhtaid=220');
                                            if (mounted) {
                                              Navigator.pop(context);
                                            }
                                            await _updateRegistrationStatus(
                                                true);
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                Text('has Been Registered');
                              }
                            },
                            title: _isRegistrationStarting
                                ? 'Starting in 2 days'
                                : 'Register Now',
                            isRegisterNow: _isRegistrationStarting,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget customRegisterNowBtn({
  required VoidCallback onPressed,
  required String title,
  required bool isRegisterNow,
}) {
  Color buttonColor =
      isRegisterNow ? Colors.white : const Color.fromARGB(255, 189, 173, 241);
  Color textColor = isRegisterNow ? Colors.black : Colors.white;

  return SizedBox(
    height: 42,
    width: 200,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        foregroundColor: textColor,
        backgroundColor: buttonColor,
      ),
      child: Text(
        title,
        style: SafeGoogleFont(
          "Inter",
          fontSize: 15,
          fontWeight: isRegisterNow ? FontWeight.w500 : FontWeight.w500,
        ),
      ),
    ),
  );
}
