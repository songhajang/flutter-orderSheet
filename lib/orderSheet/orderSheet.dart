// ignore: unused_import
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:get/get.dart';
import 'orderMenu.dart';
import 'orderSheetButton.dart';
import 'orderSheetTitle.dart';

class orderSheet extends StatelessWidget {
  orderSheet(this.snapshot);
  // const orderSheet({super.key});
  final snapshot;

  @override
  Widget build(BuildContext context) {
    final orderSheetGetDatas = Get.put(reactiveStateManagePage());
    // ignore: unused_local_variable
    final value = Orders(snapshot['orderData'], snapshot['category'],
        snapshot['orderNum'], snapshot['orderClear'], snapshot['orderTime']);

    orderSheetGetDatas.addOrderCount(snapshot.id, snapshot['orderNum']);

    // ignore: invalid_use_of_protected_member
    if (!(orderSheetGetDatas.orderIdCheck.value.indexOf(snapshot['orderNum']) ==
        -1)) {
      return SizedBox();
    } else {
      orderSheetGetDatas.addOrderIdCheck(snapshot['orderNum']);
    }
    final orderNum = snapshot['orderNum'];

    return Container(
        width: 250,
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 20),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  orderSheetTitle(snapshot),
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
                              .map((doc) =>
                                  orderMenu(snapshot: doc, orderNum: orderNum))
                              .toList(),
                        ));
                      }),
                  orderSheetButton(
                    useBtnsData: snapshot,
                  ),
                ],
              ),
            )));
  }
}
