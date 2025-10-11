import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  final String text;

  FormLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
    );
  }
}
