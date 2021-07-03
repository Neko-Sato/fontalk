import 'package:flutter/material.dart';

PageRoute? generateRoute(
    {required RouteSettings setting, required RouteMap routes}) {
  print(setting.name);
  WidgetBuilder? build =
      routes.builder(setting.name!.split('/').skip(1).toList());
  if (build != null)
    return MaterialPageRoute(builder: build, settings: setting);
}

class RouteBase {
  WidgetBuilder? builder(List<String> path) => null;
}

class Route extends RouteBase {
  WidgetBuilder widget;
  Route(this.widget);
  @override
  WidgetBuilder builder(List<String> path) {
    return this.widget;
  }
}

class RouteMap extends RouteBase {
  Map<String, RouteBase?> routes;
  RouteMap(this.routes) {
    if (!this.routes.containsKey('/')) this.routes['/'] = null;
  }
  @override
  WidgetBuilder? builder(List<String> path) {
    if (path.length == 0) path.add('');
    RouteBase? routeBase = this.routes['/' + path[0]];
    if (routeBase != null) return routeBase.builder(path.skip(1).toList());
  }
}
