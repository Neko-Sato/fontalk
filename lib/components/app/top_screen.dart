import 'package:flutter/material.dart';
import 'top_screens/.dart';

class TopScreen extends StatefulWidget {
  @override
  createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  int _currentIndex = 0;
  List<String> titles = ['Home', 'talks'];
  List<WidgetBuilder> bodys = [(context) => Home(), (context) => Talks()];
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
            BottomNavigationBarItem(label: 'chat', icon: Icon(Icons.chat)),
            BottomNavigationBarItem(label: 'chat2', icon: Icon(Icons.chat)),
          ],
          onTap: (value) {
            this._currentIndex = value;
            setState(() {});
          }),
    );
  }
}
