import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/news/provider/news_provider.dart';
import 'package:myapp/page-1/edulevel.dart';
import 'package:myapp/page-1/sign-up.dart';
import 'package:myapp/page-1/sign_up_screen_new.dart';
import 'package:myapp/phone/login.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:pinput/pinput.dart';

class PhoneOtpScreenNew extends StatefulWidget {
  const PhoneOtpScreenNew({super.key});

  @override
  State<PhoneOtpScreenNew> createState() => _PhoneOtpScreenNewState();
}

class _PhoneOtpScreenNewState extends State<PhoneOtpScreenNew> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late NewsProvider newsProvider;
  bool isLoading = false;

  Duration duration = const Duration(minutes: 2);
  Timer? timer;
  bool isResendOtpEnabled = false;

  @override
  void initState() {
    super.initState();
    configLoading();
    startTimer();
  }

  void addTime() {
    const subSeconds = 1;

    setState(() {
      if (duration.inMinutes == 0 && duration.inSeconds == 0) {
        isResendOtpEnabled = true;
        timer!.cancel();
      } else {
        final seconds = duration.inSeconds - subSeconds;
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) => addTime());
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var code = '';
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/page-1/images/www 1 (1).png',
                      height: 280,
                      width: 280,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffF6F7F7),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 60, left: 20, right: 20, bottom: 120),
                  child: Column(
                    children: [
                      Pinput(
                        length: 4,
                        showCursor: true,
                        onChanged: (value) {
                          code = value;
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive an OTP? ",
                            style: SafeGoogleFont(
                              'Roboto',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.4826653059,
                              color: const Color(0xff000000),
                            ),
                          ),
                          Text(
                            'Resend OTP',
                            style: SafeGoogleFont(
                              'Roboto',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.4826653059,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    PhoneAuthCredential credential =
                                        PhoneAuthProvider.credential(
                                            verificationId: Login.verify,
                                            smsCode: code);
                                    await auth.signInWithCredential(credential);
                                    if (mounted) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignupScreenNew()));
                                    }
                                  } catch (e) {
                                    if (kDebugMode) {
                                      print('Error $e');
                                    }
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                  if (mounted) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignupScreenNew()));
                                  }
                                  // Fluttertoast.showToast(
                                  //     msg: 'Verify Otp Successfully');
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
                                    color: ColorsConst.appBarColor,
                                  ),
                                )
                              : const Text(
                                  'Submit OTP',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
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
      backgroundColor: Colors.white,
    );
  }
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
