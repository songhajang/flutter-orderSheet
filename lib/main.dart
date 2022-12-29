import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer/drawer.dart';
import 'Appbar.dart';
import 'endDrewer/endDrewer.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'orderSheet/orderSheet.dart';

// firestore 연동
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xff3D4253)),
      home: MyHomePage(),
    );
  }
}

class Orders {
  String orderData;
  String category;
  int orderNum;
  bool orderClear;
  Timestamp orderTime;
  Orders(this.orderData, this.category, this.orderNum, this.orderClear,
      this.orderTime);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class reactiveStateManagePage extends GetxController {
  RxList _datas = [].obs;
  RxList _dataId = [].obs;
  RxList _orderIdCheck = [].obs;
  RxMap _orderCount = {}.obs;
  RxList _ordersAll = [].obs;

  RxList get datas => _datas;
  RxList get dataId => _dataId;
  RxList get orderIdCheck => _orderIdCheck;
  RxMap get orderCount => _orderCount;
  RxList get ordersAll => _ordersAll;

  void addDatas(String value) {
    _datas.add(value);
  }

  void removeDatas(String value) {
    _datas.remove(value);
  }

  void addDataId(String value) {
    _dataId.add(value);
  }

  void removeDataId(String value) {
    _dataId.remove(value);
  }

  void addOrderIdCheck(int value) {
    _orderIdCheck.add(value);
  }

  void resetOrderIdCheck() {
    _orderIdCheck = [].obs;
  }

  void addOrderCount(String value, int orderNum) {
    _orderCount[value] = orderNum;
    // _orderCount[orderNum] = value;
    if (!(_ordersAll.contains(value))) {
      _ordersAll.add(value);
    }
  }

  void removeOrderCount(String value) {
    _orderCount.remove(value);
    _ordersAll.remove(value);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _getData = Get.put(reactiveStateManagePage());
    var scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CreateAppBar(scaffoldKey: scaffoldKey),
      ),
      body: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          width: 300,
          backgroundColor: Colors.black,
          child: cartegoryDrawer(scaffoldKey: scaffoldKey),
        ),
        body: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('order').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final documents = snapshot.data!.docs;
                _getData.resetOrderIdCheck();

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
          child: orderEndDrawer(scaffoldKey: scaffoldKey),
        ),
      ),
    );
  }
}
