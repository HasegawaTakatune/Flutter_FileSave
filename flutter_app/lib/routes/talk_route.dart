import 'package:flutter/material.dart';
import 'package:flutter_app/tile.dart';

class Talk extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("トーク"),
      ),
      body:ListView(
        //padding: const EdgeInsets.all(8),
        children: <Widget>[
          Tile(icon: Icons.person,userName: "鹿太郎",message: "しかし、鹿しかいない"),
          Tile(icon: Icons.person,userName: "久米酒",message: "おいしいよー"),
          Tile(icon: Icons.person,userName: "くら",message: "とっても美味しい沖縄のお酒"),
          Tile(icon: Icons.person,userName: "団長",message: "止まるんじゃ、ねぇぞ"),
          Tile(icon: Icons.person,userName: "サルーイン",message: "こい"),
          Tile(icon: Icons.person,userName: "がらはど",message: "だめだ！いくら積まれても…"),
          Tile(icon: Icons.person,userName: "太郎",message: "だめだ、久しぶりにキレちまったよ"),
          Tile(icon: Icons.person,userName: "Harry",message: "エクスペクト・パトローナーム"),
          Tile(icon: Icons.person,userName: "くろひげ",message: "似合ってるぜぃ、そのきずぅ～"),
          Tile(icon: Icons.person,userName: "あすらん",message: "キラァァァァ"),
          Tile(icon: Icons.person,userName: "知人B",message: "1.14 release"),
        ],
      ),
    );
  }
}