// ----appbar 구현 시작----

import 'package:flutter/material.dart';

Widget CreateAppBar({
  required String title,
  // required String sectionText,
  required GlobalKey<ScaffoldState> scaffoldKey,
  required List datas,
}) {
  // print(sectionText);

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
        title,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    ),
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () => scaffoldKey.currentState!.openDrawer(),
    ),
    actions: <Widget>[
      IconButton(
          onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
          icon: const Icon(Icons.receipt))
    ],
  );
}
// ----appbar 구현 끝-----