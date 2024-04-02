import 'package:flutter/cupertino.dart';
import 'package:fluttour/router/navigation_tab.dart';
import 'package:fluttour/router/routes.dart';
import 'package:go_router/go_router.dart';

extension AppRouter<T extends StatefulWidget> on State<T> {
  /// Transition to home
  void transitionToHomePage() {
    GoRouter.of(context).go(NavigationTab.home.rootRoute);
  }

  /// Transition to sliver
  void transitionToSliverPage() {
    GoRouter.of(context).push(Routes.sliver.routeName);
  }

  /// Back
  void pop() {
    Navigator.pop(context);
  }
}
