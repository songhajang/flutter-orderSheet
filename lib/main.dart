// import 'dart:html';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xff3D4253)),
      // darkTheme: ThemeData(brightness: Brightness.dark),
      home: const MyHomePage(),
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.replay,
                  size: 24.0,
                  color: Colors.black,
                ),
                label: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.settings),
                onPressed: (() {}),
              ),
              actions: <Widget>[
                IconButton(onPressed: () {}, icon: const Icon(Icons.receipt))
              ],
            )),
        // body: Text('test')
      ),
    );
  }
}
