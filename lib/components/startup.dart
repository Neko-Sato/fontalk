import 'package:flutter/material.dart';
import '../configs/configs.dart';
import '../fontalk/fontalk.dart';

class StartUp extends StatefulWidget {
  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  @override
  Widget build(BuildContext context) {
    () async {
      var temp = await Fontalk.initialize();
      await Future.delayed(Duration(seconds: 1));
      return temp;
    }()
        .then((value) {
      Configs.fontalk = value;
      this.loaded(context);
    });
    return Container(color: Color(0xffffff), child: Image.asset('icon.png'));
  }

  void loaded(context) async {
    if (await Configs.fontalk.account.isSignedIn()) {
      print("to home");
      Navigator.of(context)
        ..pushReplacementNamed(
          '/app/top_screen',
        );
    } else {
      Navigator.of(context)
        ..pushReplacementNamed(
          '/welcome/signin',
        );
    }
  }
}
