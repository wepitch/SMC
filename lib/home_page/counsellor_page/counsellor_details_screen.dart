import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:myapp/home_page/counsellor_page/counsellor_feed_page.dart';
import 'package:myapp/model/cousnellor_list_model.dart';
import 'package:myapp/model/follower_model.dart';
import 'package:myapp/other/listcontroler.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/other/provider/follower_provider.dart';
import 'package:myapp/other/provider/user_booking_provider.dart';
import 'package:myapp/page-1/counslleing_session2.dart';
import 'package:myapp/page-1/dashboard_session_page.dart';
import 'package:myapp/page-1/payment_gateaway.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounsellorDetailsScreen extends StatefulWidget {
  const CounsellorDetailsScreen({
    required this.id,
    required this.name,
    super.key,
  });

  final String id;
  final String name;

  @override
  State<CounsellorDetailsScreen> createState() =>
      _CounsellorDetailsScreenState();
}

class _CounsellorDetailsScreenState extends State<CounsellorDetailsScreen>
    with SingleTickerProviderStateMixin {
  final ListController listController = Get.put(ListController());
  late FollowerProvider followerProvider;
  FollowerModel followerModel = FollowerModel();

  bool visible = false;
  late TabController _controller;
  List<CounsellorModel> counsellorModel = [];
  bool isFollowing = false;
  int followerCount = 0;
  bool hasFollowedBefore = false;

  @override
  void initState() {
    super.initState();
    context.read<CounsellorDetailsProvider>().fetchCounsellor_detail(widget.id);
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
    followerProvider = Provider.of<FollowerProvider>(context,listen: false);
    _loadData();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      followerCount = prefs.getInt('followerCount') ?? 0;
      hasFollowedBefore = prefs.getBool('hasFollowedBefore') ?? false;
      isFollowing = prefs.getBool('isFollowing') ?? false;
    });
  }

  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('followerCount', followerCount);
    prefs.setBool('hasFollowedBefore', hasFollowedBefore);
    prefs.setBool('isFollowing', isFollowing);
  }

  @override
  Widget build(BuildContext context) {
    var userBookings = context.watch<UserBookingProvider>().userBooking;
    var counsellorDetailController = context.watch<CounsellorDetailsProvider>();
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Text(
            // anshikamehra7w6 (2608:501)
            widget.name,
            style: SafeGoogleFont(
              'Inter',
              fontSize: 19,
              fontWeight: FontWeight.w600,
              height: 1.2125,
              color: const Color(0xffffffff),
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        backgroundColor: const Color(0xff1f0a68),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Positioned(
                          // beautifulbusinesswomanportrait (2958:523)
                          left: 15.75,
                          top: 13,
                          child: Align(
                            child: SizedBox(
                              width: 398,
                              height: 201,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  counsellorDetailController
                                          .cousnellorlist_detail[0].coverImage
                                          .contains("http")
                                      ? counsellorDetailController
                                          .cousnellorlist_detail[0].coverImage
                                      : "https://media.gettyimages.com/id/1334712074/vector/coming-soon-message.jpg?s=612x612&w=0&k=20&c=0GbpL-k_lXkXC4LidDMCFGN_Wo8a107e5JzTwYteXaw=",
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    //print("Exception >> ${exception.toString()}");
                                    return Image.asset(
                                      'assets/page-1/images/comming_soon.png',
                                      fit: BoxFit.fill,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text(
                                      widget.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff1f0a68),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Image.asset(
                                    'assets/page-1/images/group-MqT.png',
                                    width: 15,
                                    height: 15.35),
                                const SizedBox(width: 6),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/page-1/images/group-ZqT.png',
                                      width: 15,
                                      height: 15.27,
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      'Today 14 Sessions',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                // hasFollowedBefore
                                //     ? Container()
                                //     :
                                Container(
                                  width: 110,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xff1f0a68)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      await context.read<FollowerProvider>().toggleFollowState(followerModel,widget.id);
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      backgroundColor: isFollowing
                                          ? Colors.white
                                          : const Color(0xff1f0a68),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        isFollowing ? 'Following' : 'Follow',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          height: 1.2125,
                                          color: isFollowing
                                              ? Colors.black
                                              : const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/page-1/images/group-NC9.png',
                                      width: 16,
                                      height: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      // followingweY (2958:442)
                                      '${counsellorDetailController.cousnellorlist_detail[0].followersCount} '
                                      "Following",
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        height: 1.2125,
                                        color: const Color(0xff5c5b5b),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text('Experience',
                                    style: TextStyle(
                                        color: ColorsConst.black54Color)),
                                Text(
                                  '${counsellorDetailController.cousnellorlist_detail[0].experienceInYears} + yrs',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Session',
                                    style: TextStyle(
                                        color: ColorsConst.black54Color)),
                                Text(
                                  '${counsellorDetailController.cousnellorlist_detail[0].totalSessionsAttended}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Rewards',
                                    style: TextStyle(
                                        color: ColorsConst.black54Color)),
                                Text(
                                  '${counsellorDetailController.cousnellorlist_detail[0].averageRating}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Reviews',
                                    style: TextStyle(
                                        color: ColorsConst.black54Color)),
                                Text(
                                  '${listController.cousnellorlist_data[0].reviews}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    color: Colors.grey[300],
                    child: TabBar(
                        indicatorColor: const Color(0xff1F0A68),
                        indicatorWeight: 3,
                        controller: _controller,
                        onTap: (value) {
                          if (value == 1) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CounsellorFeedPage(
                                          name: counsellorDetailController
                                              .cousnellorlist_detail[0].name,
                                          id: counsellorDetailController
                                              .cousnellorlist_detail[0].id,
                                        )));
                          }
                        },
                        tabs: [
                          Tab(
                            child: Text(
                              "Info",
                              style: SafeGoogleFont("Inter",
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Feed",
                              style: SafeGoogleFont("Inter",
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'How Will I Help?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        ReadMoreText(
                          counsellorDetailController
                              .cousnellorlist_detail[0].howIWillHelpYou
                              .map((e) => "\u2022 $e")
                              .join("\n"),
                          style: SafeGoogleFont(
                            'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 2,
                            color: const Color(0xFF595959),
                          ),
                          trimLines: 1,
                          // trimLength: 20,
                          trimCollapsedText: "\nRead more..",
                          trimExpandedText: "\nShow less..",
                          moreStyle: SafeGoogleFont(
                            'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            height: 1.5549999555,
                            color: const Color(0xff040404),
                          ),
                          lessStyle: SafeGoogleFont(
                            'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            height: 1.5549999555,
                            color: const Color(0xff040404),
                          ),
                        ),
                        const Text(
                          'More Information',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            Image.asset(
                              'assets/page-1/images/diploma.png',
                              fit: BoxFit.cover,
                              height: 18,
                              width: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              // uiuxdesignercertificateazurece (2958:484)
                              counsellorDetailController
                                      .cousnellorlist_detail[0]
                                      .qualifications
                                      .isEmpty
                                  ? "N/A"
                                  : counsellorDetailController
                                      .cousnellorlist_detail[0].qualifications
                                      .join(', '),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.7034202251,
                                color: Color(0xff8e8989),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            Image.asset(
                              'assets/page-1/images/group-369.png',
                              width: 18,
                              height: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              counsellorDetailController
                                      .cousnellorlist_detail[0]
                                      .languages!
                                      .isEmpty
                                  ? "N/A"
                                  : counsellorDetailController
                                      .cousnellorlist_detail[0].languages!
                                      .join(","),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.2125,
                                color: Color(0xff8e8989),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            Image.asset(
                              'assets/page-1/images/maps-and-flags.png',
                              fit: BoxFit.cover,
                              height: 18,
                              width: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "${counsellorDetailController.cousnellorlist_detail[0].location?.state},${counsellorDetailController.cousnellorlist_detail[0].location?.city},${counsellorDetailController.cousnellorlist_detail[0].location?.country},${counsellorDetailController.cousnellorlist_detail[0].location?.pincode}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.2125,
                                color: Color(0xff8e8989),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            Image.asset(
                              'assets/page-1/images/sex.png',
                              fit: BoxFit.cover,
                              height: 17,
                              width: 17,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              counsellorDetailController
                                  .cousnellorlist_detail[0].gender,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.2125,
                                color: Color(0xff8e8989),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            Image.asset(
                              'assets/page-1/images/age.png',
                              fit: BoxFit.cover,
                              height: 18,
                              width: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              // qZz (2958:543)
                              counsellorDetailController
                                          .cousnellorlist_detail[0].age ==
                                      null
                                  ? "N/A"
                                  : counsellorDetailController
                                      .cousnellorlist_detail[0].age
                                      .toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.2125,
                                color: Color(0xff8e8989),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Client Testimonials',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.2125,
                            color: Color(0xff000000),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.26,
                          child: PageView(
                            children: [
                              buildPadding(),
                              buildPadding(),
                              buildPadding(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text('Give a Review',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            SizedBox(width: 6),
                            Icon(Icons.star_border,
                                color: Colors.amber, size: 18),
                            Icon(Icons.star_border,
                                color: Colors.amber, size: 18),
                            Icon(Icons.star_border,
                                color: Colors.amber, size: 18),
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            Icon(Icons.star, color: Colors.amber, size: 18),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text('commit',
                                    style: TextStyle(color: Colors.black38)),
                                const Spacer(),
                                Image.asset(
                                  'assets/page-1/images/ic-baseline-send.png',
                                  width: 21,
                                  height: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // HiddenText(
                        //     id: '${userBookings[0].bookedEntity?.clientTestimonials?[0].id}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            // group371aXa (2936:506)
            //width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  // autogroupuuww8oz (obZ7jq9Hv3ndwJa9LuuwW)
                  width: double.infinity,
                  height: 113 * fem,
                  child: Expanded(
                    child: Stack(
                      children: [
                        Positioned(
                          // frame324GvC (2936:447)
                          left: 0 * fem,
                          top: 55 * fem,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                16 * fem, 8 * fem, 16 * fem, 8 * fem),
                            width: 430 * fem,
                            height: 57 * fem,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0x35000000)),
                            ),
                            child: SizedBox(
                              // group370NiL (2936:483)
                              width: double.infinity,
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // group347Kda (2936:448)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 115 * fem, 0 * fem),
                                    height: double.infinity,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // group345fBe (2936:458)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5 * fem, 0 * fem),
                                          width: 42 * fem,
                                          height: double.infinity,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // group298bLC (2936:459)
                                                left: 0 * fem,
                                                top: 0 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 42 * fem,
                                                    height: 41 * fem,
                                                    child: Image.asset(
                                                      'assets/page-1/images/group-298.png',
                                                      width: 42 * fem,
                                                      height: 41 * fem,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // conversationi9v (2936:461)
                                                left: 10.7692871094 * fem,
                                                top: 9.4614257812 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 21.54 * fem,
                                                    height: 21.03 * fem,
                                                    child: Image.asset(
                                                      'assets/page-1/images/conversation.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // group346qEY (2936:449)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0.5 * fem, 0 * fem, 1 * fem),
                                          width: 115 * fem,
                                          height: double.infinity,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // personalsessionmdz (2936:453)
                                                left: 0 * fem,
                                                top: 0 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 97 * fem,
                                                    height: 15 * fem,
                                                    child: Text(
                                                      'Personal Session',
                                                      style: SafeGoogleFont(
                                                        'Inter',
                                                        fontSize: 12 * ffem,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height:
                                                            1.2125 * ffem / fem,
                                                        color: const Color(
                                                            0xff000000),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // group344gW4 (2936:454)
                                                left: 0 * fem,
                                                top: 14.5 * fem,
                                                child: SizedBox(
                                                  width: 115 * fem,
                                                  height: 25 * fem,
                                                  child: Expanded(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          // rupeebsv (2936:457)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  2 * fem,
                                                                  1 * fem),
                                                          width: 11 * fem,
                                                          height: 14 * fem,
                                                          child: Image.asset(
                                                            'assets/page-1/images/rupee-12.png',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Container(
                                                          // LKi (2936:455)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          child: Text(
                                                            counsellorDetailController
                                                                        .cousnellorlist_detail[
                                                                            0]
                                                                        .personalSessionPrice ==
                                                                    null
                                                                ? "0"
                                                                : counsellorDetailController
                                                                    .cousnellorlist_detail[
                                                                        0]
                                                                    .personalSessionPrice
                                                                    .toString(),
                                                            style:
                                                                SafeGoogleFont(
                                                              'Inter',
                                                              fontSize:
                                                                  20 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height: 1.2125 *
                                                                  ffem /
                                                                  fem,
                                                              color: const Color(
                                                                  0xff000000),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          // onwardsTfE (2936:456)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  4 * fem,
                                                                  0 * fem,
                                                                  0 * fem),
                                                          child: Text(
                                                            ' Onwards',
                                                            style:
                                                                SafeGoogleFont(
                                                              'Inter',
                                                              fontSize:
                                                                  12 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 1.2125 *
                                                                  ffem /
                                                                  fem,
                                                              color: const Color(
                                                                  0xff6b6b6b),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          const CounsellingSessionPage2(name: '', id: '',)
                                      );
                                    },
                                    child: Container(
                                      // group349P36 (2936:462)
                                      width: 116 * fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff1f0a68),
                                        borderRadius:
                                            BorderRadius.circular(5 * fem),
                                      ),
                                      child: Center(
                                        child: Center(
                                          child: Text(
                                            'Book',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 16 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2125 * ffem / fem,
                                              color: const Color(0xffffffff),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // frame32649E (2936:484)
                          left: 0 * fem,
                          top: 0 * fem,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                16 * fem, 8 * fem, 16 * fem, 8 * fem),
                            width: 430 * fem,
                            height: 57 * fem,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0x35000000)),
                            ),
                            child: SizedBox(
                              // group370y1J (2936:485)
                              width: double.infinity,
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // group347XHi (2936:486)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 123 * fem, 0 * fem),
                                    height: double.infinity,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // autogroupvexiTSG (obZYj7WRacadntT6aVeXi)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 8 * fem, 0 * fem),
                                          width: 42 * fem,
                                          height: double.infinity,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // group345C8x (2936:496)
                                                left: 0 * fem,
                                                top: 0 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 42 * fem,
                                                    height: 41 * fem,
                                                    child: Image.asset(
                                                      'assets/page-1/images/ellipse-47-xPB.png',
                                                      width: 42 * fem,
                                                      height: 41 * fem,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // usersgroupJxg (2936:503)
                                                left: 11 * fem,
                                                top: 10 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 21 * fem,
                                                    height: 21 * fem,
                                                    child: Image.asset(
                                                      'assets/page-1/images/usergroup.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // group346EbS (2936:487)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0.5 * fem, 0 * fem, 1 * fem),
                                          width: 105 * fem,
                                          height: double.infinity,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // groupsessionZtc (2936:491)
                                                left: 0 * fem,
                                                top: 0 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 83 * fem,
                                                    height: 15 * fem,
                                                    child: Text(
                                                      'Group Session',
                                                      style: SafeGoogleFont(
                                                        'Inter',
                                                        fontSize: 12 * ffem,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height:
                                                            1.2125 * ffem / fem,
                                                        color: const Color(
                                                            0xff000000),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // group344UEt (2936:492)
                                                left: 0 * fem,
                                                top: 14.5 * fem,
                                                child: SizedBox(
                                                  width: 105 * fem,
                                                  height: 25 * fem,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        // rupeezU8 (2936:495)
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0 * fem,
                                                                0 * fem,
                                                                2 * fem,
                                                                1 * fem),
                                                        width: 11 * fem,
                                                        height: 14 * fem,
                                                        child: Image.asset(
                                                          'assets/page-1/images/rupee-12.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Text(
                                                        // vcg (2936:493)
                                                        counsellorDetailController
                                                                    .cousnellorlist_detail[
                                                                        0]
                                                                    .groupSessionPrice ==
                                                                null
                                                            ? "0"
                                                            : counsellorDetailController
                                                                .cousnellorlist_detail[
                                                                    0]
                                                                .groupSessionPrice
                                                                .toString(),
                                                        style: SafeGoogleFont(
                                                          'Inter',
                                                          fontSize: 20 * ffem,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 1.2125 *
                                                              ffem /
                                                              fem,
                                                          color: const Color(
                                                              0xff000000),
                                                        ),
                                                      ),
                                                      Container(
                                                        // onwards5Va (2936:494)
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0 * fem,
                                                                4 * fem,
                                                                0 * fem,
                                                                0 * fem),
                                                        child: Text(
                                                          ' Onwards',
                                                          style: SafeGoogleFont(
                                                            'Inter',
                                                            fontSize: 12 * ffem,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.2125 *
                                                                ffem /
                                                                fem,
                                                            color: const Color(
                                                                0xff6b6b6b),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          const CounsellingSessionPage(name: "", id: '',),
                                      );
                                    },
                                    child: Container(
                                      // group349oRa (2936:500)
                                      width: 116 * fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff1f0a68),
                                        borderRadius:
                                            BorderRadius.circular(5 * fem),
                                      ),
                                      child: Center(
                                        child: Center(
                                          child: Text(
                                            'Book',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 16 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2125 * ffem / fem,
                                              color: const Color(0xffffffff),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildPadding() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8,top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.arrow_back_ios, size: 16, color: Colors.grey),
          Expanded(
            child: Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 14),
                  Container(
                    height: 46,
                    width: 46,
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: ClipOval(
                        child: Image.network(
                          "https://media.gettyimages.com/id/1334712074/vector/coming-soon-message.jpg?s=612x612&w=0&k=20&c=0GbpL-k_lXkXC4LidDMCFGN_Wo8a107e5JzTwYteXaw=",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Very good counsellor'),
                ],
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}

void onTapBook(BuildContext context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const PaymentGateAway()));
}
