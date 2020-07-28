import 'package:flutter/material.dart';

class News extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("ニュース"),
      ),
      body: Center(child: Text("ニュース")),
    );
  }
}