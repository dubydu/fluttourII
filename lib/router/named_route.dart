import 'package:fluttour/router/routes.dart';

class NamedRoute {
  final AppRoute mainRoute;
  final AppRoute? subRoute;

  String get routeName =>
      '/${mainRoute.name}${subRoute != null ? '/${subRoute!.name}' : ''}';

  NamedRoute({
    required this.mainRoute,
    this.subRoute,
  });

  @override
  String toString() {
    return 'NamedRoute{route: $routeName}';
  }
}
