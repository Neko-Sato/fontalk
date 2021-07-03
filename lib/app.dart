import 'package:flutter/material.dart';
import 'routes/routes.dart' show routes, generateRoute;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fontalk',
      initialRoute: '/startup',
      onGenerateRoute: (RouteSettings setting) =>
          generateRoute(setting: setting, routes: routes),
    );
  }
}
