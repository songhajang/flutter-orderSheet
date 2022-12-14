import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

// ----firebase 데이터 option 시작----
Widget buildItem(DocumentSnapshot snapshot, datas) {
  test(snapshot, datas);
  // submitSection(snapshot);
  final value = Category(snapshot['custom'], isSected: snapshot['isSected']);
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: ElevatedButton(
      onPressed: () {
        toggleSected(snapshot, datas);
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
void toggleSected(DocumentSnapshot snapshot, datas) {
  FirebaseFirestore.instance
      .collection('category')
      .doc(snapshot.id)
      .update({'isSected': !snapshot['isSected']});
}

// firestore 선택 데이터 업데이트 함수 끝----
void submitSection(datas) {
  print(datas);
}

void test(snapshot, datas) {
  if (snapshot['isSected'] == true) {
    if (!datas.contains(snapshot.id)) {
      datas.add(snapshot.id);
      if (datas[0] == '0' && datas.length < 2) {
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
    datas.remove(snapshot.id);
    if (datas.length < 1) {
      datas.add('0');
      FirebaseFirestore.instance
          .collection('category')
          .doc('0')
          .update({'isSected': true});
    } else {
      datas.remove('0');
    }
  }

  print(datas);
}
