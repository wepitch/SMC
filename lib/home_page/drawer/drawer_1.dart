// ignore_for_file: unnecessary_null_comparison
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myapp/home_page/drawer/image_saved_screen.dart';
import 'package:myapp/home_page/help_screen.dart';
import 'package:myapp/page-1/shared.dart';
import 'package:myapp/page-1/splash_screen_2.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Drawer1 extends StatefulWidget {
  const Drawer1({super.key});

  @override
  State<Drawer1> createState() => _Drawer1State();
}

class _Drawer1State extends State<Drawer1> {
  String path = '';
  String name = "";

  @override
  void initState() {
    getAllInfo();
    setName();
    super.initState();
  }

  void getAllInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    path = prefs.getString("profile_image_path") ?? "N/A";
    setState(() {});
  }

  void setName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name") ?? "N/A";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 262,
      backgroundColor: Colors.white,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 164,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xff1F0A68),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 28,
                  ),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: path != null
                                ? Image.file(File(path), fit: BoxFit.cover)
                                : const Icon(
                                    Icons.person,
                                    size: 100,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38, right: 26),
                    child: Text(
                      name,
                      style: SafeGoogleFont(
                        "Inter",
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: const Icon(Icons.home,size: 20,),
                      title: Text(
                        "Home",
                        style: SafeGoogleFont(
                          "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      shape: Border(
                          bottom: BorderSide(
                        color: Colors.black.withOpacity(0.09),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HelpScreen()));
                    },
                    child: ListTile(
                      leading: Icon(Icons.question_mark,size: 18,),
                      title: Text(
                        "Help?",
                        style: SafeGoogleFont(
                          "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      shape: Border(
                          bottom: BorderSide(
                        color: Colors.black.withOpacity(0.09),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.psychology,size: 21,),
                    title: Text(
                      "Psychometric Test",
                      style: SafeGoogleFont(
                        "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    shape: Border(
                        bottom: BorderSide(
                      color: Colors.black.withOpacity(0.09),
                    )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FeedScreen(
                                    name: '',
                                    id: '',
                                  )));
                    },
                    leading: const Icon(
                      Icons.save_alt,
                      size: 18,
                    ),
                    title: Text(
                      "Saved",
                      style: SafeGoogleFont(
                        "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    shape: Border(
                        bottom: BorderSide(
                      color: Colors.black.withOpacity(0.09),
                    )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Alert!'),
                        content: const Text('Are you sure to logout!'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          TextButton(
                            onPressed: () async {
                              await _logout();
                              if (mounted) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SplashScreen2()));
                              }
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    size: 18,
                  ),
                  title: Text(
                    'Logout',
                    style: SafeGoogleFont(
                      "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  shape: Border(
                    bottom: BorderSide(
                      color: Colors.black.withOpacity(0.09),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Image.asset(
              "assets/page-1/images/sortmycollege-logo-1.png",
              height: 61,
              width: 229,
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  Future _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen2()),
        (route) => false,
      );
      SharedPre.saveAuthLogin(false);
    }
  }
}
