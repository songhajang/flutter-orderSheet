// ----appbar 구현 시작----
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CreateAppBar({
  String? title,
  required GlobalKey<ScaffoldState> scaffoldKey,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    title: TextButton.icon(
      onPressed: () {},
      icon: const Icon(
        Icons.replay,
        size: 30.0,
        color: Colors.black,
      ),
      label: Text(
        title!,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    ),
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () => scaffoldKey.currentState!.openDrawer(),
      // onPressed: (() {}),
    ),
    actions: <Widget>[
      IconButton(onPressed: () {}, icon: const Icon(Icons.receipt))
    ],
  );
}
// ----appbar 구현 끝-----