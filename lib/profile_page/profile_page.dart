import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/profile_page/widget/profile_edit_dialog.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? path;
  String username = "";
  String email = "";
  String dob = "";
  String gender = "";
  String eduLevel = "";

  @override
  void initState() {
    super.initState();
    getAllInfo();
  }

  void getAllInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("name") ?? "N/A";
    email = prefs.getString("email") ?? "N/A";
    dob = prefs.getString("date") ?? "N/A";
    gender = prefs.getString("gender") ?? "N/A";
    eduLevel = prefs.getString("edu_level") ?? "N/A";
    path = prefs.getString("profile_image_path");
    setState(() {});
  }

  void saveImagePathToPrefs(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("profile_image_path", path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        foregroundColor: Colors.white,
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 0, top: 18, bottom: 18),
        //   child: GestureDetector(
        //     onTap: () {
        //       Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => const HomePageContainer()));
        //     },
        //     child: Image.asset(
        //       'assets/page-1/images/back.png',
        //     ),
        //   ),
        // ),
        titleSpacing: 28,
        title: Text(
          "My Profile",
          style: SafeGoogleFont("Inter",
              fontSize: 18, fontWeight: FontWeight.w600,color: ColorsConst.appBarColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: path != null
                            ? Image.file(File(path!), fit: BoxFit.cover)
                            : const Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.grey,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          ImagePicker imagePicker = ImagePicker();
                          XFile? xFile = await imagePicker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (xFile != null) {
                            path = xFile.path;
                            saveImagePathToPrefs(path!);
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff1F0A68),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              itemProfile('Name', username, CupertinoIcons.person),
              itemProfile('Gmail', email, CupertinoIcons.mail),
              itemProfile('Date Of Birth', dob, CupertinoIcons.calendar),
              itemProfile('Gender', gender, CupertinoIcons.person),
              itemProfile('Education', eduLevel, CupertinoIcons.book),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 36,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return const ProfileEditDialog();
                          });
                      getAllInfo();
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(2),
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
    String title,
    String subtitle,
    IconData iconData,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(iconData),
        ),
      ),
    );
  }
}
