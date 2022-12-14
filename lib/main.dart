// import 'dart:math';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Appbar.dart';
import 'drewer.dart';
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
  // var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CreateAppBar(title: title, scaffoldKey: scaffoldKey),
      ),
      body: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          width: 300,
          backgroundColor: Colors.black,
          child: Drewar(scaffoldKey: scaffoldKey, datas: datas),
        ),
      ),
    );
  }
}
