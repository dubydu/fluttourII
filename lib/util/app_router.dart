import 'package:flutter/cupertino.dart';
import 'package:fluttour/router/navigation_controller.dart';
import 'package:fluttour/router/routes.dart';

extension AppRouter<T extends StatefulWidget> on State<T> {
  void transitionToHomePage() {
    NavigationController.push(Routes.home.routeName, replace: true);
  }
}