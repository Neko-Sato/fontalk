import 'package:flutter/material.dart';

class Talks extends StatefulWidget {
  @override
  createState() => _TalksState();
}

class _TalksState extends State<Talks> {
  List<Widget> talks = [];
  @override
  Widget build(BuildContext context) {
    if (talks.isEmpty) {
      return Text("karadesu");
    }
    return ListView(children: this.talks, reverse: true);
  }

  Widget talk(String title, Icon icon) {
    this.setState(() => null);
    return Card(
      child: GestureDetector(
        child: ListTile(
          title: Text("SignOut"),
        ),
      ),
    );
  }
}
