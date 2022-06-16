library order_app.globals;
import 'package:flutter/material.dart';
import 'package:fluttour/router/navigation_observer.dart';

NavigationObserver navigationObserver = NavigationObserver();

ThemeData them = ThemeData(
    fontFamily: "Exo2",
    pageTransitionsTheme: _buildPageTransitionsTheme()
);

/// Custom page transitions theme
PageTransitionsTheme _buildPageTransitionsTheme() {
  return const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}