import 'package:flutter/material.dart';
import 'top_screens/.dart';

class TopScreen extends StatefulWidget {
  @override
  createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  int _currentIndex = 0;
  List<WidgetBuilder> bodys = [
    (context) => Home(),
    (context) => Talks(),
    (context) => Settings(),
  ];
  List<String> titles = [
    Home.title,
    Talks.title,
    Settings.title,
  ];
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(label: Home.title, icon: Home.icon),
    BottomNavigationBarItem(label: Talks.title, icon: Talks.icon),
    BottomNavigationBarItem(label: Settings.title, icon: Settings.icon),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.titles[this._currentIndex]),
      ),
      body: this.bodys[this._currentIndex](context),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._currentIndex,
          items: this.items,
          onTap: (value) {
            this._currentIndex = value;
            setState(() {});
          }),
    );
  }
}
