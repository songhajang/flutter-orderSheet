// import 'dart:math';

// import 'package:flutter/cupertino.dart';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Test.dart';
import 'Appbar.dart';
import 'drewer.dart';
import 'endDrewer.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

// firestore 연동
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class Category {
  String custom;
  bool isSected;
  Category(this.custom, {this.isSected = false});
}

class Orders {
  String orderData;
  String category;
  Orders(this.orderData, this.category);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xff3D4253)),
      // darkTheme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = '주문내역이 없습니다.';
  List datas = [];
  List dataId = [];
  @override
  Widget build(BuildContext context) {
    print(datas);
    var scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CreateAppBar(
          title: title,
          scaffoldKey: scaffoldKey,
          datas: datas,
        ),
      ),
      body: Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
            width: 300,
            backgroundColor: Colors.black,
            child: Drewar(
              scaffoldKey: scaffoldKey,
              datas: datas,
              dataId: dataId,
            ),
          ),
          endDrawer: Drawer(
            width: 250,
            backgroundColor: Colors.black,
            child: endDrewar(scaffoldKey: scaffoldKey, datas: datas),
          ),
          body: Column(children: [
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('order').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  final documents = snapshot.data!.docs;

                  log("snapshot : ${documents.toList()}");
                  return Expanded(
                    child: ListView(
                      children: documents.map((doc) => Test(doc)).toList(),
                    ),
                  );
                }),
          ])),
    );
  }
}
