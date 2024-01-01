// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/profile_page/edit_profile_detail_screen.dart';
import 'package:myapp/page-1/sign-up.dart';
import 'package:myapp/page-1/splash_screen_2.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_page/homepagecontainer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "";

  String email = "";

  String dob = "";

  String gender = "";

  String edulevel = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllInfo();
  }

  void getAllInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("name") ?? "N/A";
    email = prefs.getString("email") ?? "N/A";
    dob = prefs.getString("date") ?? "N/A";
    gender = prefs.getString("gender") ?? "N/A";
    edulevel = prefs.getString("edu_level") ?? "N/A";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff1F0A68),
        foregroundColor: Colors.white,
        titleSpacing: 20,
        title: Text(
          "My Profile",
          style: SafeGoogleFont("Inter",
              fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                    "https://media.gettyimages.com/id/1334712074/vector/coming-soon-message.jpg?s=612x612&w=0&k=20&c=0GbpL-k_lXkXC4LidDMCFGN_Wo8a107e5JzTwYteXaw="),
              ),
              itemProfile('Name', username, CupertinoIcons.person, false),
              itemProfile('Email', email, CupertinoIcons.mail, false),
              itemProfile('DOB', dob, CupertinoIcons.calendar, true),
              itemProfile('Gender', gender, CupertinoIcons.person, true),
              itemProfile('Edu-Level', edulevel, CupertinoIcons.book, true),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                 const EditProfileDetailScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(15),
                        backgroundColor: const Color(0xff1F0A68)),
                    child: const Text('Edit Profile')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  itemProfile(
      String title, String subtitle, IconData iconData, bool showEditIcon) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          // boxShadow: [
          //   BoxShadow(
          //       offset: const Offset(0, 5),
          //       color: const Color(0xff1F0A68).withOpacity(.2),
          //       spreadRadius: 2,
          //       blurRadius: 10)
          // ]),
        ),
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(iconData),
          trailing: showEditIcon
              ? IconButton(
                  icon: const Icon(Icons.edit),
                  color: Colors.grey.shade400,
                  onPressed: () {},
                )
              : null,
          tileColor: Colors.white,
        ),
      ),
    );
  }
}
