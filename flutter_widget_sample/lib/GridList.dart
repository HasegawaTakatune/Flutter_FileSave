import 'package:flutter/material.dart';

Widget buildGridList(bool showGrid){

  List<String> titles = [
    'CineArts at the Empire','The Castro Theater','Alamo Drafthouse Cinema',
    'Roxie Theater','United Artists Stonestown Twin','AMC Metreon 16',
    'K\'s Kitchen','Emmy\'s Restaurant','Chaiya Thai Restaurant',
    'La Ciccia',
  ];

  List<String> subtitles = [
    '85 W Portal Ave','429 Castro St','2550 Mission St',
    '3117 16th St','501 Buckingham Way','135 4th St #3000',
    '757 Monterey Blvd','1923 Ocean Ave','272 Claremont Blvd',
    '291 30th St',
  ];

  List<Container> _buildGridTileList(int count) => List.generate(
      count, (i) => Container(child: Image.asset('images/grid/pic$i.jpg')));

  ListTile _tile(String title,String subtitle,IconData icon) => ListTile(
    title: Text(title,
    style: TextStyle(
      fontWeight:FontWeight.w500,
      fontSize: 20
    )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
  );

  Widget _buildGrid() => GridView.extent(
      maxCrossAxisExtent: 150,
    padding: const EdgeInsets.all(4),
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    children: _buildGridTileList(30));

  Widget _buildList() => ListView(
    children: List.generate(titles.length, (index) {
      return _tile(titles[index], subtitles[index], Icons.theaters);
    }) ,
  );

  return Scaffold(
    appBar: AppBar(title: Text('Flutter Grid Demo'),),
    body: Center(child: showGrid ? _buildGrid():_buildList()),
  );
}