import 'package:flutter/material.dart';

class Talks extends StatefulWidget {
  @override
  createState() => _TalksState();
}

class _TalksState extends State<Talks> {
  List<Widget> talks = [];
  @override
  Widget build(BuildContext context) {
    return ListView(children: this.talks);
  }

  Widget addTalk(String title, Icon icon) {
    return Text("temp");
  }
}
