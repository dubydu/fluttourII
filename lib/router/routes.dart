import 'named_route.dart';

enum AppRoute {
  unknown,
  root,
  home,
  sliver
}

class Routes {
  static NamedRoute get root =>
      NamedRoute(appRoute: AppRoute.root);

  static NamedRoute get unknown =>
      NamedRoute(appRoute: AppRoute.unknown);

  static NamedRoute get home =>
      NamedRoute(appRoute: AppRoute.home);

  static NamedRoute get sliver =>
      NamedRoute(appRoute: AppRoute.sliver);

  static List<NamedRoute> values = [
    unknown,
    root,
    home,
    sliver
  ];
}