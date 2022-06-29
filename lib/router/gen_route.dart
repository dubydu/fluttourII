import 'package:flutter/material.dart';
import 'package:fluttour/presentation/home/home_page.dart';
import 'package:fluttour/presentation/sliver/sliver_page.dart';
import 'package:fluttour/presentation/splash/splash_page.dart';
import 'package:fluttour/router/routes.dart';

Route<Object>? generateRoute(RouteSettings settings) {
  final namedRoute = settings.name == '/'
      ? Routes.root
      : Routes.values.firstWhere((element) {
    if (settings.name != null) {
      return settings.name! == '/${element.appRoute.name}';
    }
    return false;
  }, orElse: () => Routes.unknown);
  debugPrint('\n=============== (Origin: ${settings.name}) Navigating to: ${namedRoute.toString()}\n');
  switch (namedRoute.appRoute) {
    case AppRoute.unknown:
      return _errorRoute();
    case AppRoute.home:
      return _buildRoute(settings: settings, screen: const HomePage());
    case AppRoute.root:
      return _buildRoute(settings: settings, screen: const SplashPage());
    case AppRoute.sliver:
      return _buildRoute(settings: settings, screen: const SliverPage());
  }
}

Route<Object>? _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('ERROR'),
      ),
    );
  });
}

Route<Object>? _buildRoute({
  required RouteSettings settings,
  required Widget screen,
  bool fullscreenDialog = false
}) {
  return CustomMaterialPageRoute(
    settings: settings,
    fullscreenDialog: fullscreenDialog,
    builder: (context) {
      return screen;
    },
  );
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required WidgetBuilder builder,
    required RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
      builder: builder,
      maintainState: maintainState,
      settings: settings,
      fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

class FadePageRoute<T> extends PageRoute<T> {
  final Widget child;

  FadePageRoute(this.child);

  @override
  Color get barrierColor => Colors.black;

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 700);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class CustomMaterialPageRoute<T> extends MaterialPageRoute<T> {
  @override
  @protected
  bool get hasScopedWillPopCallback {
    return false;
  }

  CustomMaterialPageRoute({
    required WidgetBuilder builder,
    required RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
    builder: builder,
    settings: settings,
    maintainState: maintainState,
    fullscreenDialog: fullscreenDialog,
  );
}