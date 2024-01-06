import 'package:flutter/material.dart';
import 'package:myapp/profile_page/widget/drop_down_dialog.dart';
import 'package:myapp/profile_page/widget/edit_dob_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditDialog extends StatefulWidget {
  const ProfileEditDialog({super.key});

  @override
  State<ProfileEditDialog> createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  String? currentEducation;
  String? currentGender;
  String? currentDob;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit User Detail'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              readOnly: true,
              controller: TextEditingController(text: currentEducation),
              decoration: const InputDecoration(
                labelText: 'Education',
                border: OutlineInputBorder(),
              ),
              onTap: () {
                showEducationDropdown(context);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: currentGender),
              decoration: const InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                showGenderDropdown(context);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            EditDobWidget(callback: (String dob) {
              setState(() {
                currentDob = dob;
              });
            }),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: allValuesSelected() ? saveDetails : null,
          child: const Text('Save'),
        ),
      ],
    );
  }

  Future<void> saveDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (allValuesSelected()) {
      prefs.setString('edu_level', currentEducation!);
      prefs.setString('gender', currentGender!);
      prefs.setString('date', currentDob!);
      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      //show toast here: Select all items
    }
  }

  bool allValuesSelected() {
    return currentEducation != null &&
        currentGender != null &&
        currentDob != null;
  }

  void showEducationDropdown(BuildContext context) async {
    List<String> educationList = ['Bachelor', 'Master', 'PhD', 'Other'];

    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return DropDownDialog(
          callback: (value) {
            setState(() {
              currentEducation = value;
            });
          },
          itemList: educationList,
          label: 'Select Education',
        );
      },
    );
  }

  void showGenderDropdown(BuildContext context) async {
    List<String> genderList = ['Male', 'Female', 'Other'];
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return DropDownDialog(
          callback: (value) {
            setState(() {
              currentGender = value;
            });
          },
          itemList: genderList,
          label: 'Select Gender',
        );
      },
    );
  }
}
