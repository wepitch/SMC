import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDetail {
  String username = '';
  String email = '';

  static AlertDialog buildAddDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit User Detail'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            DropDownButtonWidget(),
            const SizedBox(
              height: 20,
            ),
            EditDobWidget(),
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
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            DropDownButtonWidget dropdownWidget = DropDownButtonWidget();
            EditDobWidget dobWidget = EditDobWidget();

            prefs.setString('education', dropdownWidget.currentEducation);
            prefs.setString('gender', dropdownWidget.currentGender);
            prefs.setString('dob', dobWidget._dateController.toString());

          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class DropDownButtonWidget extends StatefulWidget {
  DropDownButtonWidget({super.key});

  String currentGender = 'Male';
  String currentEducation = 'Bachelor';

  @override
  State<DropDownButtonWidget> createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  String currentGender = 'Male';
  String currentEducation = 'Bachelor';

  List<String> genderList = ['Male', 'Female', 'Other'];
  List<String> educationList = ['Bachelor', 'Master', 'PhD', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          readOnly: true,
          controller: TextEditingController(text: currentEducation),
          decoration: const InputDecoration(
            labelText: 'Education',
            border: OutlineInputBorder(),
          ),
          onTap: () {
            _showEducationDropdown();
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
          onTap: () {
            _showGenderDropdown();
          },
        ),
      ],
    );
  }

  Future<void> _showEducationDropdown() async {
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Education'),
          content: DropdownButton<String>(
            value: currentEducation,
            onChanged: (String? item) {
              Navigator.pop(context, item);
            },
            items: educationList.map(
              (e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              },
            ).toList(),
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        currentEducation = result;
      });
    }
  }

  Future<void> _showGenderDropdown() async {
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Gender'),
          content: DropdownButton<String>(
            value: currentGender,
            onChanged: (String? item) {
              Navigator.pop(context, item);
            },
            items: genderList.map(
              (e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              },
            ).toList(),
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        currentGender = result;
      });
    }
  }
}

class EditDobWidget extends StatefulWidget {
  EditDobWidget({super.key});

  TextEditingController _dateController = TextEditingController();

  @override
  State<EditDobWidget> createState() => _EditDobWidgetState();
}

class _EditDobWidgetState extends State<EditDobWidget> {
  DateTime _date = DateTime.now();

  TextEditingController _dateController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat('MMM/dd/yyyy');

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  _handleDatePicker() async {
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
      _dateController.text = _dateFormatter.format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: _dateController,
      style: const TextStyle(
        fontSize: 18,
      ),
      onTap: _handleDatePicker,
      decoration: InputDecoration(
        labelText: 'Date',
        labelStyle: const TextStyle(
          fontSize: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
