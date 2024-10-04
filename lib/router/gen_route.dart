import 'package:flutter/material.dart';
import 'package:fluttour/presentation/splash/splash_page.dart';
import 'package:fluttour/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'navigation_controller.dart';
import 'navigation_tab.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

/// MARK: - generateRoute
final generateRoute = GoRouter(
  initialLocation: Routes.root.routeName,
  navigatorKey: rootNavigatorKey,
  routes: <RouteBase>[
    /// Splash
    GoRoute(
      path: Routes.root.routeName,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SplashPage(),
      ),
      routes: const <RouteBase>[],
    ),

    /// Not found page
    GoRoute(
      path: Routes.notFound.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return NotFoundScreen(uri: state.extra as String? ?? '');
      },
    ),

    /// Navigation bar
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        if (state.path == Routes.splash.routeName) {
          return const SizedBox();
        }
        return NavigationController(
          navigationShell: navigationShell,
          state: state,
        );
      },
      branches: NavigationTab.values.map((tab) => tab.branch).toList(),
    ),
  ],
);

class NotFoundScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const NotFoundScreen({super.key, required this.uri});

  final String uri;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(child: Text('Can\'t find a page for: $uri')),
    );
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required super.builder,
    required RouteSettings super.settings,
    super.maintainState,
    super.fullscreenDialog,
  });

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
    required super.builder,
    required RouteSettings super.settings,
    super.maintainState,
    super.fullscreenDialog,
  });
}
