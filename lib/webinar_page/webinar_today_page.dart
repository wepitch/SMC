import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/notify.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/widget/webinar_detail_page_widget.dart';
import 'package:provider/provider.dart';
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
              EdgeInsets.only(top: index == 0 ? 14 : 2, right: 16, left: 16),
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
  String register_status = '';

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
    context.read<CounsellorDetailsProvider>().fetchWebinar_Data("Today");
    context.read<CounsellorDetailsProvider>().fetchCounsellor_detail('0');
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
      height: MediaQuery.of(context).size.height * 0.45,
      child: cardView(context),
    );
  }

  Widget cardView(BuildContext context) {
    var counsellorSessionProvider = context.watch<CounsellorDetailsProvider>();
    var counsellorDetailController = context.watch<CounsellorDetailsProvider>();

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
            shadowColor: ColorsConst.whiteColor,
            color: ColorsConst.whiteColor,
            surfaceTintColor: ColorsConst.whiteColor,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ClipRRect(
                //     borderRadius: BorderRadius.circular(8),
                //     child: Image.network(
                //         '${counsellorSessionProvider.webinarModel[0].webinarImage}')),
                // Padding(
                //   padding: const EdgeInsets.only(
                //       left: 10, right: 6, top: 6, bottom: 20),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         '${counsellorSessionProvider.webinarModel[0].webinarBy}',
                //         style: const TextStyle(
                //             fontSize: 16, fontWeight: FontWeight.w600),
                //       ),
                //       Text(
                //           '${counsellorSessionProvider.webinarModel[0].webinarDate}'),
                //       Text(
                //           '${counsellorSessionProvider.webinarModel[0].webinarTitle}'),
                //     ],
                //   ),
                // ),
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                    color: ColorsConst.redColor,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          '${counsellorSessionProvider.webinarModel[0].webinarImage}'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 4, 20, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${counsellorSessionProvider.webinarModel[0].webinarBy}',
                        style: SafeGoogleFont(
                          "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${counsellorSessionProvider.webinarModel[0].webinarDate}',
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${counsellorSessionProvider.webinarModel[0].webinarTitle}',
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 11,
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
                        height: 8,
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: const Color(0xffAFAFAF),
                      ),
                      const SizedBox(
                        height: 10,
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
                                  color: Color(0xff1F0A68),
                                ),
                              ),
                            ),
                            customRegisterNowBtn(
                              onPressed: () async {
                                if (_isRegistrationStarting == true) {
                                  var value =
                                      await ApiService.webinar_regiter("65fe5f56f4d4d9b322f8aa2d");
                                  setState(() {
                                    register_status = value["webinar_starting_in_days"];
                                  });
                                  if (value["message"] == "Registration completed") {
                                    setState(() {
                                      _isRegistrationStarting = true;
                                      register_status = value["webinar_starting_in_days"];
                                    });
                                  }
                                }
                              },
                              title: _isRegistrationStarting
                                  ? 'Register Now'
                                  : 'Starting in $register_status days',
                              isRegisterNow: _isRegistrationStarting,
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
  Color buttonColor = isRegisterNow ? Colors.white : const Color(0xff1F0A68);
  Color textColor = isRegisterNow ? Colors.black : Colors.white;

  return SizedBox(
    height: 35,
    width: 232,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 4,
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
