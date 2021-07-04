import 'package:flutter/material.dart';
import 'configs/configs.dart';
import 'routes/routes.dart' show routes, generateRoute;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Configs.routeObserver = RouteObserver<PageRoute>();
    return MaterialApp(
      title: 'fontalk',
      initialRoute: '/startup',
      onGenerateRoute: (RouteSettings setting) =>
          generateRoute(setting: setting, routes: routes),
      navigatorObservers: [Configs.routeObserver],
    );
  }
}
