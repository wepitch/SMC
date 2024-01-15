import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myapp/page-1/sign-up.dart';
import 'package:myapp/utils.dart';
import '../other/constants.dart';

import 'otp.dart';

class Login extends StatefulWidget {
  static String? verify;

  const Login({super.key});

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  // final _nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailcontroller = TextEditingController();
  var phone = '';

  // final String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    phoneController.text = '';
    configLoading();
  }
   String verify = '';

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Material(
      type: MaterialType.transparency,
      child: Container(
        // logindSh (437:98)
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogroupbax3xUy (AXyDhFDYztWoAJJL4EbaX3)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0),
              padding:
                  EdgeInsets.fromLTRB(60 * fem, 142 * fem, 76 * fem, 85 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50 * fem),
                  topRight: Radius.circular(50 * fem),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // sortmycollegelogo1qHs (1061:7)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 24 * fem),
                    width: 294 * fem,
                    height: 80 * fem,
                    child: Image.asset(
                      'assets/page-1/images/sortmycollege-logo-1-b8D.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Container(
                  //   // sortyourentirecollegejourneykf (1061:9)
                  //   margin: EdgeInsets.fromLTRB(
                  //       22 * fem, 0 * fem, 0 * fem, 0 * fem),
                  //   child: Text(
                  //     'Sort Your Entire College Journey!',
                  //     textAlign: TextAlign.center,
                  //     style: SafeGoogleFont(
                  //       'Roboto',
                  //       fontSize: 16 * ffem,
                  //       fontWeight: FontWeight.w700,
                  //       height: 1.1725 * ffem / fem,
                  //       color: const Color(0xff1f0a68),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              // welcomeback4RX (437:112)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 1 * fem, 12 * fem),
              child: Text(
                'Welcome Back!',
                textAlign: TextAlign.center,
                style: SafeGoogleFont(
                  'Roboto',
                  fontSize: 22 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 1.1725 * ffem / fem,
                  decoration: TextDecoration.underline,
                  color: const Color(0xff000000),
                  decorationColor: const Color(0xff000000),
                ),
              ),
            ),
            Text(
              // pleaselogintoyourexistingaccou (437:111)
              'Please Log into your existing account',
              textAlign: TextAlign.center,
              style: SafeGoogleFont(
                'Roboto',
                fontSize: 15 * ffem,
                fontWeight: FontWeight.w400,
                height: 1.1725 * ffem / fem,
                color: const Color(0xff000000),
              ),
            ),
            Container(
              // autogroupy8wsuS9 (AXyE5uEUBhrUYbR5AEY8ws)
              padding:
                  EdgeInsets.fromLTRB(60 * fem, 37 * fem, 60 * fem, 91 * fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // autogroups3swDQd (AXy84jvvc4rqKvoPDJs3sw)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 20 * fem),
                    padding: EdgeInsets.fromLTRB(
                        15 * fem, 15 * fem, 15 * fem, 13 * fem),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff000000)),
                      color: const Color(0xfffffcfc),
                      borderRadius: BorderRadius.circular(5 * fem),
                    ),
                    child: SizedBox(
                      height: 16,
                      child: TextFormField(
                        cursorColor: Colors.black,
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(40),
                        ],
                        decoration: const InputDecoration(
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 15.0),
                          hintText: "Enter Your Full name",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom: 12),
                          focusedBorder: InputBorder.none,
                        ),
                        style: SafeGoogleFont(
                          'Roboto',
                          fontSize: 18 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.1810 * ffem / fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // autogrouprbz9U5f (AXy8AQS9uGhFg15ZzJrBz9)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 20 * fem),
                    padding: EdgeInsets.fromLTRB(
                        15 * fem, 15 * fem, 15 * fem, 13 * fem),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff000000)),
                      color: const Color(0xfffffcfc),
                      borderRadius: BorderRadius.circular(10 * fem),
                    ),
                    child: SizedBox(
                      height: 16,
                      child: TextFormField(
                        onChanged: (value) {
                          phone = value;
                        },
                        cursorColor: Colors.black,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 12),
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 15.0),
                          hintText: "Enter your Phone Number",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: SafeGoogleFont(
                          'Roboto',
                          fontSize: 18 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.1525 * ffem / fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    // autogroupb1cmwGM (AXyDxzGKdcnpJKxVY5B1cM)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 39 * fem),
                    width: double.infinity,
                    height: 45 * fem,
                    decoration: BoxDecoration(
                      color: const Color(0xff1f0a68),
                      borderRadius: BorderRadius.circular(10 * fem),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () async{
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: phoneController.text + phone,
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent: (String verificationId, int? resendToken) {
                              Login.verify = verificationId;
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const OtpScreen(),
                              //   ),
                              // );
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {},
                          );
                          // if (check_val()) {
                          //   ApiService()
                          //       .call_otp_2(
                          //           email:
                          //               emailcontroller.text.toString().trim())
                          //       .then((value) async {
                          //     if (value["message"] ==
                          //         "Email sent successfully") {
                          //       onTapGettingstarted(context);
                          //     } else {
                          //       EasyLoading.showToast("error",
                          //           toastPosition:
                          //               EasyLoadingToastPosition.bottom);
                          //     }
                          //   });
                          // }
                        },
                        child: Text(
                          'Log in',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont(
                            'Roboto',
                            fontSize: 20 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.1725 * ffem / fem,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   // rectangle64brh (437:119)
                  //   margin: EdgeInsets.fromLTRB(80 * fem, 0 * fem, 80 * fem, 0),
                  //   width: double.infinity,
                  //   height: 1 * fem,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10 * fem),
                  //     color: const Color(0xff000000),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 11,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SizedBox(
                  //       height: 45,
                  //       width: 45,
                  //       child: ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //               shape: const CircleBorder(),
                  //               backgroundColor: Colors.white),
                  //           onPressed: () async {},
                  //           child: Image.asset(
                  //             "assets/page-1/images/google.png",
                  //             // fit: BoxFit.cover,
                  //             height: 50,
                  //             width: 50,
                  //           )),
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     SizedBox(
                  //       height: 45,
                  //       width: 45,
                  //       child: ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //               shape: const CircleBorder(),
                  //               backgroundColor: Colors.white),
                  //           onPressed: () {},
                  //           child: Image.asset(
                  //             "assets/page-1/images/facebook.png",
                  //             // fit: BoxFit.fill,
                  //             height: 30,
                  //             width: 30,
                  //           )),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account? ',
                        style: SafeGoogleFont(
                          'Roboto',
                          fontSize: 15 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.4826653059 * ffem / fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup()));
                        },
                        child: Text(
                          'Sign up',
                          style: SafeGoogleFont(
                            'Roboto',
                            fontSize: 17 * ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.4826653059 * ffem / fem,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapGettingstarted(BuildContext context) {
    //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()),(route) => false);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Otp(emailcontroller.text.toString())),
        (route) => false);
  }

  bool validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (!regExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

  bool check_val() {
    bool isvaluevalid = true;

    /* if(_nameController.text.toString().trim().isEmpty){
      EasyLoading.showToast(AppConstants.fullnameerror,
          toastPosition: EasyLoadingToastPosition.bottom);
      isvaluevalid = false;
    }*/

    if (emailcontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.USER_EMAIL,
          toastPosition: EasyLoadingToastPosition.bottom);
      isvaluevalid = false;
    } else if (phoneController.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.phoneerror,
          toastPosition: EasyLoadingToastPosition.bottom);
      isvaluevalid = false;
    } else if (validateMobile(phoneController.text.toString().trim())) {
      EasyLoading.showToast(AppConstants.phonenotvalid,
          toastPosition: EasyLoadingToastPosition.bottom);
      isvaluevalid = false;
    }

    return isvaluevalid;
  }

  void configLoading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..displayDuration = const Duration(milliseconds: 1000)
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..maskType = EasyLoadingMaskType.none
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  bool isEmail(String em) {
    bool isvaluevalid = false;
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(em)) {
      isvaluevalid = true;
    } else {
      EasyLoading.showToast(AppConstants.valid_email,
          toastPosition: EasyLoadingToastPosition.bottom);
      isvaluevalid = false;
    }
    return isvaluevalid;
  }

// @override
// State<StatefulWidget> createState() {
//   // TODO: implement createState
//   throw UnimplementedError();
// }
}
