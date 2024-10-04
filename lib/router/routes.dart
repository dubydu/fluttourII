import 'named_route.dart';

enum AppRoute {
  root,
  notFound,
  home,
  detail,
  settings,
  splash,
  sliver,
}

class Routes {
  static NamedRoute get root => NamedRoute(
        mainRoute: AppRoute.root,
      );

  static NamedRoute get notFound => NamedRoute(
        mainRoute: AppRoute.notFound,
      );

  static NamedRoute get splash => NamedRoute(
        mainRoute: AppRoute.splash,
      );

  static NamedRoute get home => NamedRoute(
        mainRoute: AppRoute.home,
      );

  static NamedRoute get detail => NamedRoute(
        mainRoute: AppRoute.detail,
      );

  static NamedRoute get settings => NamedRoute(
        mainRoute: AppRoute.settings,
      );

  static NamedRoute get sliver => NamedRoute(
        mainRoute: AppRoute.home,
        subRoute: AppRoute.sliver,
      );
}
