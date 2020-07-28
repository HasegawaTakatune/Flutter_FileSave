import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CoffeeBreakPage extends StatefulWidget {
  @override
  _CoffeeBreakPageState createState() {
    return _CoffeeBreakPageState();
  }
}

class _CoffeeBreakPageState extends State<CoffeeBreakPage> {
  WebViewController _controller;

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
      appBar: AppBar(
        title: _normalText('コーヒー休憩', 18),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _controller.loadUrl(
                  'https://blog.proglearn.com/2019/06/21/%E3%81%9F%E3%81%BE%E3%81%AB%E3%81%AF%E4%BC%91%E3%82%82%E3%81%86%E3%81%9C%E3%80%82%E6%81%AF%E6%8A%9C%E3%81%8D%E3%81%AE%E3%81%99%E3%83%BD%E3%82%81/');
            },
          ),
          IconButton(
            icon: Icon(Icons.add_comment),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('たまには休もうぜ・・・。'),
                    );
                  });
            },
          )
        ],
      ),
      body: WebView(
        initialUrl:
            'https://blog.proglearn.com/2019/06/21/%E3%81%9F%E3%81%BE%E3%81%AB%E3%81%AF%E4%BC%91%E3%82%82%E3%81%86%E3%81%9C%E3%80%82%E6%81%AF%E6%8A%9C%E3%81%8D%E3%81%AE%E3%81%99%E3%83%BD%E3%82%81/',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
