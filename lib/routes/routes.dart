import 'route_helpers.dart';
export 'route_helpers.dart' show generateRoute;
import '../components/.dart';

RouteMap routes = RouteMap({
  '/startup': Route((context) => StartUp()),
  '/app': RouteMap({'/top_screen': Route((context) => TopScreen())}),
  '/welcome': RouteMap({
    '/signin': Route((context) => SignIn()),
    '/register': Route((context) => Register()),
    '/setup': Route((context) => SetUp()),
  }),
});
