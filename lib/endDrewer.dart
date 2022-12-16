// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Test.dart';

Widget endDrewar({
  required GlobalKey<ScaffoldState> scaffoldKey,
  required List datas,
}) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '총 주문 메뉴',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '개',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // StreamBuilder<QuerySnapshot>(
                //     stream: FirebaseFirestore.instance
                //         .collection('order')
                //         .snapshots(),
                //     builder: (context, snapshot) {
                //       if (!snapshot.hasData) {
                //         return const CircularProgressIndicator();
                //       }
                //       final documents = snapshot.data!.docs;
                //       return Expanded(
                //         child: ListView(
                //           children: documents.map((doc) => Test(doc)).toList(),
                //         ),
                //       );
                //     }),
              ],
            )),
      ]);
}
