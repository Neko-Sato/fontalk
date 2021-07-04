import 'package:flutter/material.dart';
import '../../../configs/configs.dart';

class Home extends StatefulWidget {
  @override
  createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Home'),
      TextButton(
          onPressed: () {
            Configs.fontalk.account.signOut();
            Navigator.of(context).pushReplacementNamed('/welcome/signin');
          },
          child: Text("SignOut")),
      TextButton(
          onPressed: () {
            Configs.fontalk.account.delete();
            Navigator.of(context).pushReplacementNamed('/welcome/signin');
          },
          child: Text("Delete")),
    ]);
  }
}
