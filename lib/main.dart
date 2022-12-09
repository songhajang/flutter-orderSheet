// import 'dart:math';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';

// firestore 연동
// FirebaseFirestore firestore = FirebaseFirestore.instance;
// void main() async {
// await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );
// runApp(MyApp());
// }

void main() {
  runApp(MyApp());
}

class Todo {
  String title;
  bool isDone;

  Todo(this.title, {this.isDone = false});
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
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CreateAppBar(
          title: title,
        ),
      ),
      body: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Text(
                      '주방 섹션 지정',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // ElevatedButton(onPressed: (() => {}), child: const Text('전체'))
                ]),
          ),
        ),
      ),
    );
  }

// appbar 구현
  Widget CreateAppBar({String? title}) {
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
        onPressed: () => scaffoldKey.currentState?.openDrawer(),
        // onPressed: (() {}),
      ),
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: const Icon(Icons.receipt))
      ],
    );
  }
}
