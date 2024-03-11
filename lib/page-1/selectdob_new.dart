import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:myapp/page-1/select_gender_new.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectDobNew extends StatefulWidget {
  const SelectDobNew({super.key});

  @override
  State<SelectDobNew> createState() => _SelectDobNewState();
}

class _SelectDobNewState extends State<SelectDobNew> {
  String date = "Select DOB";

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   openDatePicker();
    // });
  }

  //
  //  openDatePicker() async {
  //   var now = DateTime.now();
  //   var firstDate = DateTime(1999);
  //   showDatePicker(
  //
  //     context: context,
  //     initialDate: now,
  //     firstDate: firstDate,
  //     lastDate: now,
  //   ).then((value) {
  //     if (value != null) {
  //       date = DateFormat("d/M/yyyy").format(value).toString();
  //       setState(() {});
  //     }
  //   });
  // }
  openDatePicker() async {
    var now = DateTime.now();
    var firstDate = DateTime(1999);
    showDatePicker(
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 460,
              width: 340,
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    onSurface: Colors.black,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black, // button text color
                    ),
                  ),
                ),
                child: child!,
              ),
            ),
          ],
        );
      },
      context: context,
      firstDate: firstDate,
      lastDate: now,
    ).then((value) {
      if (value != null) {
        date = DateFormat("d/M/yyyy").format(value).toString();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 40, right: 40, top: 100, bottom: 40),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Question 1/3'),
              Image.asset('assets/page-1/images/dob.jpg'),
              const Spacer(),
              Center(
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff1F0A68), width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 36, left: 40, right: 40, bottom: 140),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(
                              "What's your date of birth?",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Text(
                            'DD/MM/YYYY',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          customButton(
                            onPressed: () {
                              var now = DateTime.now();
                              var firstDate = DateTime(1999);
                              // var lastDate = DateTime(2010);
                              showDatePicker(
                                builder: (context, child) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 460,
                                        width: 340,
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: const ColorScheme.light(
                                              primary: Colors.white,
                                              onPrimary: Colors.black,
                                              onSurface: Colors.black,
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors
                                                    .black, // button text color
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                context: context,
                                firstDate: firstDate,
                                lastDate: now,
                              ).then((value) {
                                if (value != null) {
                                  date = DateFormat("d/M/yyyy")
                                      .format(value)
                                      .toString();
                                  setState(() {});
                                }
                              });
                            },
                            title: date,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (date == "DD/MM/YYYY") {
                          EasyLoading.showToast("Please Select the date...",
                              toastPosition: EasyLoadingToastPosition.bottom);
                        } else {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString("date", date);

                          if (!mounted) return;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SelectGenderNew()));
                        }
                      },
                      // child: Image.asset('assets/page-1/images/arrow1.jpg',height: 46,width: 46,)),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                                child: Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 40,
                              color: Color(0xff1F0A68),
                            ))
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
      ),
    );
  }

  Widget customButton({
    required VoidCallback onPressed,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: SizedBox(
        height: 50,
        width: 200,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
              side: BorderSide(color: Color(0xff1F0A68)),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          child: Text(
            title,
            style: SafeGoogleFont(
              "Montserrat",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget nextButton({required VoidCallback onPressed, required String title}) {
    return SizedBox(
      height: 45,
      width: 326,
      child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: const Color(0xff1F0A68),
              foregroundColor: Colors.white),
          child: Text(
            title,
            style: SafeGoogleFont(
              "Roboto",
              fontSize: 20,
            ),
          )),
    );
  }
}
