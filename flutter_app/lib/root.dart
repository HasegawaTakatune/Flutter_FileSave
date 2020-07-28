import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'routes/home_route.dart';
import 'routes/talk_route.dart';
import 'routes/timeline_route.dart';
import 'routes/wallet_route.dart';
import 'routes/news_route.dart';

class RootWidget extends StatefulWidget{
  RootWidget({Key key}): super(key:key);
  //const RootWidget();

  @override
  _RootWidgetState createState()=>_RootWidgetState();
}

class _RootWidgetState extends State<RootWidget>{
  int _selectedIndecx = 0;
  final _bottomNavigationBarItems = <BottomNavigationBarItem>[];

  // アイコン情報
  static const _footerIcons = [
    Icons.home,
    Icons.textsms,
    Icons.access_time,
    Icons.content_paste,
    Icons.work,
  ];

  static const _footerItemNames = [
    'ホーム',
    'トーク',
    'タイムライン',
    'ニュース',
    'ウォレット',
  ];

  var _routes = [
    Home(),
    Talk(),
    TimeLine(),
    News(),
    Wallet(),
  ];

  @override
  void initState(){
    super.initState();
    _bottomNavigationBarItems.add(_UpdateActiveState(0));
    for(var i = 1; i<_footerItemNames.length; i++){
      _bottomNavigationBarItems.add(_UpdateDeactiveState(i));
    }
  }

  BottomNavigationBarItem _UpdateActiveState(int index){
    return BottomNavigationBarItem(
      icon:Icon(
        _footerIcons[index],
        color: Colors.black87,
      ),
      title: Text(
        _footerItemNames[index],
        style: TextStyle(
          color: Colors.black87,
        ),
      )
    );
  }

  BottomNavigationBarItem _UpdateDeactiveState(int index){
    return BottomNavigationBarItem(
      icon: Icon(
        _footerIcons[index],
        color: Colors.black26,
      ),
      title: Text(
        _footerItemNames[index],
        style: TextStyle(
          color: Colors.black26,
        ),
      )
    );
  }

  void _onItemTapped(int index){
    setState(() {
      _bottomNavigationBarItems[_selectedIndecx]=_UpdateDeactiveState(_selectedIndecx);
      _bottomNavigationBarItems[index] = _UpdateActiveState(index);
      _selectedIndecx = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: _routes.elementAt(_selectedIndecx),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndecx,
        onTap: _onItemTapped,
      ),
    );
  }
}