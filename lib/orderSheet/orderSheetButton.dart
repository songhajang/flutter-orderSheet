import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:get/get.dart';

class orderSheetButton extends StatefulWidget {
  orderSheetButton({super.key, this.useBtnsData});
  final useBtnsData;

  @override
  State<orderSheetButton> createState() => _orderSheetButtonState();
}

class _orderSheetButtonState extends State<orderSheetButton> {
  @override
  Widget build(BuildContext context) {
    final _getData = Get.put(reactiveStateManagePage());
    final snapshot = widget.useBtnsData;
    return Container(
        width: double.infinity,
        child: snapshot['orderClear'] == true
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    // ignore: deprecated_member_use
                    primary: Color(0xff000000)),
                onPressed: () {
                  // FirebaseFirestore.instance
                  //     .collection('order')
                  //     .doc(snapshot.id)
                  //     .delete();
                  _getData.ordersAll.forEach((element) {
                    if (_getData.orderCount[element] == snapshot['orderNum']) {
                      FirebaseFirestore.instance
                          .collection('order')
                          .doc(element)
                          .update({'orderClear': false});
                    }
                  });
                  print(_getData);
                },
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    '처리완료',
                    style: TextStyle(
                        // color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    // ignore: deprecated_member_use
                    primary: Color(0xffFFE735)),
                onPressed: () {
                  _getData.ordersAll.forEach((element) {
                    if (_getData.orderCount[element] == snapshot['orderNum']) {
                      FirebaseFirestore.instance
                          .collection('order')
                          .doc(element)
                          .update({'orderClear': true});
                    }
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    '일괄처리',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                )));
  }
}
