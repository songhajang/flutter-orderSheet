// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/totalOrderTitle.dart';

import 'orderCard.dart';

final Stream<QuerySnapshot> _stream =
    FirebaseFirestore.instance.collection('order').snapshots();

Widget endDrewar({
  required GlobalKey<ScaffoldState> scaffoldKey,
}) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      totalOrderTitle('총 주문 메뉴'),
                      totalOrderTitle(' 개'),
                    ],
                  ),
                ),
                StreamBuilder(
                    stream: _stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Text('데이터를 불러오지 못했어요');
                      }
                      if (snapshot.data == []) {
                        return const Text('data');
                      }
                      return ListView.builder(
                          // padding: const EdgeInsets.only(bottom: 50),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) =>
                              (order(snapshot.data!.docs[index])));
                    }),
              ],
            )),
      ]);
}
