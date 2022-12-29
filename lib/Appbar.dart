// ----appbar 구현 시작----

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:get/get.dart';

class CreateAppBar extends StatefulWidget {
  const CreateAppBar({super.key, this.scaffoldKey});
  final scaffoldKey;

  @override
  State<CreateAppBar> createState() => _CreateAppBarState();
}

class _CreateAppBarState extends State<CreateAppBar> {
  final _getData = Get.put(reactiveStateManagePage());
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = widget.scaffoldKey;
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
          '주문내역이 없습니다.',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => _scaffoldKey.currentState!.openDrawer(),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
            icon: const Icon(Icons.receipt))
      ],
    );
  }
}
