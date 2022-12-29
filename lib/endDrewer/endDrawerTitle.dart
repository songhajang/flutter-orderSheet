import 'package:flutter/material.dart';

class endDrawerTitle extends StatelessWidget {
  endDrawerTitle({super.key, this.title});
  final title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
