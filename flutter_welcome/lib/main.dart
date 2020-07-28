import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_welcome/chat_page.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

enum Gender { Man, Woman, Other }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Welcome Page'),

      // ロケーション設定（多言語設定）
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('ja'),
      ],
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
  final _formKey = GlobalKey<FormState>();

  String _birthday = "";
  String _name;
  Gender _genderType = Gender.Man;

  final _languageMap = {
    '日本語': 'ja',
    '英語': 'en',
    '韓国語': 'ko',
    '繁体字（台湾）': 'zh-TW',
  };
  var _selectedLanguage = 'ja';

  bool _agreement = false;

  // 年月日入力
  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        locale: const Locale('ja'),
        initialDate: DateTime.now(),
        firstDate: new DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null)
      setState(() {
        _birthday = DateFormat('yyyy/MM/dd').format(picked).toString();
      });
  }

  // 性別選択ラジオボタン変更時イベント
  void _onChangedGender(Gender value) {
    setState(() {
      _genderType = value;
    });
  }

  // 性別ごとのカラー設定
  Color _genderColor(Gender value) {
    Color result;
    if (value == Gender.Man)
      result = Colors.blue[200];
    else if (value == Gender.Woman)
      result = Colors.pinkAccent;
    else
      result = Colors.greenAccent;
    return result;
  }

  // 性別選択ラジオボタン
  Widget _genderRadio(String title, Gender value) {
    return Row(
      children: <Widget>[
        Radio(
          activeColor: _genderColor(value),
          value: value,
          groupValue: _genderType,
          onChanged: _onChangedGender,
        ),
        _normalText(title, 18.0),
      ],
    );
  }

  Widget _normalText(String message, double fontSize) {
    return Text(
      message,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              // 画面外タップ時のカーソル解除処理
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        buildInputName(context),
                        buildInputBirthday(context),
                        buildInputGender(context),
                        buildSelectedLanguage(context),
                        buildAgreementTermsOfService(context),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        floatingActionButton: buildChatPageButton(context)
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget buildInputName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextFormField(
        // 名前入力
        autofocus: false,
        enabled: true,
        maxLength: 20,
        maxLengthEnforced: false,
        obscureText: false,
        autovalidate: false,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w800,
        ),
        decoration: const InputDecoration(
          hintText: 'ニックネームを入力してください',
          labelText: 'ニックネーム*',
        ),
        validator: (String value) {
          return value.isEmpty ? '必須入力です' : null;
        },
        onSaved: (String value) {
          _name = value;
        },
      ),
    );
  }

  Widget buildInputBirthday(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: RaisedButton(
        // 生年月日入力
        color: Colors.cyanAccent,
        child:
            _normalText(_birthday.isEmpty ? '生年月日を入力してください' : _birthday, 18.0),
        shape: UnderlineInputBorder(),
        onPressed: _selectDate,
      ),
    );
  }

  Widget buildInputGender(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: (Column(
        children: <Widget>[
          _normalText('性別を選択してください', 20.0),
          Row(
            // 性別選択ラジオボタン
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _genderRadio('男', Gender.Man),
              _genderRadio('女', Gender.Woman),
              _genderRadio('その他', Gender.Other),
            ],
          )
        ],
      )),
    );
  }

  Widget buildSelectedLanguage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        children: <Widget>[
          _normalText('言語を選択してください', 18.0),
          Container(
            // 言語選択ドロップダウン
            width: 300,
            color: Colors.cyanAccent,
            child: DropdownButton(
              isExpanded: true,
              value: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value;
                });
              },
              items: _languageMap.entries.map((entry) {
                return DropdownMenuItem(
                  child: _normalText(entry.key, 18.0),
                  value: entry.value,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAgreementTermsOfService(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
      child: Column(
        children: <Widget>[
          RichText(
            // 利用規約テキスト
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'テスト規約',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                          'https://paiza.hatenablog.com/entry/2018/12/11/%E3%82%A8%E3%83%B3%E3%82%B8%E3%83%8B%E3%82%A2%E3%81%AB%E8%81%9E%E3%81%84%E3%81%9F%E3%80%8C%E9%9B%86%E4%B8%AD%E3%81%99%E3%82%8B%E3%81%9F%E3%82%81%E3%81%AB%E5%AE%9F%E8%B7%B5%E3%81%97%E3%81%A6%E3%81%84');
                    },
                ),
                TextSpan(
                  text: 'に',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: '同意',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch('https://www.geekpage.jp/blog/?id=2006/12/22');
                    },
                ),
                TextSpan(
                  text: 'しますか？',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          CheckboxListTile(
            // 同意チェックボックス
            value: _agreement,
            activeColor: Colors.cyan,
            title: _normalText('同期する', 18.0),
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (bool value) {
              setState(() {
                _agreement = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildChatPageButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: _agreement ? Colors.cyan : Colors.grey,
      onPressed: () => {
        if (_agreement)
          {
            if (this._formKey.currentState.validate())
              {
                this._formKey.currentState.save(),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatPage(
                              name: _name,
                            )))
              }
          }
      },
      tooltip: 'Increment',
      child: Icon(Icons.message),
    );
  }
}
