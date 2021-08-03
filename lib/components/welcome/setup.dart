import 'package:flutter/material.dart';
import '../../configs/configs.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SetUp extends StatefulWidget {
  @override
  _SetUpState createState() => _SetUpState();
}

class _SetUpState extends State<SetUp> {
  TextEditingController _userNamelController = TextEditingController();
  TextEditingController _userIdlController = TextEditingController();
  File? _imagefile;
  bool _userIdError = true;
  @override
  Widget build(BuildContext context) {
    final Widget forms = Container(
        width: 300.0,
        child: Column(children: [
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
          Row(
            children: this._imagefile == null
                ? <Widget>[
                    Icon(Icons.account_circle, size: 100.0),
                    TextButton(
                        child: Text("画像を選択する"),
                        onPressed: () async {
                          var pickedFile = await Configs.picker
                              .pickImage(source: ImageSource.gallery);
                          this._imagefile = File(pickedFile!.path);
                          setState(() {});
                        }),
                  ]
                : <Widget>[
                    Image.file(this._imagefile!, width: 100.0, height: 100.0),
                    TextButton(
                        child: Text("削除"),
                        onPressed: () {
                          this._imagefile = null;
                          setState(() {});
                        }),
                  ],
          )
        ]));
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
        userId: this._userIdlController.text,
        image: this._imagefile);
    Navigator.of(context).pushReplacementNamed('/app/top_screen');
  }
}
