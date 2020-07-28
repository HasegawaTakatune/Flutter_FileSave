import 'package:flutter/material.dart';

class KeyboardPadding extends StatefulWidget {
  KeyboardPadding({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _KeyboardPaddingState createState() {
    return _KeyboardPaddingState();
  }
}

class _KeyboardPaddingState extends State<KeyboardPadding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('qwertyuiop'),
            Text(
              'asdfghjkl',
              style: Theme.of(context).textTheme.display1,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Text',
                  contentPadding:
                      const EdgeInsets.only(left: 25, bottom: 15, top: 15),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                      borderRadius: BorderRadius.circular(25.7))),
            )
          ],
        ),
      ),
    );
  }
}
