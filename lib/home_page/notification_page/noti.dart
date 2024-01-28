// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:myapp/home_page/notification_page/news/ui/news_information_screen.dart';
// import 'package:myapp/shared/colors_const.dart';
// import 'package:myapp/utils.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Notification2 extends StatefulWidget {
//   const Notification2({
//     super.key,
//   });
//
//   @override
//   State<Notification2> createState() => _Notification2State();
// }
//
// class _Notification2State extends State<Notification2> {
//   String title = "";
//   String body = "";
//   String date = "";
//
//   void getAllInfo() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     title = prefs.getString("title") ?? "N/A";
//     body = prefs.getString("body") ?? "N/A";
//     date = prefs.getString("date") ?? "N/A";
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//     getAllInfo();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: const Color(0xff1F0A68),
//         foregroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const NewsInformationScreen()));
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_new,
//             color: Colors.white,
//           ),
//         ),
//         titleSpacing: 58,
//         title: Text(
//           "Notification",
//           style: SafeGoogleFont("Inter",
//               fontSize: 18, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: Column(
//         children: [
//           GestureDetector(
//             onTap: () {},
//             child: ListTile(
//               leading: Container(
//                 height: 40,
//                 width: 40,
//                 decoration: const BoxDecoration(
//                   color: Colors.black26,
//                   shape: BoxShape.circle,
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(60),
//                   child: const Center(
//                     child: Icon(
//                       Icons.notifications,
//                       color: ColorsConst.whiteColor,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//               ),
//               title: Text(title,maxLines: 1,),
//               subtitle: Text(body),
//               trailing: Text(
//                 formatTime(date),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String formatTime(String timestamp) {
//     try {
//       DateTime dateTime = DateTime.parse(timestamp);
//       String formattedTime = DateFormat('MMM dd, yyyy').format(dateTime);
//       return formattedTime;
//     } catch (e) {
//       print("Error formatting time: $e");
//       return "Invalid Date";
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/home_page/notification_page/news/ui/news_information_screen.dart';
import 'package:myapp/shared/colors_const.dart';
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
  List<Map<String, String>> notifications = [];

  @override
  void initState() {
    getAllInfo();
    super.initState();
  }

  void getAllInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String title = prefs.getString("title") ?? "N/A";
    String body = prefs.getString("body") ?? "N/A";
    String date = prefs.getString("date") ?? "N/A";

    DateTime notificationDate = DateTime.parse(date);
    if (DateTime.now().difference(notificationDate).inDays <= 4) {
      notifications.insert(0, {
        'title': title,
        'body': body,
        'date': date,
      });

      setState(() {});
    }
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
                builder: (context) => const NewsInformationScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        titleSpacing: 58,
        title: Text(
          "Notification",
          style: SafeGoogleFont(
            "Inter",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return buildNotificationTile(notifications[index]);
        },
      ),
    );
  }

  Widget buildNotificationTile(Map<String, String> notification) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(formatTime(notification['date'] ?? '')),
          const SizedBox(
            height: 6,
          ),
          ListTile(
            leading: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: const Center(
                  child: Icon(
                    Icons.notifications,
                    color: ColorsConst.whiteColor,
                    size: 20,
                  ),
                ),
              ),
            ),
            title: Text(
              notification['title'] ?? '',
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              notification['body'] ?? '',
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  String formatTime(String timestamp) {
    try {
      DateTime dateTime = DateTime.parse(timestamp);
      String formattedTime = DateFormat('MMM dd, yyyy').format(dateTime);
      return formattedTime;
    } catch (e) {
      print("Error formatting time: $e");
      return "Invalid Date";
    }
  }
}
