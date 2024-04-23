import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/shared/colors_const.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  String title = "Dear MBBS Prof 1st Year 2024 Students,Today's \n live class of Vivek sir has been scheduled at \n 10:00 AM. Don't forget to watch. Stay tuned!!! ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: AppBar(
        surfaceTintColor: ColorsConst.whiteColor,
        backgroundColor: ColorsConst.whiteColor,
        titleSpacing: -10,
        title: const Text('Announcements',style: TextStyle(color: ColorsConst.appBarColor),),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,color: ColorsConst.appBarColor,),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(12,0,0,0),
            child: Text('23rd March 2024',style:
            TextStyle(fontSize: 13,
                fontWeight: FontWeight.w500,
                color: ColorsConst.appBarColor),),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Card(
                      elevation: 1,
                      color: ColorsConst.whiteColor,
                      surfaceTintColor: ColorsConst.whiteColor,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('\u2022$title'),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),

          const Center(child: Text('View All',style:
          TextStyle(fontSize: 14,color: ColorsConst.appBarColor),)),

        ],
      ),
    );
  }
}
