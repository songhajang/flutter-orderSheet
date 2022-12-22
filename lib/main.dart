// import 'dart:math';

// import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/orderCard.dart';
import 'package:flutter_application_1/orderSheet.dart';
import 'Appbar.dart';
import 'drewer.dart';
import 'endDrewer.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

// firestore 연동
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(GetMaterialApp(home: MyApp()));
  runApp(MyApp());
}

class SimpleController extends GetxController {
  RxList datas = [].obs;
  RxList dataId = [].obs;

  RxList get dataTest => datas;
  RxList get dataIdTest => dataId;

  void getAdd(value) {
    datas.add(value);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xff3D4253)),
      // darkTheme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(),
    );
  }
}

class Orders {
  String orderData;
  String category;
  Orders(this.orderData, this.category);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = '주문내역이 없습니다.';
  @override
  Widget build(BuildContext context) {
    Get.put(SimpleController());
    // print(test);
    var scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: GetBuilder<SimpleController>(
          builder: (controller) {
            return CreateAppBar(
              title: title,
              scaffoldKey: scaffoldKey,
              datas: controller.datas,
            );
          },
        ),
      ),
      body: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
            width: 300,
            backgroundColor: Colors.black,
            child: GetBuilder<SimpleController>(
              builder: (controller) {
                return Drewar(
                  scaffoldKey: scaffoldKey,
                  datas: controller.datas,
                  dataId: controller.dataId,
                );
              },
            )),
        body: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('order').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final documents = snapshot.data!.docs;
                return Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: documents.map((doc) => orderSheet(doc)).toList(),
                  ),
                );
              }),
        ]),
        endDrawer: Drawer(
          width: 250,
          backgroundColor: Colors.black,
          child: endDrewar(scaffoldKey: scaffoldKey),
        ),
      ),
    );
  }
}
