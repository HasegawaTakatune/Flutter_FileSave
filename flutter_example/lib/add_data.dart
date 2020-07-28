import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'commons.dart';

/// タイプ：テキスト
const int INPUT_TEXT = 0;
/// タイプ：数値
const int INPUT_NUMBER = 1;

/// タグ：名前
const int TAG_NAME = 0;
/// タグ：学名
const int TAG_SCIENCE = 1;
/// タグ：分類
const int TAG_CLASSIFIC = 2;
/// タグ：分類詳細
const int TAG_CLASSIFIC_DETAILS = 3;
/// タグ：分布
const int TAG_DISTRIB = 4;
/// タグ：最小全長
const int TAG_MN_LEN = 5;
/// タグ：最大全長
const int TAG_MX_LEN = 6;

class AddDataForm extends StatefulWidget {
  @override
  AddDataFormState createState() => AddDataFormState();
}

class AddDataFormState extends State<AddDataForm> {
  /// InputFormField：ラベル一覧
  final _labels = [
    '動物の名前を入力してください',
    '学名を入力してください',
    '分類を入力してください',
    '分類詳細を入力してください',
    '分布を入力してください',
    '最小全長を入力してください(cm)',
    '最大全長を入力してください(cm)'
  ];

  /// InputFormField：ヒント一覧
  final _hints = ['動物名*', '学名*', '分類*', '分類詳細*', '分布*', '最小全長*', '最大全長*'];

  /// フォームキー
  final _formKey = GlobalKey<FormState>();

  /// フォーカス一覧
  final _focuses = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  /// 名前
  String _name = '';

  /// 学名
  String _scientificName = '';

  /// 分類
  String _classification = '';

  /// 分類詳細
  String _classificationDetails = '';

  /// 分布
  String _distribution = '';

  /// 最小全長
  int _minLength = 0;

  /// 最大全長
  int _maxLength = 0;

  /// 送信結果を保存する
  String _sendResult = 'Result';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AddDataForm')),
      body: buildInputForm(context),
    );
  }

  /// 入力フォームウィジェット
  Widget buildInputForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              buildInputTextField(context, TAG_NAME, INPUT_TEXT),
              buildInputTextField(context, TAG_SCIENCE, INPUT_TEXT),
              buildInputTextField(context, TAG_CLASSIFIC, INPUT_TEXT),
              buildInputTextField(context, TAG_CLASSIFIC_DETAILS, INPUT_TEXT),
              buildInputTextField(context, TAG_DISTRIB, INPUT_TEXT),
              buildInputTextField(context, TAG_MN_LEN, INPUT_NUMBER),
              buildInputTextField(context, TAG_MX_LEN, INPUT_NUMBER),
              Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(_sendResult,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ))),
              RaisedButton.icon(
                onPressed: _checkInputForm,
                icon: Icon(
                  Icons.cloud_upload,
                  color: Colors.white,
                ),
                label: Text('送信',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                splashColor: Colors.purple,
                color: Colors.tealAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 各フォームを入力確認する
  void _checkInputForm() {
    // 入力確認　→　入力値の保存　→　データ送信
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _sendAnimalData();
    }
  }

  /// 入力値をJson形式に変換して送信する
  void _sendAnimalData() async {
    // アクセスポイント設定
    String url = Comn.ACCESS_POINT + 'InsertZooData.php';
    Map<String, String> headers = {'content-type': 'application/json'};

    // 入力値をJson形式に変換する
    String body = json.encode({
      Comn.NAME: _name,
      Comn.SCIENCE: _scientificName,
      Comn.CLASSIFIC: _classification,
      Comn.CLASSIFIC_DETAILS: _classificationDetails,
      Comn.DISTRIB: _distribution,
      Comn.MN_LEN: _minLength.toString(),
      Comn.MX_LEN: _maxLength.toString(),
      Comn.UPD_DAY: DateTime.now().toString()
    });

    // アクセスポイントにデータ保存リクエストを送る
    final res = await http.post(url, headers: headers, body: body);
    if (res.statusCode != 200) {
      setState(() {
        int statusCode = res.statusCode;
        _sendResult = "Failed to post $statusCode";
      });
      return;
    }

    // 実行結果を取得して送信リザルトに表示する
    final data = json.decode(utf8.decode(res.bodyBytes));
    setState(() {
      final issues = data as List;
      issues.forEach((dynamic element) {
        // 送信判定
        final issue = element as Map;
        if (issue[Comn.IS_SUCCESS])
          _sendResult = 'Success!! \nMessage:' + issue[Comn.MSG];
        else
          _sendResult = 'Failure!! \nMessage:' + issue[Comn.MSG];
      });
    });
  }

  /// 入力フィールとウィジェット
  Widget buildInputTextField(BuildContext context, int tag, int inputType) {
    return TextFormField(
      focusNode: _focuses[tag],
      autovalidate: false,
      keyboardType:
          inputType == INPUT_TEXT ? TextInputType.text : TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration:
          InputDecoration(labelText: _labels[tag], hintText: _hints[tag]),
      onFieldSubmitted: (value) {
        if (tag + 1 < _labels.length)
          FocusScope.of(context).requestFocus(_focuses[tag + 1]);
      },
      validator: (String value) {
        if (inputType == INPUT_TEXT)
          return value.isEmpty ? '必須入力です。' : null;
        else
          return value.isEmpty
              ? '必須入力です。'
              : int.tryParse(value) == null ? '数値(cm)を入力してください。' : null;
      },
      onSaved: (String value) {
        switch (tag) {
          case TAG_NAME:
            _name = value;
            break;
          case TAG_SCIENCE:
            _scientificName = value;
            break;
          case TAG_CLASSIFIC:
            _classification = value;
            break;
          case TAG_CLASSIFIC_DETAILS:
            _classificationDetails = value;
            break;
          case TAG_DISTRIB:
            _distribution = value;
            break;
          case TAG_MN_LEN:
            _minLength = int.parse(value);
            break;
          case TAG_MX_LEN:
            _maxLength = int.parse(value);
            break;
          default:
            break;
        }
      },
    );
  }
}