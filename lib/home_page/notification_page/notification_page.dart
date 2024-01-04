import 'package:flutter/material.dart';

import '../../utils.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1F0A68),
        foregroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0, top: 18, bottom: 18),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/page-1/images/back.png',
            ),
          ),
        ),
        titleSpacing: -5,
        title: Text(
          "Notifications",
          style: SafeGoogleFont("Inter",
              fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView.builder(
          itemCount: dummyList.length,
          itemBuilder: (context, index) {
            var notificationData = dummyList[index];
            return ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                  notificationData.img,
                ),
              ),
              title: Text(
                notificationData.name,
                style: SafeGoogleFont(
                  "Inter",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                notificationData.message,
                style: SafeGoogleFont(
                  "Inter",
                  color: const Color(0xff626161),
                  height: 1.5,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              shape: Border(
                  bottom: BorderSide(
                color: Colors.black.withOpacity(0.09),
              )),
            );
          }),
    );
  }
}

class DummyNotificationModel {
  final String img;
  final String message;
  final String name;
  DummyNotificationModel({
    required this.img,
    required this.name,
    required this.message,
  });
}

List<DummyNotificationModel> dummyList = [
  DummyNotificationModel(
      img: "assets/page-1/images/profile_booking.png",
      name: "Sandeep Mehra",
      message: "posted 3 more pictures"),
  DummyNotificationModel(
      img: "assets/page-1/images/profile_booking.png",
      name: "Dinesh Joshi",
      message: "posted 1 more pictures"),
  DummyNotificationModel(
      img: "assets/page-1/images/mask-group-Z9B.png",
      name: "Kashish Sharma",
      message: "Added new session on CUET at 4:00 PM"),
];
