import 'package:flutter/material.dart';
import '../../../configs/configs.dart';
import 'dart:typed_data';

class Home extends StatefulWidget {
  static String title = 'Home';
  static Widget icon = Icon(Icons.home);
  @override
  createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = 'name';
  String userId = 'user_id';
  Widget image = Icon(Icons.account_circle, size: 100.0);
  _HomeState() {
    Configs.fontalk.account.info().then((value) {
      this.name = value['name'];
      this.userId = value['user_id'];
      if (value['image'] != null)
        this.image = Image.memory(value['image'], width: 100.0, height: 100.0);
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text(this.name), Text(this.userId), this.image]);
  }
}
