import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class orderSheetTitle extends StatelessWidget {
  const orderSheetTitle(this.snapshot);

  final snapshot;

  @override
  Widget build(BuildContext context) {
    final timestamps = Timestamp(
            snapshot['orderTime'].seconds, snapshot['orderTime'].nanoseconds)
        .toDate();
    return Container(
      padding: EdgeInsets.only(bottom: 3),
      decoration: DottedDecoration(color: Colors.black),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              '${snapshot['orderNum']}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Column(
            children: [
              Text(
                '일반',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TimerBuilder.periodic(
                const Duration(minutes: 1),
                builder: (context) {
                  var date = new DateTime.now();
                  var orderTimeCount =
                      date.difference(timestamps).inMinutes.toString();
                  return Text(
                    '$orderTimeCount분 경과',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
