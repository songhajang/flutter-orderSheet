import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Options {
  String option;
  Options(this.option);
}

class menuOptions extends StatefulWidget {
  menuOptions({super.key, this.snapshot, this.orderClear});
  final snapshot;
  var orderClear;

  @override
  State<menuOptions> createState() => _menuOptionsState();
}

class _menuOptionsState extends State<menuOptions> {
  @override
  Widget build(BuildContext context) {
    final snapshot = widget.snapshot;
    var _orderClear = widget.orderClear;
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          snapshot['option'],
          style: _orderClear
              ? const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.lineThrough,
                  decorationThickness: 4,
                  color: Color(0xffBABBBB),
                )
              : const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
        ));
  }
}
