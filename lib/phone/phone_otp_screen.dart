import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/news/provider/news_provider.dart';
import 'package:myapp/page-1/edulevel.dart';
import 'package:myapp/phone/login.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class PhoneOtpScreen extends StatefulWidget {
  const PhoneOtpScreen({super.key});

  @override
  State<PhoneOtpScreen> createState() => _PhoneOtpScreenState();
}

class _PhoneOtpScreenState extends State<PhoneOtpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late NewsProvider newsProvider;
  bool isLoading = false;

  // @override
  // void initState() {
  //   newsProvider = Provider.of<NewsProvider>(context, listen: false);
  //   super.initState();
  //   newsProvider.startTimer();
  // }

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

  @override
  Widget build(BuildContext context) {
    var code = '';
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/page-1/images/sortmycollege-logo-1-b8D.png',
                height: 260,
                width: 260,
              ),
              const SizedBox(
                height: 34,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value) {
                  code = value;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
              ),
              const SizedBox(
                height: 8,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dont\'n receive an OTP?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    'Resend OTP',
                    style: TextStyle(color: Colors.black38),
                  ),
                ],
              ),
              // TextButton(
              //     onPressed: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => const Login()));
              //     },
              //     child: const Text('Wrong Number',style: ,)),
              Container(
                // wrongnumberBPF (437:95)
                margin: EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    // 'Wrong Number' changed for testing purposes
                    "Wrong Number",
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont(
                      'Roboto',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      color: const Color(0xff000000),
                      decorationColor: const Color(0xff000000),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),

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
                                          const EducationLevel()));
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
                                builder: (context) => const EducationLevel(),
                              ),
                            );
                          }
                          Fluttertoast.showToast(
                              msg: 'Verify Otp Successfully');
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
                          'Submit Otp',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
              // SizedBox(
              //   height: 45,
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     onPressed: () async {
              //       try {
              //         PhoneAuthCredential credential =
              //         PhoneAuthProvider.credential(
              //             verificationId: Login.verify,
              //             smsCode: code);
              //         await auth.signInWithCredential(credential);
              //         if (mounted) {
              //           Navigator.push(context,
              //               MaterialPageRoute(builder: (context) {
              //                 return const EducationLevel();
              //               }));
              //         }
              //       } catch (e) {
              //         if (kDebugMode) {
              //           print('Error $e');
              //         }
              //       }
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: ColorsConst.appBarColor,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //     child: const Text(
              //       'Verify Phone Number',
              //       style: TextStyle(fontSize: 16, color: Colors.white),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
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
