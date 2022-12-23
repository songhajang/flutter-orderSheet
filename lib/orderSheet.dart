import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/orderCard.dart';

Widget orderSheet(snapshot) {
  final value =
      Orders(snapshot['orderData'], snapshot['category'], snapshot['orderNum']);
  // print(datas);
  return Container(
      width: 250,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [order(snapshot)],
            ),
          )));
}
