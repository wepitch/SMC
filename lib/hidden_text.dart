import 'package:flutter/material.dart';

class HiddenText extends StatelessWidget {
  final String id;

  const HiddenText({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      child: Text(id),
    );
  }
}
