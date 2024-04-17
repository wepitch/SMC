import 'package:flutter/material.dart';
import 'package:myapp/booking_page/checkout_screen.dart';
import 'package:myapp/other/constants.dart';
import 'package:myapp/page-1/dashboard-session-group-new.dart';
import 'package:myapp/home_page/homepagecontainer_2.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard-session-personnel-new.dart';

class CounsellingSessionPage extends StatefulWidget {
  const CounsellingSessionPage(
      {super.key,
      required this.name,
      required this.id,
      required this.designation});

  final String name;
  final String id;
  final String designation;

  @override
  State<CounsellingSessionPage> createState() => _CounsellingSessionPageState();
}

class _CounsellingSessionPageState extends State<CounsellingSessionPage> {
  late PageController _controller;
  int selectedIndex = 0;

  // late Razorpay razorpay;
  TextEditingController amountController = TextEditingController();
  String email = '';
  var data;

  void getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email") ?? "N/A";
    setState(() {});
  }

  //updated

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail();
    _controller = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    // razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double baseWidth = 430;
    // double fem = MediaQuery.of(context).size.width / baseWidth;
    // double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        surfaceTintColor: AppColors.whiteColor,
        backgroundColor: const Color(0xffffffff),
        foregroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0, top: 18, bottom: 18),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/page-1/images/back.png',
              color: Color(0xff1F0A68),
            ),
          ),
        ),
        titleSpacing: -5,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckOutScreen(
                  name: widget.name,
                  id: widget.id,
                  designation: '',
                ),
              ),
            );
          },
          child: Text(
            widget.name,
            style: SafeGoogleFont("Inter",
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xff1F0A68)),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customButton(
                  onPressed: () {
                    selectedIndex = 0;
                    _controller.jumpToPage(selectedIndex);
                    setState(() {});
                  },
                  title: "Group Session",
                  isPressed: selectedIndex == 0),
              customButton(
                  onPressed: () {
                    selectedIndex = 1;
                    _controller.jumpToPage(selectedIndex);
                    setState(() {});
                  },
                  title: "Personal Session",
                  isPressed: selectedIndex == 1),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 0.5,
            width: double.infinity,
            color: Colors.black,
          ),
          Expanded(
            // flex: 2,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              controller: _controller,
              children: [
                Counseling_Session_group(
                  name: widget.name,
                  id: widget.id,
                  designation: widget.designation,
                ),
                Counseling_Session_Personnel(
                  id: widget.id,
                  name: widget.name,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePageContainer_2()),
    );
    return true;
  }

  Widget customButton(
      {required String title,
      required bool isPressed,
      required VoidCallback onPressed}) {
    return SizedBox(
      height: 45,
      width: 175,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)
                      // borderRadius: BorderRadius.circular(10),
                      ),
              side: isPressed
                  ? BorderSide.none
                  : const BorderSide(color: Color(0xff1F0A68)),
              foregroundColor:
                  isPressed ? Colors.white : const Color(0xff1F0A68),
              backgroundColor:
                  isPressed ? const Color(0xff1F0A68) : Colors.transparent),
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(fontSize: 12),
          )),
    );
  }
}
