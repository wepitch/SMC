import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/page-1/sign-up.dart';
import 'package:myapp/page-1/sign_up_screen_new.dart';
import 'package:myapp/phone/phone_otp_screen.dart';
import 'package:myapp/phone/phone_otp_screen_new.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../other/constants.dart';

class LoginScreenNew extends StatefulWidget {
  static String verify = '';

  const LoginScreenNew({Key? key}) : super(key: key);

  @override
  _LoginScreenNewState createState() => _LoginScreenNewState();
}

class _LoginScreenNewState extends State<LoginScreenNew> {
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    configLoading();
  }

  var phone = '';
  bool isLoading = false;
  String code = '';

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    var mHeight = MediaQuery.sizeOf(context).height;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/page-1/images/Group 627.png',
            fit: BoxFit.cover,
            height: 260,
          ),
          const SizedBox(height: 10,),
          const Text(
            'Let’s get you started!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: mHeight * 0.04,
          ),
          const Text(
            ' Your phone number will be your\npassword, we will send you a code\n on your mobile device which will',
            style: TextStyle(fontSize: 14),
          ),
          const Text(
            'allow you to login!',
            style: TextStyle(fontSize: 14),
          ),
          Container(
            padding:
                EdgeInsets.fromLTRB(60 * fem, 37 * fem, 60 * fem, 91 * fem),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                            hintText: "Phone Number",
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
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    const Text(
                      'I accept terms and conditions',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    // if (check_val()) {
                    //   onTapGettingstarted(
                    //       context, phoneController.text.toString());
                    // }

                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        // setState(() {
                        //   isLoading = true;
                        // });
                        // try {
                        //   await FirebaseAuth.instance.verifyPhoneNumber(
                        //     phoneNumber: countryController.text + phone,
                        //     verificationCompleted:
                        //         (PhoneAuthCredential credential) {},
                        //     verificationFailed: (FirebaseAuthException e) {},
                        //     codeSent:
                        //         (String verificationId, int? resendToken) {
                        //       LoginScreenNew.verify = verificationId;
                        //       setState(() {
                        //         isLoading = false;
                        //       });
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => PhoneOtpScreen(),
                        //         ),
                        //       );
                        //     },
                        //     codeAutoRetrievalTimeout:
                        //         (String verificationId) {},
                        //   );
                        // } catch (e) {
                        //   if (kDebugMode) {
                        //     print('Error $e');
                        //   }
                        // }
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => const PhoneOtpScreenNew()));
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
                const Divider(color: Colors.black, endIndent: 60, indent: 60),
                SizedBox(
                  height: mHeight * 0.01,
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
                                builder: (context) => const SignupScreenNew()));
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
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PhoneOtpScreenNew()));
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
}
