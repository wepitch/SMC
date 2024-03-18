import 'package:flutter/material.dart';
import 'package:myapp/shared/colors_const.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/page-1/images/comingsoon1.jpg"),
          Padding(
            padding: const EdgeInsets.only(bottom: 74,left: 40,right: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Positioned(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                ColorsConst.appBarColor,
                              ),
                              elevation: MaterialStatePropertyAll(0),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              )
                          ),
                          onPressed: () {
                          },
                          child: Text('Go Home',style: TextStyle(color: ColorsConst.whiteColor,fontSize: 16),),
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
}
