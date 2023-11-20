import 'named_route.dart';

enum AppRoute {
  root,
  notFound,
  splash,
  sliver,
}

class Routes {
  static NamedRoute get root => NamedRoute(appRoute: AppRoute.root);

  static NamedRoute get notFound => NamedRoute(appRoute: AppRoute.notFound);

  static NamedRoute get splash => NamedRoute(appRoute: AppRoute.splash);

  static NamedRoute get sliver => NamedRoute(appRoute: AppRoute.sliver);

  static List<NamedRoute> values = [
    root,
    notFound,
    splash,
    sliver,
  ];
}
