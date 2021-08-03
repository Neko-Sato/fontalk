import 'package:flutter/material.dart';
import '../../../configs/configs.dart';

class Settings extends StatefulWidget {
  static String title = 'Settings';
  static Widget icon = Icon(Icons.settings);
  @override
  createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Card(
        child: GestureDetector(
          child: ListTile(
            title: Text("SignOut"),
            onTap: () {
              Configs.fontalk.account.signOut();
              Navigator.of(context).pushReplacementNamed('/welcome/signin');
            },
          ),
        ),
      ),
      Card(
        child: GestureDetector(
          child: ListTile(
            title: Text(
              "Account Delete",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              Configs.fontalk.account.delete();
              Navigator.of(context).pushReplacementNamed('/welcome/signin');
            },
          ),
        ),
      ),
    ];
    return ListView(children: children);
  }
}
