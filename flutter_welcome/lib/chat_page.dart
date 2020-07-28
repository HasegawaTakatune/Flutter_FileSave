import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'coffee_break_page.dart';
import 'keyboard_padding.dart';

class ChatPage extends StatefulWidget {
  String _name;

  ChatPage({String name}) {
    _name = name;
  }

  @override
  _ChatPageState createState() {
    return _ChatPageState(this._name);
  }
}

class _ChatPageState extends State<ChatPage> {
  final _textController = new TextEditingController();

  String _name;

  _ChatPageState(String name) {
    _name = name ?? 'ゲスト';
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
      appBar: AppBar(title: _normalText('チャット', 18)),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: <Widget>[
            _normalText('ようこそ$_nameさん', 18),
            buildChatForm(context),
            buildMessageForm(context),
            buildAboutThisApp(context),
            buildABreak(context),
            buildKeyboard(context)
          ],
        ),
      ),
    );
  }

  Widget buildChatForm(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: 300.0, width: 500.0),
      child: Container(
          color: Colors.cyan,
          child: Stack(
            children: <Widget>[
              StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection('chat')
                    .document('room')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> doc) {
                  if (doc.hasError)
                    return _normalText('Error: ${doc.error}', 24);
                  switch (doc.connectionState) {
                    case ConnectionState.waiting:
                      return _normalText('Loading...', 24);
                    default:
                      return ListView(
                          padding: EdgeInsets.only(bottom: 80.0),
                          children: <Widget>[
                            _normalText(
                                'message >> ${doc.data['message']}', 18),
                            _normalText('name >> ${doc.data['name']}', 18),
                            _normalText(
                                'time >> ${doc.data['post_time'].toDate()}', 18)
                          ]);
                  }
                },
              ),
            ],
          )),
    );
  }

  Widget buildMessageForm(BuildContext context) {
    Future<void> addMessage(String text, String name) {
      return Firestore.instance.collection('chat').document('room').setData(
          {'message': text, 'name': name, 'post_time': DateTime.now()});
    }

    return SingleChildScrollView(
      child: Positioned(
        height: 80.0,
        left: 0.0,
        right: 0.0,
        bottom: .0,
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: _textController,
                ),
              ),
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.all(10),
                  color: Colors.blue,
                  onPressed: () {
                    addMessage(_textController.text, _name);
                    _textController.text = '';
                  },
                  child: _normalText('送信', 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAboutThisApp(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: RaisedButton(
          child: _normalText('このアプリについて', 18),
          onPressed: () async {
            var result = await showDialog<int>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: _normalText('このアプリについて', 24),
                    content: _normalText(
                        'その時に送られてくる気まぐれなコメントを、タイミングにとらわれず気軽にお使いください', 20),
                    actions: <Widget>[
                      FlatButton(
                        child: _normalText('わかった', 18),
                        onPressed: () => Navigator.pop(context, 0),
                      ),
                    ],
                  );
                });
          }),
    );
  }

  Widget buildABreak(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: RaisedButton(
        padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
        child: _normalText('ひと休み', 18),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CoffeeBreakPage()));
        },
      ),
    );
  }

  Widget buildKeyboard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: RaisedButton(
        padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
        child: _normalText('キーボードテスト', 18),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => KeyboardPadding(title: 'Keyboard')));
        },
      ),
    );
  }
}
