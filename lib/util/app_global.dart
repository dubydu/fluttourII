import 'package:flutter/material.dart';

RouteObserver<ModalRoute<void>> navigationObserver =
    RouteObserver<ModalRoute<void>>();

ThemeData theme = ThemeData(
  fontFamily: "Exo2",
  pageTransitionsTheme: _buildPageTransitionsTheme(),
  useMaterial3: true,
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
