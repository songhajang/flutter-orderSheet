import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:get/get.dart';

class Category {
  String custom;
  bool isSected;
  Category(this.custom, {this.isSected = false});
}

// ----firebase 데이터 option 시작----
Widget buildItem(DocumentSnapshot snapshot) {
  final value = Category(snapshot['custom'], isSected: snapshot['isSected']);
  ClickCheck(snapshot);
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: ElevatedButton(
      onPressed: () {
        toggleSected(snapshot);
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
void toggleSected(DocumentSnapshot snapshot) {
  final _getData = Get.put(reactiveStateManagePage());
  if (snapshot['custom'] == '전체[섹션없음]') {
    for (var data in _getData.dataId) {
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
}

// section 예외처리 함수
void ClickCheck(snapshot) {
  final _getData = Get.put(reactiveStateManagePage());
  if (snapshot['isSected'] == true) {
    if (!_getData.datas.contains(snapshot['custom'])) {
      _getData.addDataId(snapshot.id);
      _getData.addDatas(snapshot['custom']);
      if (_getData.datas[0] == '전체[섹션없음]' && _getData.datas.length < 2) {
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
    _getData.removeDatas(snapshot['custom']);
    _getData.removeDataId(snapshot.id);

    if (_getData.datas.length < 1) {
      _getData.addDataId('0');
      _getData.addDatas('전체[섹션없음]');

      FirebaseFirestore.instance
          .collection('category')
          .doc('0')
          .update({'isSected': true});
    } else {
      _getData.removeDataId('0');
      _getData.removeDatas('전체[섹션없음]');
    }
  }
}
