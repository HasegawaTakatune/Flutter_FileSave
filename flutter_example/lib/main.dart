import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'commons.dart';
import 'add_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Issues',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Issues'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _titles = <String>[];

  @override
  void initState() {
    super.initState();
    _load();
  }

  /// データ取得
  Future<void> _load() async {
    // アクセスポイントからデータ取得リクエストを送る
    final res = await http.get(Comn.ACCESS_POINT + 'SelectZooData.php');
    if (res.statusCode != 200) {
      setState(() {
        int statusCode = res.statusCode;
        _titles.add("Failed to post $statusCode");
      });
      return;
    }
    final data = json.decode(utf8.decode(res.bodyBytes));
    setState(() {
      // データの抽出
      final issues = data as List;
      issues.forEach((dynamic element) {
        // 名前を抽出して配列に保存する
        final issue = element as Map;
        _titles.add(issue[Comn.NAME] as String);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cloud_upload),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddDataForm()));
            },
          )
        ],
      ),
      body: buildListView(context),
    );
  }

  Widget buildListView(BuildContext context) {
    return ListView.builder(itemBuilder: (BuildContext context, int index) {
      if (index >= _titles.length) return null;
      return ListTile(title: Text(_titles[index]));
    });
  }
}