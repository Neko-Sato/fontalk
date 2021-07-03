import 'package:flutter/material.dart';
import '../../configs/configs.dart';
import '../../common/common.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _showPassword = true;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Widget title = Text(
      "Welcame! :)",
      style: TextStyle(
        fontSize: 50,
      ),
    );
    final Widget icon = ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset('icon.png', height: 150));

    final Widget forms = Container(
        width: 300.0,
        child: Column(children: <Widget>[
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: this._showPassword,
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
              ))
        ]));
    final Widget buttons = Column(children: <Widget>[
      ElevatedButton(
        child: const Text('Sign In'),
        onPressed: this.signin,
      ),
      OutlinedButton(
        child: Text("Register"),
        onPressed: this.register,
      ),
    ]);
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[title, icon, forms, buttons],
    )));
  }

  void signin() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          var credential = firebase_auth.EmailAuthProvider.credential(
              email: this._emailController.text,
              password: this._passwordController.text);
          return FutureBuilder(
              future: Configs.fontalk.account.signIn(credential),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  String value = snapshot.data as String;
                  if (value == 'successfully-signin') {
                    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                      Navigator.of(context)
                        ..pop()
                        ..pushReplacementNamed('/app/top_screen');
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

  register() {
    Navigator.of(context).pushNamed('/welcome/register');
  }
}
