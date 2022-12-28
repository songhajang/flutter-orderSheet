// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/totalOrderTitle.dart';
import 'package:get/get.dart';

import 'orderCard.dart';

final Stream<QuerySnapshot> _stream =
    FirebaseFirestore.instance.collection('order').snapshots();

Widget endDrewar({
  required GlobalKey<ScaffoldState> scaffoldKey,
}) {
  final _getData = Get.put(reactiveStateManagePage());
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      StreamBuilder(
          stream: _stream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Text('데이터를 불러오지 못했어요');
            }
            if (snapshot.data == []) {
              return const Text('data');
            }
            var orderCount = 0;
            final document = snapshot.data!.docs;
            document.forEach((element) {
              if (!(element['orderClear'])) {
                orderCount++;
              }
            });
            return Column(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          totalOrderTitle('총 주문 메뉴'),
                          totalOrderTitle('$orderCount 개'),
                        ],
                      ),
                    )),
                (Container(
                    color: Colors.white,
                    // height: 300,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) =>
                                (orderCard(snapshot.data!.docs[index])))))),
                (Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      // ignore: deprecated_member_use
                      primary: Colors.grey,
                    ),
                    child: const Text('닫기'),
                  ),
                ))
              ],
            );
          }),
    ],
  );
}
