import 'package:flutter/material.dart';
import 'configs/configs.dart';
import 'routes/routes.dart' show routes, generateRoute;

//
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
//

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    () async {
      FirebaseApp app = await Firebase.initializeApp(name: 'fontalk');
      print(app);
      print(FirebaseAuth.instance.app);
    }();
    return MaterialApp(
      title: 'fontalk',
      initialRoute: '/startup',
      onGenerateRoute: (RouteSettings setting) =>
          generateRoute(setting: setting, routes: routes),
    );
  }
}
