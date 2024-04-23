import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/home_page/homepage.dart';
import 'package:myapp/home_page/model/tranding_webinar_model.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/webinar_page/webinar_details_page.dart';
import 'package:myapp/webinar_page/webinar_model.dart';
import 'package:myapp/webinar_page/webinar_page.dart';
import 'package:myapp/webinar_page/webinar_past_page.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../other/provider/counsellor_details_provider.dart';

class CustomWebinarCard extends StatefulWidget {
   CustomWebinarCard({
    super.key,
    required this.trandingWebinarModel,
  });

  TrandingWebinarModel trandingWebinarModel;

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
    // if (widget.enableAutoScroll) {
    //   //_startTimer();
    //   _pageController = PageController(initialPage: _currentIndex);
    // }
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
      height: MediaQuery.of(context).size.height * 0.5,
      child: PageView(
        children: [
          cardView(context),
        ],
        // controller: _pageController,
        // onPageChanged: (index) {
        //   setState(() {
        //     _currentIndex = index;
        //   });
        // },
      ),
    );
  }

  Widget cardView(BuildContext context) {
    return Column(
      children: [
        Card(
          shadowColor: ColorsConst.whiteColor,
          color: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                      image: NetworkImage(widget.trandingWebinarModel.webinarImage!), fit: BoxFit.fill),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.trandingWebinarModel.webinarBy!,
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
                              widget.trandingWebinarModel.webinarDate!,
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
                              widget.trandingWebinarModel.webinarTitle!,
                              style: SafeGoogleFont(
                                "Inter",
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        // customEnrollButton(
                        //     onPresssed: () {},
                        //     title: "Free Enroll",
                        //     context: context)
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: const Color(0xffAFAFAF),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Share.share(
                                  'https://play.google.com/store/apps/details?id=com.sortmycollege');
                            },
                            child: Center(
                              child: Image.asset(
                                "assets/page-1/images/group-38-oFX.png",
                                width: 20,
                                height: 20,
                                color: Color(0xFF1F0A68),
                              ),
                            ),
                          ),
                          registerNowWidget(
                            onPressed: () async {
                              if (!widget.trandingWebinarModel.registered!) {
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
                                            if (widget.trandingWebinarModel.registered! &&
                                                widget.trandingWebinarModel.webinarStartingInDays == 0) {
                                              launchUrlString(widget.trandingWebinarModel.webinarJoinUrl!);
                                            } else if (widget.trandingWebinarModel.registered!) {
                                              Fluttertoast.showToast(
                                                  msg: 'Participant is already registered');
                                            } else {
                                              var value = await ApiService.webinar_regiter(
                                                  widget.trandingWebinarModel.id!);

                                              if (value["error"] ==
                                                  "Participant is already registered") {
                                                Fluttertoast.showToast(
                                                    msg: 'Participant is already registered');
                                              } else if (value["message"] ==
                                                  "Registration completed") {
                                                Fluttertoast.showToast(
                                                    msg:
                                                    'Registration completed Thanks for registration');
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const HomePage(),
                                                  ),
                                                );
                                              }
                                            }
                                            if (mounted) {
                                              Navigator.pop(context);
                                            }
                                            //await _updateRegistrationStatus(true);
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
                            title: widget.trandingWebinarModel.registered!
                                ? (widget.trandingWebinarModel.webinarStartingInDays == 0
                                ? 'Join Now'
                                : 'Starting in ${widget.trandingWebinarModel.webinarStartingInDays} days')
                                : 'Join Now',
                            isRegisterNow: widget.trandingWebinarModel.registered!,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget registerNowWidget({
  required VoidCallback onPressed,
  required String title,
  required bool isRegisterNow,
}) {
  Color buttonColor =
      isRegisterNow ? const Color(0xFF1F0A68) : const Color(0xFF1F0A68);
      /*isRegisterNow ? ColorsConst.grayColor : ColorsConst.grayColor;*/

  Color textColor = isRegisterNow ? Colors.white : Colors.white;

  return SizedBox(
    height: 35,
    width: 232,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 2,
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
      required void Function() onRegisterClicked,
      required this.webinarModel});

  final bool isRegisterNow;
  final String btnTitle;
  final String title;
  final String time;
  final String duration;
  final String participants;
  final String bannerImg;
  final bool showDuration;
  final bool enableAutoScroll;
  final WebinarModel webinarModel;

  @override
  State<CustomWebinarCard1> createState() => _CustomWebinarCard1State();
}

class _CustomWebinarCard1State extends State<CustomWebinarCard1> {
  bool _isRegistrationStarting = false;
  late SharedPreferences _prefs;
  Future<void> _updateRegistrationStatus(bool isStarting) async {
    setState(() {
      _isRegistrationStarting = isStarting;
    });

    if (isStarting) {
      await _prefs.setInt(
          'startingTimestamp', DateTime.now().millisecondsSinceEpoch);
    } else {
      await _prefs.remove('startingTimestamp');
    }

    await _prefs.setBool('isRegistrationStarting', isStarting);
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: cardView(context),
    );
  }

  Widget cardView(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WebinarDetailsPageWidget1(),
          ),
        );
      },
      child: Column(
        children: [
          Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ClipRRect(
                //     borderRadius: BorderRadius.circular(8),
                //     child: Image.network(
                //         '${widget.webinarModel.webinarImage}')),
                // Padding(
                //   padding: const EdgeInsets.only(
                //       left: 10, right: 6, top: 6, bottom: 20),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         '${widget.webinarModel.webinarBy}',
                //         style: const TextStyle(
                //             fontSize: 16, fontWeight: FontWeight.w600),
                //       ),
                //       Text(
                //           '${widget.webinarModel.webinarDate}'),
                //       Text(
                //           '${widget.webinarModel.webinarTitle}'),
                //     ],
                //   ),
                // ),
                Container(
                  height: 190,
                  // width: 390,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image:
                            NetworkImage('${widget.webinarModel.webinarImage}'),
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.webinarModel.webinarBy}',
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
                                '${widget.webinarModel.webinarDate}',
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
                                '${widget.webinarModel.webinarTitle}',
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          // customEnrollButton(
                          //     onPresssed: () {},
                          //     title: "Free Enroll",
                          //     context: context)
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: const Color(0xffAFAFAF),
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Share.share(
                                    'https://play.google.com/store/apps/details?id=com.sortmycollege');
                              },
                              child: Center(
                                child: Image.asset(
                                  "assets/page-1/images/group-38-oFX.png",
                                  width: 20,
                                  height: 20,
                                  color: Color(0xFF1F0A68),
                                ),
                              ),
                            ),
                            registerNowWidget(
                                onPressed: () async {
                                  _isRegistrationStarting = widget.webinarModel.registered;
                                  if (widget.webinarModel.registered && widget.webinarModel.webnar_startdays == 0) {
                                    launchUrlString(widget.webinarModel.joinUrl!);
                                  } else if (_isRegistrationStarting) {
                                    Fluttertoast.showToast(
                                        msg: 'Participant is already registered');
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Do you want to register for the webinar?',
                                            style: TextStyle(
                                              fontSize: 14,
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
                                                if (_isRegistrationStarting) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                      'Participant is already registered');
                                                  Navigator.pop(context);
                                                } else {
                                                  var value = await ApiService
                                                      .webinar_regiter(widget
                                                      .webinarModel.id!);
                                                  if (value["error"] ==
                                                      "Participant is already registered") {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                        'Participant is already registered');
                                                  } else if (value["message"] ==
                                                      "Registration completed") {
                                                    Fluttertoast.showToast(msg: 'Registration completed. Thanks for registering');
                                                    widget.webinarModel.registered = true;
                                                    /*Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          WebinarDetailsPageWidget(
                                                        webinarId: widget
                                                            .webinarModel.id!,
                                                        webinarImg: widget
                                                            .webinarModel
                                                            .webinarImage,
                                                        webinarTitle: widget
                                                            .webinarModel
                                                            .webinarTitle,
                                                        webinarDate: widget
                                                            .webinarModel
                                                            .webinarDate,
                                                        webinarBy: widget
                                                            .webinarModel
                                                            .webinarBy,
                                                        webinarSpeaker: widget
                                                            .webinarModel
                                                            .speakerProfile,
                                                        webinarStartDays: widget
                                                            .webinarModel
                                                            .webnar_startdays,
                                                        webinarRegister: widget
                                                            .webinarModel
                                                            .registered,
                                                        webinarJoinUrl: widget
                                                            .webinarModel
                                                            .joinUrl,
                                                      ),
                                                    ),
                                                  );*/
                                                  }
                                                  if (mounted) {
                                                    Navigator.pop(context);
                                                  }
                                                  await _updateRegistrationStatus(
                                                      true);
                                                }
                                              },
                                              child: const Text('Yes'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                title: widget.webinarModel.registered
                                    ? (widget.webinarModel.webnar_startdays == 0
                                    ? 'Join Now'
                                    : 'Starting ${widget.webinarModel.webnar_startdays} ago')
                                    //: 'Occurred ${widget.webinarModel.webnar_startdays} days ago')
                                    : 'Register Now',
                                isRegisterNow: widget.webinarModel.registered)
                          ],
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
    );
  }
}

Widget customRegisterNow({
  required VoidCallback onPressed,
  required String title,
  required bool isRegisterNow,
}) {
  Color buttonColor = isRegisterNow ? Colors.white : Colors.white;
  Color textColor = isRegisterNow ? Colors.black : Colors.black;

  return SizedBox(
    height: 35,
    width: 232,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 2,
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
          fontSize: 14,
          fontWeight: isRegisterNow ? FontWeight.w500 : FontWeight.w500,
        ),
      ),
    ),
  );
}
