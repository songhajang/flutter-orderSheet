import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'main.dart';

// ----firebase 데이터 option 시작----
Widget buildItem(DocumentSnapshot snapshot, datas, dataId) {
  final value = Category(snapshot['custom'], isSected: snapshot['isSected']);
  ClickCheck(snapshot, datas, dataId);
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: ElevatedButton(
      onPressed: () {
        toggleSected(snapshot, dataId);
      },
      style: value.isSected
          ? const ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll<Color>(Color(0xff28BE91)),
            )
          : const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)),
      child: ListTile(
        title: Text(
          value.custom.toString(),
          style: value.isSected
              ? const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.white)
              : const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
        ),
      ),
    ),
  );
}
// ----firebase 데이터 option 끝----

// firestore 선택 데이터 업데이트 함수 시작----
void toggleSected(DocumentSnapshot snapshot, dataId) {
  if (snapshot['custom'] == '전체[섹션없음]') {
    for (var data in dataId) {
      FirebaseFirestore.instance
          .collection('category')
          .doc(data)
          .update({'isSected': false});
    }
  }
  FirebaseFirestore.instance
      .collection('category')
      .doc(snapshot.id)
      .update({'isSected': !snapshot['isSected']});
}

// firestore 선택 데이터 업데이트 함수 끝----
void submitSection(datas) {
  print(datas);
  // if (datas.length < 2) {
  //   sectionText = '';
  // } else {
  //   sectionText = datas.toString();
  // }
}

// section 예외처리 함수
void ClickCheck(snapshot, datas, dataId) {
  if (snapshot['isSected'] == true) {
    if (!datas.contains(snapshot['custom'])) {
      dataId.add(snapshot.id);
      datas.add(snapshot['custom']);
      if (datas[0] == '전체[섹션없음]' && datas.length < 2) {
        FirebaseFirestore.instance
            .collection('category')
            .doc('0')
            .update({'isSected': true});
      } else {
        FirebaseFirestore.instance
            .collection('category')
            .doc('0')
            .update({'isSected': false});
      }
    }
  } else {
    datas.remove(snapshot['custom']);
    dataId.remove(snapshot.id);

    if (datas.length < 1) {
      dataId.add('0');
      datas.add('전체[섹션없음]');

      FirebaseFirestore.instance
          .collection('category')
          .doc('0')
          .update({'isSected': true});
    } else {
      dataId.remove('0');
      datas.remove('전체[섹션없음]');
    }
  }
}
