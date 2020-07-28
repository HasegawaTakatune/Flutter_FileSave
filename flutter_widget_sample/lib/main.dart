import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import 'HomePage.dart';
import 'GridList.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Samples',
      //home: _buildCard(),
      //home: _buildStack(),
      //home: buildGridList(true),
      //home: buildHomePage('Strawberry Pavlova Recipe'),
      //home: ShowContainerImagesDemo(),
      //home: ShowImagesDemo(),
      home: ShowHelloWorldDemo(),
    );
  }

  // Card //////////////////////////////////////////////////////////////////////
  Widget _buildCard()=>SizedBox(
    width: 400,
    height: 210,
    child: Card(
      child: Column(
        children: [
          ListTile(
            title: Text('1625 Main Street',
            style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text('My City, CA 99984'),
            leading: Icon(
              Icons.restaurant_menu,
              color: Colors.blue[500],
            ),
          ),
          Divider(),
          ListTile(
            title: Text('(408)555-1212',
            style: TextStyle(fontWeight: FontWeight.w500)),
            leading: Icon(
              Icons.contact_phone,
              color: Colors.blue[500],
            ),
          ),
          ListTile(
            title: Text('costa@example.com'),
            leading: Icon(
              Icons.contact_mail,
              color: Colors.blue[500],
            ),
          ),
        ],
      ),
    ),
  );
  // Card //////////////////////////////////////////////////////////////////////
  // Stack /////////////////////////////////////////////////////////////////////
  Widget _buildStack() => Stack(
    alignment: const Alignment(0.0, -1.0),
    children: [
      CircleAvatar(
        backgroundImage: AssetImage('images/pic1.jpg'),
        radius: 100,
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.black45,
        ),
        child: Text(
          'Mia B',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color:Colors.white,
          ),
        ),
      ),
    ],
  );
  // Stack /////////////////////////////////////////////////////////////////////
  // Container Images //////////////////////////////////////////////////////////
  Widget ShowContainerImagesDemo() =>
  Scaffold(
    appBar: AppBar(title: Text('Flutter Container Images Demo'),),
    body: Center(child: _buildImageColumn()),
  );

  Widget _buildImageColumn() => Container(
    decoration: BoxDecoration(
      color: Colors.black12,
    ),
    child: Column(
      children: [
        _buildImageRow(1),
        _buildImageRow(3),
      ],
    ),
  );

  Widget _buildDecoratedImage(int imageIndex) => Expanded(
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(width: 10,color: Colors.greenAccent),
        borderRadius: const BorderRadius.all(const Radius.circular(8)),
      ),
      margin: const EdgeInsets.all(4),
      child: Image.asset('images/container_pic$imageIndex.jpg'),
    ),
  );

  Widget _buildImageRow(int imageIndex) => Row(
    children: [
      _buildDecoratedImage(imageIndex),
      _buildDecoratedImage(imageIndex + 1),
    ],
  );
  // Container Images //////////////////////////////////////////////////////////
  // Images ////////////////////////////////////////////////////////////////////
  Widget ShowImagesDemo() =>
  Scaffold(
    appBar: AppBar(title: Text('Flutter Image Size Demo'),),
    body: Center(child: buildExpandedImagesWithFlex(),),
  );

  Widget buildOverflowingRow() =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('images/pic1.jpg'),
          Image.asset('images/pic2.jpg'),
          Image.asset('images/pic3.jpg'),
        ],
      );

  Widget buildExpandedImages() =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Image.asset('images/pic1.jpg'),),
          Expanded(child: Image.asset('images/pic2.jpg'),),
          Expanded(child: Image.asset('images/pic3.jpg'),),
        ],
      );

  Widget buildExpandedImagesWithFlex() =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset('images/pic1.jpg'),
          ),
          Expanded(
            flex: 2,
            child: Image.asset('images/pic2.jpg'),
          ),
          Expanded(
            child: Image.asset('images/pic3.jpg'),
          ),
        ],
      );

  Widget buildOverflowingColumn() =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('images/pic1.jpg'),
          Image.asset('images/pic2.jpg'),
          Image.asset('images/pic3.jpg'),
        ],
      );
  // Images ////////////////////////////////////////////////////////////////////
  // HelloWorld ////////////////////////////////////////////////////////////////
  Widget ShowHelloWorldDemo() =>
  Scaffold(
    appBar: AppBar(title: Text('Flutter Hello World Demo'),),
    body: Center(child: buildMaterialHelloWorld(),),
  );

  Widget buildMaterialHelloWorld() =>
      Column(
        children: [
          Center(
            child: Text('Hello World'),
          ),
          _buildCard(),
        ],
      );

  Widget buildNonMaterialHelloWorld() =>
      Text(
        'Hello World',
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontSize: 32,
          color: Colors.black87,
        ),
      );
  // HelloWorld ////////////////////////////////////////////////////////////////
}