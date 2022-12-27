// ignore: unused_import
import 'dart:async';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/orderCard.dart';
import 'package:get/get.dart';
import 'package:timer_builder/timer_builder.dart';

// ignore: unused_import
import 'orderOption.dart';

Widget orderSheet(DocumentSnapshot snapshot) {
  final _getData = Get.put(reactiveStateManagePage());
  // ignore: unused_local_variable
  final value = Orders(snapshot['orderData'], snapshot['category'],
      snapshot['orderNum'], snapshot['orderClear'], snapshot['orderTime']);
  // ignore: invalid_use_of_protected_member
  if (!(_getData.orderIdCheck.value.indexOf(snapshot['orderNum']) == -1)) {
    return SizedBox();
  } else {
    _getData.addOrderIdCheck(snapshot['orderNum']);
  }
  final orderNum = snapshot['orderNum'];
  final timestamps = Timestamp(
          snapshot['orderTime'].seconds, snapshot['orderTime'].nanoseconds)
      .toDate();
  return Container(
      width: 250,
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 20),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 3),
                  decoration: DottedDecoration(color: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '${snapshot['orderNum']}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '일반',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          TimerBuilder.periodic(
                            const Duration(minutes: 1),
                            builder: (context) {
                              var date = new DateTime.now();
                              var orderTimeCount = date
                                  .difference(timestamps)
                                  .inMinutes
                                  .toString();
                              print(orderTimeCount);
                              return Text(
                                '$orderTimeCount분 경과',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('order')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      final documents = snapshot.data!.docs;
                      return Expanded(
                        child: ListView(
                          children: documents
                              .map((doc) => test(doc, orderNum))
                              .toList(),
                        ),
                      );
                    }),
                Container(
                  child: Text('${timestamps}'),
                ),
                Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            // ignore: deprecated_member_use
                            primary: Color(0xffFFE735)),
                        onPressed: () {},
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            '일괄처리',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        )))
              ],
            ),
          )));
}

Widget test(DocumentSnapshot snapshot, orderNum) {
  if (snapshot['orderNum'] == orderNum) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: DottedDecoration(color: Colors.black),
      child: order(snapshot),
    );
  } else {
    return SizedBox();
  }
}
