import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'orderOption.dart';

Widget order(DocumentSnapshot snapshot) {
  // ignore: unused_local_variable
  final value =
      Orders(snapshot['orderData'], snapshot['category'], snapshot['orderNum']);
  // print(datas);
  return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            color: const Color(0xffFFF8C7),
            child: Column(
              children: [
                Card(
                    color: Color(0xffFFE735),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                    margin: EdgeInsets.zero,
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              snapshot['orderData'],
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    )),
                // 옵션 데이터 불러오기
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('order')
                        .doc(snapshot.id)
                        .collection('options')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Text('데이터를 불러오는 중입니다...');
                      }
                      if (snapshot.data == null) {
                        return SizedBox.shrink();
                      }
                      return ListView.builder(
                          // padding: const EdgeInsets.only(bottom: 5),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) =>
                              (orderOption(snapshot.data!.docs[index])));
                    }),
              ],
            ),
          )));
}
