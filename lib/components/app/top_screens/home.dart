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
  int followsNum = 0;
  int followersNum = 0;
  _HomeState() {
    Configs.fontalk.account.info().then((value) {
      this.name = value['name'];
      this.userId = value['user_id'];
      if (value['image'] != null)
        this.image = Image.memory(value['image'], width: 100.0, height: 100.0);
      this.followsNum = value['follows_num'];
      this.followersNum = value['followers_num'];
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        this.image,
        Column(
          children: [
            Text(this.name),
            Text("@" + this.userId),
          ],
        )
      ]),
      Row(
        children: [
          Text("follows: " + this.followsNum.toString()),
          Text("followers: " + this.followersNum.toString()),
        ],
      )
    ]);
  }
}
