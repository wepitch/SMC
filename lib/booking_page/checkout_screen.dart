import 'package:flutter/material.dart';
import 'package:myapp/shared/colors_const.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: AppBar(
        titleSpacing: -10,
        backgroundColor: ColorsConst.whiteColor,
        surfaceTintColor: ColorsConst.whiteColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorsConst.appBarColor,
          ),
        ),
        title: const Text(
          'CheckOut',
          style: TextStyle(color: ColorsConst.appBarColor),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 8, right: 8, top: 30, bottom: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 4,
                shadowColor: ColorsConst.whiteColor,
                color: ColorsConst.whiteColor,
                surfaceTintColor: ColorsConst.whiteColor,
                child: Container(
                  padding: const EdgeInsets.only(top: 10, left: 18, right: 10),
                  height: 180,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(36),
                                child: Image.network(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQg1dIOAjqRZTG33LCikcTs75d2G2OJH9vnTA&usqp=CAU',
                                  height: 78,
                                  width: 76,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sandeep Mehra',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                'Designer at SMC',
                                style:
                                    TextStyle(color: ColorsConst.black54Color),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 24,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Booking Date',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Personal Session',
                                style: TextStyle(
                                  color: ColorsConst.appBarColor,
                                ),
                              ),
                              const SizedBox(height: 4,),
                              Container(
                                height: 24,
                                width: 140,
                                decoration: BoxDecoration(
                                    color: ColorsConst.whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all()),
                                child: const Center(
                                    child: Text(
                                      'View Details',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Card(
                elevation: 4,
                shadowColor: ColorsConst.whiteColor,
                color: ColorsConst.whiteColor,
                surfaceTintColor: ColorsConst.whiteColor,
                child: Container(
                  padding: const EdgeInsets.only(top: 12, left: 10, right: 10,bottom: 12),
                  height: 166,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Total Cost',
                            style: TextStyle(color: ColorsConst.black54Color,fontSize: 12),
                          ),
                          Spacer(),
                          Text(
                            '\u{20B9} 500',
                            style: TextStyle(color: ColorsConst.black54Color,fontSize: 13),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'GST',
                            style: TextStyle(color: ColorsConst.black54Color,fontSize: 12),
                          ),
                          Spacer(),
                          Text(
                            '0 %',
                            style: TextStyle(color: ColorsConst.black54Color,fontSize: 13),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Convenience charge',
                            style: TextStyle(color: ColorsConst.black54Color,fontSize: 12),
                          ),
                          Spacer(),
                          Text(
                            '\u{20B9} 0',
                            style: TextStyle(color: ColorsConst.black54Color,fontSize: 13),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Grade Total',
                            style: TextStyle(color: ColorsConst.black54Color,fontSize: 12),
                          ),
                          Spacer(),
                          Text(
                            '\u{20B9} ${1000}',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold,),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(
                                ColorsConst.appBarColor),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'CheckOut',
                            style: TextStyle(color: ColorsConst.whiteColor),
                          )),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(
                                ColorsConst.appBarColor),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: ColorsConst.whiteColor),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
