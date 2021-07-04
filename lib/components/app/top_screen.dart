import 'package:flutter/material.dart';
import 'top_screens/.dart';

class TopScreen extends StatefulWidget {
  @override
  createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  int _currentIndex = 0;
  List<String> titles = ['Home', 'Talks', 'Settings'];
  List<WidgetBuilder> bodys = [
    (context) => Home(),
    (context) => Talks(),
    (context) => Settings(),
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
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: 'Talks', icon: Icon(Icons.chat)),
            BottomNavigationBarItem(
                label: 'Settings', icon: Icon(Icons.settings)),
          ],
          onTap: (value) {
            this._currentIndex = value;
            setState(() {});
          }),
    );
  }
}
