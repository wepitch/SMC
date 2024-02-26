/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/page-1/sign-up.dart';
import 'package:myapp/phone/phone_otp_screen.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../other/constants.dart';

class Login extends StatefulWidget {
  static String verify = '';

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    countryController.text = '+91';
    configLoading();
  }

  var phone = '';
  bool isLoading = false;
  String code = '';

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 24 * fem),
                    width: 294 * fem,
                    height: 80 * fem,
                    child: Image.asset(
                      'assets/page-1/images/sortmycollege-logo-1-b8D.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
              padding:
                  EdgeInsets.fromLTRB(60 * fem, 37 * fem, 60 * fem, 91 * fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 20 * fem),
                    padding: EdgeInsets.fromLTRB(
                        15 * fem, 15 * fem, 15 * fem, 13 * fem),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: const Color(0xfffffcfc),
                      borderRadius: BorderRadius.circular(10 * fem),
                    ),
                    child: SizedBox(
                      height: 25,
                      child: TextFormField(
                        cursorColor: Colors.black,
                        controller: nameController,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(40),
                        ],
                        decoration: const InputDecoration(
                          hintStyle:
                              TextStyle(color: Colors.black54, fontSize: 15.0),
                          hintText: " Enter Your Name",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom: 12),
                          focusedBorder: InputBorder.none,
                        ),
                        style: SafeGoogleFont(
                          'Roboto',
                          fontSize: 18 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.4010 * ffem / fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 30,
                          child: TextField(
                            cursorColor: Colors.black,
                            controller: countryController,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                  color: Colors.black, fontSize: 15.0),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            style: SafeGoogleFont(
                              'Roboto',
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.4010 * ffem / fem,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        const Text(
                          '|',
                          style: TextStyle(fontSize: 22,color: Colors.black38),
                        ),
                        const SizedBox(
                          width:4,
                        ),
                        Expanded(
                          child: TextField(
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              phone = value;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                  color: Colors.black54, fontSize: 15.0),
                              hintText: "Mobile Number",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            style: SafeGoogleFont(
                              'Roboto',
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.4010 * ffem / fem,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (check_val()) {
                        onTapGettingstarted(
                            context, phoneController.text.toString());
                      }
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                    phoneNumber: countryController.text + phone,
                                    verificationCompleted:
                                        (PhoneAuthCredential credential) {},
                                    verificationFailed:
                                        (FirebaseAuthException e) {},
                                    codeSent: (String verificationId,
                                        int? resendToken) {
                                      Login.verify = verificationId;
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PhoneOtpScreen(),
                                        ),
                                      );
                                    },
                                    codeAutoRetrievalTimeout:
                                        (String verificationId) {},
                                  );
                                } catch (e) {
                                  if (kDebugMode) {
                                    print('Error $e');
                                  }
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsConst.appBarColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: ColorsConst.whiteColor,
                                ),
                              )
                            : Text(
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

  void onTapGettingstarted(BuildContext context, String phone) async {
    await EasyLoading.show(
      status: "Loading...",
      dismissOnTap: false,
    );

    ApiService.callVerifyOtp(phone).then((value) async {
      print(value);

      if (value["message"] == "Email sent successfully") {
        EasyLoading.showToast(value["message"],
            toastPosition: EasyLoadingToastPosition.bottom);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("name", nameController.text.toString());
        if (!mounted) return;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => PhoneOtpScreen(

                    )));
      } else if (value["error"] == "Something went wrong!") {
        EasyLoading.showToast(
          "404 Page Not Found!",
          toastPosition: EasyLoadingToastPosition.bottom,
        );
      } else {
        EasyLoading.showToast(value["error"],
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    });
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

    if (nameController.text.toString().trim().isEmpty) {
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
}*/
