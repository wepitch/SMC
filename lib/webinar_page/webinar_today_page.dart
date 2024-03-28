import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/notify.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/webinar_page/webinar_model.dart';
import 'package:myapp/widget/webinar_detail_page_widget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WebinarTodayPage extends StatefulWidget {
  const WebinarTodayPage({super.key});

  @override
  State<WebinarTodayPage> createState() => _WebinarTodayPageState();
}

class _WebinarTodayPageState extends State<WebinarTodayPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CounsellorDetailsProvider>().fetchWebinar_Data("Today");
  }
  @override
  Widget build(BuildContext context) {
    var counsellorSessionProvider = context.watch<CounsellorDetailsProvider>();
    return ListView.builder(
      itemCount: counsellorSessionProvider.webinarList.length,
      itemBuilder: (context, index) {
        WebinarModel webinarModel = counsellorSessionProvider.webinarList[index];
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
            webinarModel: webinarModel,
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
    required this.webinarModel
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
  final WebinarModel webinarModel;

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
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   SlideRightRoute(const WebinarDetailsPageWidget()),
        // );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  WebinarDetailsPageWidget(webinarId: widget.webinarModel.id!)));
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
                          '${widget.webinarModel.webinarImage}'),
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
                        '${widget.webinarModel.webinarBy}',
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
                                '${widget.webinarModel.webinarDate}',
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${widget.webinarModel.webinarTitle}',
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
                                _isRegistrationStarting = widget.webinarModel.registered;
                                if (widget.webinarModel.registered && widget.webinarModel.webnar_startdays == 0) {
                                  launchUrlString(
                                      widget.webinarModel.joinUrl!);
                                } else if(_isRegistrationStarting){
                                  Fluttertoast.showToast(
                                      msg: 'Participant is already registered');
                                } else
                                {
                                  var value = await ApiService.webinar_regiter(
                                      widget.webinarModel.id!);
                                  /*setState(() {
                                    _isRegistrationStarting = value["message"] == "Registration completed";
                                  });
                                  if (_isRegistrationStarting) {
                                    _isRegistrationStarting = value["message"] == "Registration completed";
                                  } else {
                                    _isRegistrationStarting = value["error"] == "Participant is already registered";
                                  }*/
                                  if (value["error"] == "Participant is already registered") {
                                    Fluttertoast.showToast(msg: 'Participant is already registered');
                                  } else if (value["message"] == "Registration completed") {
                                    Fluttertoast.showToast(msg: 'Registration completed Thanks for registration');
                                    Navigator.push(
                                        context, MaterialPageRoute(
                                        builder: (context) => WebinarDetailsPageWidget(webinarId: widget.webinarModel.id!,
                                        )));
                                  }
                                }
                              },
                              title: widget.webinarModel.registered
                                  ? (widget.webinarModel.webnar_startdays == 0 ? 'Join Now' : 'Starting in ${widget.webinarModel.webnar_startdays} days')
                                  : 'Register Now',
                              isRegisterNow: widget.webinarModel.registered,
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
