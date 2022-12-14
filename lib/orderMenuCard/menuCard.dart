import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'menuOptions.dart';

class MenuCard extends StatefulWidget {
  const MenuCard({super.key, this.snapshot});
  final snapshot;

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    final snapshot = widget.snapshot;
    final value = Orders(snapshot['orderData'], snapshot['category'],
        snapshot['orderNum'], snapshot['orderClear'], snapshot['orderTime']);
    var orderClear = snapshot['orderClear'];
    return Container(
        margin: EdgeInsets.only(bottom: 5),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: snapshot['orderClear']
                  ? const Color(0xffF4F4F6)
                  : const Color(0xffFFF8C7),
              child: Column(
                children: [
                  snapshot['orderClear']
                      ? SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot['orderData'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 4,
                                    color: Color(0xffBABBBB),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Card(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot['orderData'],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          )),
                  // ?????? ????????? ????????????
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('order')
                          .doc(snapshot.id)
                          .collection('options')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Text('???????????? ???????????? ????????????...');
                        }
                        if (snapshot.data == null) {
                          return SizedBox.shrink();
                        }
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) => (menuOptions(
                                snapshot: snapshot.data!.docs[index],
                                orderClear: orderClear)));
                      }),
                ],
              ),
            )));
  }
}
