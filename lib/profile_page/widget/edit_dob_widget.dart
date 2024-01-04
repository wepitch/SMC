import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditDobWidget extends StatefulWidget {
  const EditDobWidget({super.key});

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
