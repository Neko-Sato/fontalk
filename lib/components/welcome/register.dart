import 'package:flutter/material.dart';
import '../../configs/configs.dart';
import '../../common/common.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    final Widget title = Text(
      "Register :>",
      style: TextStyle(
        fontSize: 50,
      ),
    );
    final Widget forms = Container(
        width: 300.0,
        child: Column(children: <Widget>[
          TextField(
            controller: this._emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            controller: this._passwordController,
            obscureText: _showPassword,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: "Password",
              suffixIcon: IconButton(
                  icon: Icon(this._showPassword
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined),
                  onPressed: () {
                    this.setState(() {
                      this._showPassword = !this._showPassword;
                    });
                  }),
            ),
          ),
        ]));
    final Widget buttons = Column(children: <Widget>[
      ElevatedButton(
        child: const Text('Register'),
        onPressed: this.register,
      ),
    ]);
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[title, forms, buttons],
        )));
  }

  void register() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return FutureBuilder(
              future: Configs.fontalk.account.register(
                this._emailController.text,
                this._passwordController.text,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  String value = snapshot.data as String;
                  if (value == 'new-account') {
                    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                      Navigator.of(context)
                        ..popUntil(ModalRoute.withName('/welcome/signin'))
                        ..pushReplacementNamed('/welcome/setup');
                    });
                  } else {
                    return AlertDialog(title: Text(value), actions: <Widget>[
                      TextButton(
                        child: Text("OK"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ]);
                  }
                }
                return WrappedAround();
              });
        });
  }
}
