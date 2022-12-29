// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/orderMenuCard/menuCard.dart';

class orderMenu extends StatefulWidget {
  orderMenu({super.key, this.snapshot, this.orderNum});
  final snapshot;
  var orderNum;

  @override
  State<orderMenu> createState() => _orderMenuState();
}

class _orderMenuState extends State<orderMenu> {
  @override
  Widget build(BuildContext context) {
    final snapshot = widget.snapshot;
    if (snapshot['orderNum'] == widget.orderNum) {
      return TextButton(
          onPressed: () {
            if (snapshot['orderClear'] == true) {
              FirebaseFirestore.instance
                  .collection('order')
                  .doc(snapshot.id)
                  .update({'orderClear': false});
            } else {
              FirebaseFirestore.instance
                  .collection('order')
                  .doc(snapshot.id)
                  .update({'orderClear': true});
            }
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: DottedDecoration(color: Colors.black),
            child: MenuCard(snapshot: snapshot),
          ));
    } else {
      return SizedBox();
    }
  }
}
