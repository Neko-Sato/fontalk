import 'package:flutter/material.dart';
import '../../configs/configs.dart';

class SetUp extends StatefulWidget {
  @override
  _SetUpState createState() => _SetUpState();
}

class _SetUpState extends State<SetUp> {
  TextEditingController _userNamelController = TextEditingController();
  TextEditingController _userIdlController = TextEditingController();
  bool _userIdError = true;
  @override
  Widget build(BuildContext context) {
    final Widget forms = Container(
        width: 300.0,
        child: Column(
          children: [
            TextField(
              controller: this._userNamelController,
              keyboardType: TextInputType.text,
              maxLength: 20,
              decoration: InputDecoration(
                labelText: "User Name",
              ),
            ),
            TextField(
              controller: this._userIdlController,
              keyboardType: TextInputType.text,
              maxLength: 16,
              decoration: InputDecoration(
                  labelText: "User Id",
                  errorText: this._userIdError ? null : "Not available"),
              onChanged: (value) async {
                this._userIdError =
                    await Configs.fontalk.account.isAvailableUserId(value);
                this.setState(() {});
              },
            ),
          ],
        ));
    final Widget buttons = Column(children: <Widget>[
      ElevatedButton(
        child: const Text('Start'),
        onPressed: this.setup,
      ),
    ]);
    return Scaffold(
        appBar: AppBar(
          title: Text("Set Up"),
        ),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            forms,
            buttons,
          ],
        )));
  }

  Future<void> setup() async {
    await Configs.fontalk.account.setUp(
        name: this._userNamelController.text,
        userId: this._userIdlController.text);
    Navigator.of(context).pushReplacementNamed('/app/top_screen');
  }
}
