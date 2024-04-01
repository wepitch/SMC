import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:myapp/booking_page/checkout_screen.dart';
import 'package:myapp/model/cousnellor_list_model.dart';
import 'package:myapp/model/follower_model.dart';
import 'package:myapp/notify.dart';
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
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../other/api_service.dart';
import 'package:http/http.dart' as http;

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
  //final ListController listController = Get.put(ListController());
  late FollowerProvider followerProvider;
  FollowerModel followerModel = FollowerModel();
  TextEditingController controller = TextEditingController();

  bool visible = false;
  late TabController _controller;
  List<CounsellorModel> counsellorModel = [];
  bool isFollowing = false;
  int followerCount = 0;
  bool hasFollowedBefore = false;
  double rating_val = 0;
  String feedback_msg = '';
  bool isImgUrl_valid = false;
  late Razorpay razorpay;
  String key = "";


  @override
  void initState() {
    super.initState();
    context.read<CounsellorDetailsProvider>().fetchCounsellor_detail(widget.id);
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
    followerProvider = Provider.of<FollowerProvider>(context, listen: false);
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    //_loadData();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFollowing = prefs.getBool(widget.id) ?? false;
    });
  }

  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('followerCount', followerCount);
    prefs.setBool('hasFollowedBefore', hasFollowedBefore);
    prefs.setBool('isFollowing', isFollowing);
  }

  void toggleFollowStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFollowing = !isFollowing;
    });
    prefs.setBool(widget.id, isFollowing);
  }

   void checkImageValidity(String imgUrl) async {
     if(imgUrl.contains("http://")) {
       //nothing
     }
     else{
       imgUrl="https://$imgUrl";
     }
    var url = Uri.parse(imgUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        isImgUrl_valid = true;
      });
    }
    else{
      setState(() {
        isImgUrl_valid = false;
      });
    }
  }

  void openCheckOut(amount) async {
    amount = amount * 100;
    var options = {
      //"key": "rzp_test_1DP5mmOlF5G5ag",
      "key": key,
      "amount": amount,
      "name": "Sort My College",
      "theme.color": "#190E70",
      "currency": "INR",
      "image":
      "data:image/jpeg;base64,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",
      "Prefill": {
        "contact": '1234567890',
        "email": "test@gmail.com",
      },
      "external": {
        "wallets": ["Paytm"]
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response)async {
    Fluttertoast.showToast(
        msg: "Payment Success ${response.paymentId!}",
        toastLength: Toast.LENGTH_SHORT);
    var value =
    await    ApiService.counsellor_create_payment(1,response.paymentId!);
    if (value["error"] ==
        "Order not successfully created") {
      EasyLoading.showToast(value["error"],
          toastPosition:
          EasyLoadingToastPosition.bottom);
    } else if(value["message"] ==
        "Order successfully created"){
      EasyLoading.showToast(value["message"],
          toastPosition:
          EasyLoadingToastPosition.bottom);

    } else{
      EasyLoading.showToast(value["error"],
          toastPosition:
          EasyLoadingToastPosition.bottom);
    }
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Fail ${response.message!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet ${response.walletName!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  Future<void> onPressedAction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(widget.id, !isFollowing);
    prefs.setInt('followerCount', followerCount);
  }

  @override
  Widget build(BuildContext context) {
    var counsellorSessionProvider = context.watch<CounsellorDetailsProvider>();
    var userBookings = context.watch<UserBookingProvider>().userBooking;
    var counsellorDetailController = context.watch<CounsellorDetailsProvider>();
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    checkImageValidity(counsellorDetailController
        .cousnellorlist_detail[0].coverImage);
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: AppBar(
        surfaceTintColor: ColorsConst.whiteColor,
        titleSpacing: -16,
        title: Text(
          // anshikamehra7w6 (2608:501)
          widget.name,
          style: SafeGoogleFont(
            'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1.2125,
            color: const Color(0xff1f0a68),
          ),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  Share.share(
                      'https://play.google.com/store/apps/details?id=com.sortmycollege');
                },
                child: Image.asset(
                  "assets/page-1/images/share.png",
                  color: Color(0xff1F0A68),
                  height: 23,
                ),
              )
          ),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xff1f0a68))),
        backgroundColor: const Color(0xffffffff),
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
                        Align(
                          child: SizedBox(
                            width: 398,
                            height: 201,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: isImgUrl_valid ? Image.network(
                                counsellorDetailController
                                    .cousnellorlist_detail[0].coverImage,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception,
                                    StackTrace? stackTrace) {
                                  //print("Exception >> ${exception.toString()}");
                                  return Image.asset(
                                    'assets/page-1/images/comming_soon.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ) : Image.asset(
                                'assets/page-1/images/comming_soon.png',
                                fit: BoxFit.cover,
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
                                          fontWeight: FontWeight.w600
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
                                    border: Border.all(
                                        color: const Color(0xff1f0a68)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      await onPressedAction();
                                      if(isFollowing){
                                        setState(() {
                                          isFollowing = !isFollowing;
                                           followerCount --;
                                        });
                                      } else{
                                        setState(() {
                                          isFollowing = !isFollowing;
                                           followerCount ++;
                                        });
                                      }
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
                                // onPressed: () async {
                                //   if (isFollowing == true) {
                                //     var value = await ApiService
                                //         .Unfollow_councellor(widget.id);
                                //     if (value["message"] ==
                                //         "User is now unfollowing the counsellor") {
                                //       // EasyLoading.showToast(
                                //       //     value["message"],
                                //       //     toastPosition:
                                //       //         EasyLoadingToastPosition
                                //       //             .bottom);
                                //       setState(() {
                                //         isFollowing = false;
                                //         followerCount--;
                                //       });
                                //     } else if (value["error"] ==
                                //         "Follower not found") {
                                //       // EasyLoading.showToast(value["error"],
                                //       //     toastPosition:
                                //       //         EasyLoadingToastPosition
                                //       //             .bottom);
                                //       setState(() {
                                //         isFollowing = false;
                                //         followerCount--;
                                //       });
                                //     } else {
                                //       // EasyLoading.showToast(value["error"],
                                //       //     toastPosition:
                                //       //         EasyLoadingToastPosition
                                //       //             .bottom);
                                //       setState(() {
                                //         isFollowing = false;
                                //       });
                                //     }
                                //   } else {
                                //     var value =
                                //     await ApiService.Follow_councellor(
                                //         widget.id);
                                //     if (value["message"] ==
                                //         "User is now following the counsellor") {
                                //       // EasyLoading.showToast(
                                //       //     value["message"],
                                //       //     toastPosition:
                                //       //         EasyLoadingToastPosition
                                //       //             .bottom);
                                //       setState(() {
                                //         isFollowing = true;
                                //         followerCount++;
                                //       });
                                //     } else if (value["error"] ==
                                //         "Counsellor is already followed by the user") {
                                //       // EasyLoading.showToast(value["error"],
                                //       //     toastPosition:
                                //       //         EasyLoadingToastPosition
                                //       //             .bottom);
                                //       setState(() {
                                //         isFollowing = true;
                                //         followerCount++;
                                //       });
                                //     } else {
                                //       // EasyLoading.showToast(value["error"],
                                //       //     toastPosition:
                                //       //         EasyLoadingToastPosition
                                //       //             .bottom);
                                //       setState(() {
                                //         isFollowing = false;
                                //       });
                                //     }
                                //   }
                                // },
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
                                      '$followerCount '
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
                                Text('|',style: TextStyle(fontSize: 28,color: Colors.black54),),
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
                            ), Column(
                              children: [
                                Text('|',style: TextStyle(fontSize: 28,color: Colors.black54),),
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
                            ), Column(
                              children: [
                                Text('|',style: TextStyle(fontSize: 28,color: Colors.black54),),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Reviews',
                                    style: TextStyle(
                                        color: ColorsConst.black54Color)),
                                Text(
                                  '${counsellorDetailController.cousnellorlist_detail[0].reviews}',
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
                  // Container(
                  //   height: 40,
                  //   color: Colors.grey[300],
                  //   child: TabBar(
                  //       indicatorColor: const Color(0xff1F0A68),
                  //       indicatorWeight: 2,
                  //       controller: _controller,
                  //       onTap: (value) {
                  //         if (value == 1) {
                  //           Navigator.pushReplacement(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => CounsellorFeedPage(
                  //                         name: counsellorDetailController
                  //                             .cousnellorlist_detail[0].name,
                  //                         id: counsellorDetailController
                  //                             .cousnellorlist_detail[0].id,
                  //                       )));
                  //         }
                  //       },
                  //       tabs: [
                  //         Tab(
                  //           child: Text(
                  //             "Info",
                  //             style: SafeGoogleFont("Inter",
                  //                 fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                  //           ),
                  //         ),
                  //         Tab(
                  //           child: Text(
                  //             "Feed",
                  //             style: SafeGoogleFont("Inter",
                  //                 fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                  //           ),
                  //         ),
                  //       ]),
                  // ),
                  const SizedBox(
                    height: 5,
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
                        Row(
                          children: [
                            Text('\u2022 ',style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),),
                            Text('Evaluate your strengths and weaknesses',style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13),),
                          ],
                        ),
                        Row(
                          children: [
                            Text('\u2022 ',style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),),
                            Text("significant impact on a student's life by providing\nvaluable guidance, support",style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13),),
                          ],
                        ),
                        Row(
                          children: [
                            Text('\u2022 ',style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),),
                            Text("Career counseling provides students with\naccurate and up-to-date information about\nvarious career options",style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13),),
                          ],
                        ),
                        Row(
                          children: [
                            Text('\u2022 ',style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),),
                            Text("career counselor can assist students in setting\nrealistic and achievable goals.",style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13),),
                          ],
                        ),
                        Row(
                          children: [
                            Text('\u2022 ',style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),),
                            Text("Career counseling can identify areas for skill\ndevelopment and suggest resources or training\nopportunities to enhance those skills",style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13),),
                          ],
                        ),
                        /*ReadMoreText(
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
                        ),*/
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
                        Row(
                          children: [
                            RatingBar.builder(
                              initialRating: 1,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 18,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  rating_val = rating;
                                });
                              },
                            ),
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
                          child: TextFormField(
                            onChanged: (value) {
                              feedback_msg = value;
                            },
                            controller: controller,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(
                                    left: 8.0, top: 14, bottom: 10),
                                hintText: 'commit',
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    var value =
                                    await ApiService.Feedback_councellor(
                                        widget.id,rating_val,feedback_msg);
                                    if (value["error"] ==
                                        "Feedback is already given by the user") {
                                      EasyLoading.showToast(value["error"],
                                          toastPosition:
                                          EasyLoadingToastPosition.bottom);
                                    } else{
                                      (value["message"] ==
                                          "Feedback has been successfully added");
                                      EasyLoading.showToast(value["message"],
                                          toastPosition:
                                          EasyLoadingToastPosition.bottom);
                                    }
                                    controller.clear();
                                  },
                                  icon: const Icon(
                                    Icons.send_sharp,
                                    size: 22,
                                    color: Colors.black54,
                                  ),
                                )),
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
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => CounsellingSessionPage2(name: widget.name,id: widget.id,)));
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
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CounsellingSessionPage(name: widget.name,id: widget.id,)));
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildPadding() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
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
                        child: Image.asset(
                          'assets/page-1/images/comming_soon.png',
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


