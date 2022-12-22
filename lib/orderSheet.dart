import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/orderCard.dart';

import 'orderOption.dart';

Widget orderSheet(snapshot) {
  final value = Orders(snapshot['orderData'], snapshot['category']);
  // print(datas);
  return Container(
      width: 200,
      margin: EdgeInsets.only(left: 5),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [order(snapshot)],
            ),
          )));
}
