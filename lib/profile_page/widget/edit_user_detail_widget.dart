// import 'package:flutter/material.dart';
//
// class EditUserDetailWidget extends StatefulWidget {
//   final String fieldTitle;
//   final String currentValue;
//   final Function(String) onFieldUpdated;
//
//   const EditUserDetailWidget({
//     required this.fieldTitle,
//     required this.currentValue,
//     required this.onFieldUpdated,
//   });
//
//   @override
//   _EditUserDetailWidgetState createState() => _EditUserDetailWidgetState();
// }
//
// class _EditUserDetailWidgetState extends State<EditUserDetailWidget> {
//   late TextEditingController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController(text: widget.currentValue);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Edit ${widget.fieldTitle}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _controller,
//               decoration: InputDecoration(labelText: widget.fieldTitle),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 widget.onFieldUpdated(_controller.text);
//                 Navigator.pop(context);
//               },
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUserDetailWidget extends StatefulWidget {
  final String fieldTitle;
  final String currentValue;
  final Function(String) onFieldUpdated;

  const EditUserDetailWidget({
    required this.fieldTitle,
    required this.currentValue,
    required this.onFieldUpdated,
  });

  @override
  _EditUserDetailWidgetState createState() => _EditUserDetailWidgetState();
}

class _EditUserDetailWidgetState extends State<EditUserDetailWidget> {
  late TextEditingController _controller;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentValue);
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit ${widget.fieldTitle}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: widget.fieldTitle),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _prefs.setString(widget.fieldTitle, _controller.text);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
