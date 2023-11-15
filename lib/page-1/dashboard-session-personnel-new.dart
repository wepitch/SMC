import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

import 'counsellor_select_listview_offline.dart';
import 'dashboard-session-group-new.dart';
import 'homepagecontainer_2.dart';

class Counseling_Session_Personnel extends StatefulWidget {
  const Counseling_Session_Personnel({super.key});

  @override
  State<Counseling_Session_Personnel> createState() =>
      _Counseling_Session_PersonnelState();
}

class _Counseling_Session_PersonnelState
    extends State<Counseling_Session_Personnel> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // group29C7A (1779:1031)
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0.17 * fem),
              padding: EdgeInsets.fromLTRB(
                  20 * fem, 37.79 * fem, 206 * fem, 15.04 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xff1f0a68),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20 * fem),
                  bottomLeft: Radius.circular(20 * fem),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      // backU4g (1779:1037)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0.08 * fem, 18.99 * fem, 0 * fem),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: SizedBox(
                          width: 11.01 * fem,
                          height: 20 * fem,
                          child: Image.asset(
                            'assets/page-1/images/back-d2Q.png',
                            width: 11.01 * fem,
                            height: 20 * fem,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    // anshikamehra7tL (1779:1035)
                    'Anshika Mehra',
                    style: SafeGoogleFont(
                      'Inter',
                      fontSize: 24 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.2125 * ffem / fem,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              // frame12Fje (1879:51)
              width: double.infinity,
              height: 200 * fem,
              child: Stack(
                children: [
                  Positioned(
                    // frame203HwE (2521:6011)
                    left: 30 * fem,
                    top: 24 * fem,
                    child: SizedBox(
                      width: 390 * fem,
                      height: 45 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Counseling_Session_group()));
                            },
                            child: Container(
                              // group1887fN (2510:1595)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 6 * fem, 0 * fem),
                              width: 192 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: const Color(0xff1f0a68)),
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(5 * fem),
                              ),
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'Group Sessions',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 15 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2125 * ffem / fem,
                                      letterSpacing: 0.59375 * fem,
                                      color: const Color(0xff1f0a68),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // group202xvt (2521:5786)
                            width: 192 * fem,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xffe3398c),
                              borderRadius: BorderRadius.circular(5 * fem),
                            ),
                            child: Center(
                              child: Center(
                                child: Text(
                                  'Personal Sessions',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2125 * ffem / fem,
                                    letterSpacing: 0.59375 * fem,
                                    color: const Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    // line37dXE (2620:3331)
                    left: 0 * fem,
                    top: 90 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 430 * fem,
                        height: 1 * fem,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0x21000000),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // frame311tGg (2620:3569)
                    left: 14 * fem,
                    top: 112 * fem,
                    child: SizedBox(
                      width: 400 * fem,
                      height: 45 * fem,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                // autogroupxl2cQF2 (AQPQSWdqPNQ5gmJbZ1XL2c)
                                width: 190 * fem,
                                height: double.infinity,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      // group307bKW (2620:3570)
                                      left: 10 * fem,
                                      top: 0 * fem,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            10.32 * fem,
                                            15 * fem,
                                            0 * fem,
                                            15 * fem),
                                        width: 166 * fem,
                                        height: 45 * fem,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff1f0a68)),
                                          color: const Color(0xffffffff),
                                        ),
                                        child: SizedBox(
                                          // group310VQt (2620:3574)

                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Center(
                                                // today21octT6p (2620:3575)
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      7 * fem,
                                                      0 * fem),
                                                  child: Text(
                                                    'Today, 21 Oct',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont(
                                                      'Inter',
                                                      fontSize: 12 * ffem,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      height:
                                                      1.2125 * ffem / fem,
                                                      letterSpacing:
                                                      0.59375 * fem,
                                                      color: const Color(
                                                          0xff000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                // noslotskrc (2620:3576)
                                                child: Text(
                                                  'No slots',
                                                  textAlign: TextAlign.center,
                                                  style: SafeGoogleFont(
                                                    'Inter',
                                                    fontSize: 12 * ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.2125 * ffem / fem,
                                                    letterSpacing:
                                                    0.59375 * fem,
                                                    color:
                                                    const Color(0xff8d8888),
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
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    // bookyourslotnzU (1779:1252)
                    left: 54 * fem,
                    top: 178.5 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 250 * fem,
                        height: 20 * fem,
                        child: Text(
                          'Book Your Personnel Slot',
                          style: SafeGoogleFont(
                            'Inter',
                            fontSize: 20 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.2125 * ffem / fem,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      // group193fip (I2510:2510;2510:2244)
                      margin: EdgeInsets.fromLTRB(10 * fem,0 * fem, 10 * fem, 10 * fem),
                      padding: EdgeInsets.fromLTRB(5*fem, 0.5*fem, 5*fem, 16*fem),
                      width: double.infinity,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 350,
                            height: 130,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 5,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 330,
                                  height: 150,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 350,
                                          height: 131,

                                        ),
                                      ),
                                      Positioned(
                                        left: 230,
                                        top: 76,
                                        child: Container(
                                          width: 96,
                                          height: 38,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 96,
                                                  height: 38,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFF1F0A68),
                                                    shape: RoundedRectangleBorder(
                                                      side: BorderSide(width: 1),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Positioned(
                                                left: 24,
                                                top: 7,
                                                child: Text(
                                                  'Book',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        left: 19.01,
                                        top: 63,
                                        child: SizedBox(
                                          width: 174.98,
                                          child: Text(
                                            '2:00 PM - 03:00 PM',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        left: 19.01,
                                        top: 81,
                                        child: SizedBox(
                                          width: 78.89,
                                          child: Text(
                                            'Price - 500 /-',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 18,
                                        top: 98,
                                        child: Container(
                                          width: 97,
                                          height: 17,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 80,
                                                top: 17,
                                                child: Transform(
                                                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-1.57),
                                                  child: Container(
                                                    width: 17,
                                                    height: 17,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage('assets/page-1/images/arrow-down-2.png'),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Positioned(
                                                left: 0,
                                                top: 1,
                                                child: SizedBox(
                                                  width: 75.86,
                                                  child: Text(
                                                    'View Details',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w800,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 19.01,
                                        top: 15,
                                        child: Container(
                                          width: 352.99,
                                          height: 24,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 260.47,
                                                top: 3,
                                                child: Container(
                                                  width: 45.51,
                                                  height: 19,
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 0,
                                                        top: 0,
                                                        child: Container(
                                                          width: 45.51,
                                                          height: 19,
                                                          decoration: ShapeDecoration(
                                                            color: Color(0xFFB1A0EA),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(99),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Positioned(
                                                        left: 12.14,
                                                        top: 2,
                                                        child: SizedBox(
                                                          width: 22.25,
                                                          height: 15,
                                                          child: Text(
                                                            '2/5',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 13,
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w500,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const Positioned(
                                                left: 0,
                                                top: 0,
                                                child: SizedBox(
                                                  width: 198.24,
                                                  child: Text(
                                                    'Personal Session',
                                                    style: TextStyle(
                                                      color: Color(0xFF1F0A68),
                                                      fontSize: 20,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        left: 19.01,
                                        top: 43,
                                        child: SizedBox(
                                          width: 67.77,
                                          height: 16,
                                          child: Text(
                                            '12/08/2023',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )


                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
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
}