import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Options {
  String option;
  Options(this.option);
}

orderOption(DocumentSnapshot snapshot, orderClear) {
  return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        snapshot['option'],
        style: orderClear
            ? const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.lineThrough,
                decorationThickness: 4,
                color: Color(0xffBABBBB),
              )
            : const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black),
      ));
}
