import 'package:flutter/cupertino.dart';
import 'package:fluttour/router/navigation_tab.dart';
import 'package:fluttour/router/routes.dart';
import 'package:go_router/go_router.dart';

extension AppRouter<T extends StatefulWidget> on State<T> {
  void transitionToHomePage() {
    GoRouter.of(context).go(NavigationTab.home.rootRoute);
  }

  void transitionToSliverPage() {
    GoRouter.of(context)
        .push('${NavigationTab.home.rootRoute}${Routes.sliver.routeName}');
  }

  void pop() {
    Navigator.pop(context);
  }
}
