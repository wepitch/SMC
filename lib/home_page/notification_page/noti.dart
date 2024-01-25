import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/home_page/notification_page/news/ui/news_information_screen.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notification2 extends StatefulWidget {
  const Notification2({
    super.key,
  });

  @override
  State<Notification2> createState() => _Notification2State();
}

class _Notification2State extends State<Notification2> {
  String title = "";
  String body = "";
  String date = "";

  void getAllInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    title = prefs.getString("title") ?? "N/A";
    body = prefs.getString("body") ?? "N/A";
    date = prefs.getString("date") ?? "N/A";
    setState(() {});
  }

  @override
  void initState() {
    getAllInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff1F0A68),
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NewsInformationScreen()));
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        titleSpacing: 58,
        title: Text(
          "Notification",
          style: SafeGoogleFont("Inter",
              fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: ListTile(
              leading: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: const Center(
                      child: Icon(
                    Icons.message_outlined,
                    color: Colors.black45,
                    size: 20,
                  )),
                ),
              ),
              title: Text(title),
              subtitle: Text(body),
              trailing: Text(
                formatTime(date),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatTime(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedTime = DateFormat('MMM dd, yyyy').format(dateTime);
    return formattedTime;
  }
}
