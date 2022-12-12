// import 'dart:math';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class Test {
  int tableId;
  String title;
  Test(
    this.tableId,
    this.title,
  );
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
  FirebaseFirestore firestore = FirebaseFirestore.instance;
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
          width: 250,
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
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('test')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }
                        final documents = snapshot.data!.docs;
                        return Expanded(
                          child: ListView(
                            children: documents
                                .map((doc) => _buildItem(doc))
                                .toList(),
                          ),
                        );
                      }),
                ]),
          ),
        ),
      ),
    );
  }

// appbar 구현 시작----
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
// appbar 구현 끝-----

// firebase 데이터 뿌리기 시작----
Widget _buildItem(DocumentSnapshot snapshot) {
  final a = Test(snapshot['tableId'], snapshot['title']);
  return ListTile(
    title: Text(
      'table: ${a.tableId.toString()}',
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 20.0,
      ),
    ),
  );
}
  // firebase 데이터 뿌리기 끝----
