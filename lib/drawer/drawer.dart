// ----Drewar 구현 시작----

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:get/get.dart';

import 'categoryItem.dart';

class cartegoryDrawer extends StatefulWidget {
  const cartegoryDrawer({super.key, this.scaffoldKey});
  final scaffoldKey;

  @override
  State<cartegoryDrawer> createState() => _cartegoryDrawerState();
}

class _cartegoryDrawerState extends State<cartegoryDrawer> {
  @override
  Widget build(BuildContext context) {
    final _scaffoldkey = widget.scaffoldKey;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Container(
        margin: const EdgeInsets.all(20),
        child: const Text(
          '주방 섹션 지정',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('category').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            final documents = snapshot.data!.docs;
            return Expanded(
              child: ListView(
                children: documents
                    .map((doc) => categoryItem(
                          snapshot: doc,
                        ))
                    .toList(),
              ),
            );
          }),
      Row(
        children: [
          Container(
            width: 150,
            height: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                // ignore: deprecated_member_use
                primary: Colors.grey,
              ),
              onPressed: () {
                _scaffoldkey.currentState!.closeDrawer();
              },
              child: const Text('닫기'),
            ),
          ),
          Container(
            width: 150,
            height: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  // ignore: deprecated_member_use
                  primary: Color(0xff28BE91)),
              onPressed: () {
                final _getData = Get.put(reactiveStateManagePage());
                submitSection(_getData.datas);
              },
              child: Text('확인'),
            ),
          ),
        ],
      )
    ]);
  }
}

// Widget Drewar({
//   required GlobalKey<ScaffoldState> scaffoldKey,
// }) {}
// ----Drewar 구현 끝----

