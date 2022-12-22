import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Options {
  String option;
  Options(this.option);
}

orderOption(DocumentSnapshot snapshot) {
  return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        snapshot['option'],
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
      ));
}
