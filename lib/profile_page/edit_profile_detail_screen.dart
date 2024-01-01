import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/profile_page/profile_page.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileDetailScreen extends StatefulWidget {
  const EditProfileDetailScreen({super.key});

  @override
  State<EditProfileDetailScreen> createState() =>
      _EditProfileDetailScreenState();
}

class _EditProfileDetailScreenState extends State<EditProfileDetailScreen> {
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController eduLevelController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('MMM/dd/yyyy');
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String savedDOB = prefs.getString('dob') ?? '';
      if (savedDOB.isNotEmpty) {
        _date = DateTime.parse(savedDOB);
        dobController.text = _dateFormatter.format(_date);
      }
    });
  }

  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('dob', _dateFormatter.format(_date));
  }

  handleDatePicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      dobController.text = _dateFormatter.format(date);
      _saveData();
    }
  }

  @override
  void dispose() {
    dobController.dispose();
    super.dispose();
  }

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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            child: Image.asset(
              'assets/page-1/images/back.png',
            ),
          ),
        ),
        titleSpacing: -5,
        title: Text(
          "Edit Detail",
          style: SafeGoogleFont("Inter",
              fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 26, right: 26, top: 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 40),
                decoration: BoxDecoration(
                  color: const Color(0xff1F0A68),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  readOnly: true,
                  controller: dobController,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  onTap: handleDatePicker,
                  decoration: const InputDecoration(
                      labelText: 'Date Of Birth',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.only(left: 40),
                decoration: BoxDecoration(
                  color: const Color(0xff1F0A68),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: genderController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Gender',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.only(left: 40),
                decoration: BoxDecoration(
                  color: const Color(0xff1F0A68),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: eduLevelController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Edu-Level',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(15),
                        backgroundColor: const Color(0xff1F0A68)),
                    child: const Text(
                      'Edit Details',
                      style: TextStyle(fontSize: 16),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
