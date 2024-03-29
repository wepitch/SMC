import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/webinar_page/webinar_model.dart';
import 'package:myapp/webinar_page/webinar_past_page.dart';
import 'package:myapp/widget/webinar_detail_page_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WebinarUpcomingPage extends StatefulWidget {
  const WebinarUpcomingPage({super.key});

  @override
  State<WebinarUpcomingPage> createState() => _WebinarUpcomingPageState();
}

class _WebinarUpcomingPageState extends State<WebinarUpcomingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CounsellorDetailsProvider>().fetchWebinar_Data("UpComing");
  }

  @override
  Widget build(BuildContext context) {
    var counsellorSessionProvider = context.watch<CounsellorDetailsProvider>();
    return ListView.builder(
        itemCount: counsellorSessionProvider.webinarList.length,
        itemBuilder: (context, index) {
          WebinarModel webinarModel =
              counsellorSessionProvider.webinarList[index];
          return Padding(
            padding:
                EdgeInsets.only(top: index == 0 ? 30 : 27, right: 16, left: 16),
            child: WebinarUpComingWidget(
              showDuration: false,
              title: "Learn more about CUET and IPMAT",
              isRegisterNow: true,
              btnTitle: "Register Now",
              time: "15 Sep @ 2:00 PM Onwards",
              duration: "60",
              participants: "Unlimited",
              bannerImg: "assets/page-1/images/webinarBanner.png",
              webinarModel: webinarModel,
            ),
          );
        });
  }
}

class WebinarUpComingWidget extends StatefulWidget {
  const WebinarUpComingWidget(
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
  State<WebinarUpComingWidget> createState() => _WebinarUpComingWidgetState();
}

class _WebinarUpComingWidgetState extends State<WebinarUpComingWidget> {
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
      if (currentTime.difference(savedTime).inDays >= 3) {
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
          'startingTimestamp', DateTime.now().millisecondsSinceEpoch);
    } else {
      await _prefs.remove('startingTimestamp');
    }

    await _prefs.setBool('isRegistrationStarting', isStarting);
  }

  static dateTimeDif() {
    DateTime dt1 = DateTime.parse("2024-03-28 06:30:00");
    DateTime dt2 = DateTime.parse("2024-03-28 05:30:00");

    Duration diff = dt1.difference(dt2);

//print(diff.inDays);
//output (in days): 1198

    print(diff.inMinutes);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: cardView(context),
    );
  }

  Widget cardView(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebinarDetailUpComingWidget(
              webinarImg: widget.webinarModel.webinarImage!,
              title: widget.webinarModel.webinarTitle!,
              date: widget.webinarModel.webinarDate!,
              name: widget.webinarModel.webinarBy!,
              joinUrl: widget.webinarModel.joinUrl!,
            ),
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
                Container(
                  height: 190,
                  // width: 390,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image:
                            NetworkImage('${widget.webinarModel.webinarImage}'),
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 20, 20),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Image.asset(
                                "assets/page-1/images/group-38-oFX.png",
                                width: 20,
                                height: 20,
                                color: Color(0xff1F0A68),
                              ),
                            ),
                            customRegisterNow(
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
                                        : 'Starting in ${widget.webinarModel.webnar_startdays} days')
                                    : 'Register Now',
                                isRegisterNow: widget.webinarModel.registered),
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

  Widget customRegisterNow({
    required VoidCallback onPressed,
    required String title,
    required bool isRegisterNow,
  }) {
    Color buttonColor =
        isRegisterNow ? const Color(0xff1F0A68) : const Color(0xff1F0A68);
    Color textColor = isRegisterNow ? Colors.white : Colors.white;

    return SizedBox(
      height: 35,
      width: 232,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: ColorsConst.whiteColor,
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
}

class WebinarDetailUpComingWidget extends StatefulWidget {
  WebinarDetailUpComingWidget(
      {required this.joinUrl,
      required this.name,
      required this.title,
      required this.date,
      required this.webinarImg,
      super.key});

  String webinarImg;
  String title;
  String date;
  String name;
  String joinUrl;

  @override
  State<WebinarDetailUpComingWidget> createState() =>
      _WebinarDetailUpComingWidgetState();
}

class _WebinarDetailUpComingWidgetState
    extends State<WebinarDetailUpComingWidget> {
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

    setState(() {
      _isRegistrationStarting = isStarting;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 320,
                  child: Stack(
                    children: [
                      Container(
                        color: const Color(0xffffffff).withOpacity(0.8),
                        width: double.infinity,
                        height: 280,
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Color(0xff1F0A68),
                                    size: 25,
                                  ),
                                ),
                                Text(
                                  'Webinar Details',
                                  style: SafeGoogleFont("Inter",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: ColorsConst.appBarColor),
                                ),
                                const Spacer(),
                                Image.asset(
                                  "assets/page-1/images/share.png",
                                  color: Color(0xff1F0A68),
                                  height: 23,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 28.0, right: 20, left: 20),
                            child: Container(
                              height: 196,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    widget.webinarImg,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(11, 20, 12, 15),
                      child: Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title,
                              style: SafeGoogleFont("Inter",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff414040)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      child: Row(
                        children: [
                          Text(
                            "Webinar by",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 12,
                              color: fontColor,
                            ),
                          ),
                          Text(
                            widget.name,
                            style: SafeGoogleFont("Inter",
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                color: fontColor),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(11, 9, 15, 8),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/page-1/images/clock.png",
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.date,
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // const Spacer(),
                          // Row(
                          //   children: [
                          //     Image.asset(
                          //       "assets/page-1/images/persons.png",
                          //     ),
                          //     const SizedBox(
                          //       width: 3,
                          //     ),
                          //     Text(
                          //       "44/100",
                          //       style: SafeGoogleFont(
                          //         "Inter",
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.w500,
                          //         color: fontColor,
                          //       ),
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      child: Container(
                        height: 1,
                        color: const Color(0xffAFAFAF).withOpacity(0.54),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Details -",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Text(
                            "\u2022 Online seminars establish you as an expert,a\n  trustworthy and reliable source of information\n\u2022 people are demonstrating an interest in what you are\n  offering – they become qualified leads\n\u2022 valuable content for your domain",
                            style: SafeGoogleFont("Inter",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                height: 1.64),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 19),
                      child: Text(
                        "What will you Learn?",
                        style: SafeGoogleFont(
                          "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 88,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                              left: index == 0 ? 20 : 17,
                            ),
                            height: 88,
                            width: 144,
                            decoration: BoxDecoration(
                              color: const Color(0xffD9D9D9).withOpacity(0.65),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(14, 11, 0, 11),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${index + 1}",
                                        style: SafeGoogleFont(
                                          "Inter",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    index == 0
                                        ? "Detailed information"
                                        : index == 1
                                            ? "Upgrade Knowledge"
                                            : "Interactive learning",
                                    style: SafeGoogleFont(
                                      "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff414040),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 19, 15, 19),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Speaker Profile",
                        style: SafeGoogleFont(
                          "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(
        //     horizontal: 11.0,
        //   ),
        //   child: Card(
        //     color: Colors.white,
        //     child: webinarDetailWidget(
        //       onPressed: () async {
        //         if (!widget.webinarRegister) {
        //           showDialog(
        //             context: context,
        //             builder: (context) {
        //               return AlertDialog(
        //                 title: const Text(
        //                   'Do you want to register for the webinar?',
        //                   style: TextStyle(
        //                     fontSize: 16,
        //                   ),
        //                 ),
        //                 actions: [
        //                   TextButton(
        //                     onPressed: () {
        //                       Navigator.pop(context);
        //                     },
        //                     child: const Text('Cancel'),
        //                   ),
        //                   TextButton(
        //                     onPressed: () async {
        //                       if (widget.webinarRegister &&
        //                           widget.webinarStartDays == 0) {
        //                         launchUrlString(widget.webinarJoinUrl!);
        //                       } else if (widget.webinarRegister) {
        //                         Fluttertoast.showToast(
        //                             msg: 'Participant is already registered');
        //                       } else {
        //                         var value = await ApiService.webinar_regiter(
        //                             widget.webinarId!);
        //
        //                         if (value["error"] ==
        //                             "Participant is already registered") {
        //                           Fluttertoast.showToast(
        //                               msg: 'Participant is already registered');
        //                         } else if (value["message"] ==
        //                             "Registration completed") {
        //                           Fluttertoast.showToast(
        //                               msg:
        //                                   'Registration completed Thanks for registration');
        //                           Navigator.push(
        //                             context,
        //                             MaterialPageRoute(
        //                               builder: (context) => const WebinarPage(),
        //                             ),
        //                           );
        //                         }
        //                       }
        //                       if (mounted) {
        //                         Navigator.pop(context);
        //                       }
        //                       await _updateRegistrationStatus(true);
        //                     },
        //                     child: const Text('Yes'),
        //                   ),
        //                 ],
        //               );
        //             },
        //           );
        //         } else {
        //           Text('has Been Registered');
        //         }
        //       },
        //       title: widget.webinarRegister
        //           ? (widget.webinarStartDays == 0
        //               ? 'Join Now'
        //               : 'Starting in ${widget.webinarStartDays} days')
        //           : 'Join Now',
        //       isRegisterNow: widget.webinarRegister,
        //     ),
        //   ),
        // ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

const fontColor = Color(0xff8E8989);

Widget customButton1({
  required BuildContext context,
  required VoidCallback onPressed,
  required String title,
}) {
  return SizedBox(
    width: double.infinity,
    height: 47,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        foregroundColor:
            title.contains('Join Now') ? Colors.black : Colors.white10,
        backgroundColor: title.contains('Join Now')
            ? Colors.white10
            : const Color(0xff1F0A68),
      ),
      child: Text(
        title,
        style: SafeGoogleFont(
          "Inter",
          fontSize: 20,
          color: title.contains('Join Now') ? Colors.black : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
