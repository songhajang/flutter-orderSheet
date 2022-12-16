import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'main.dart';

// ----firebase 데이터 option 시작----
Widget Test(DocumentSnapshot snapshot) {
  final value = Orders(snapshot['orderData'], snapshot['category']);
  // print(datas);
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: ListTile(
      // onPressed: () {
      //   print(value.hashCode);
      // },
      title: Text(snapshot['orderData']),
    ),
  );
}
