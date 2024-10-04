import 'package:flutter/material.dart';
import 'package:fluttour/presentation/detail/detail_page.dart';
import 'package:fluttour/presentation/home/home_page.dart';
import 'package:fluttour/presentation/settings/settings_page.dart';
import 'package:fluttour/presentation/sliver/sliver_page.dart';
import 'package:fluttour/router/routes.dart';
import 'package:go_router/go_router.dart';

/// MARK: - NavigationTabs
enum NavigationTab {
  home,
  detail,
  settings;
}

extension NavigationTabsExtension on NavigationTab {
  String get rootRoute {
    return switch (this) {
      NavigationTab.home => '/root-home',
      NavigationTab.detail => '/root-detail',
      NavigationTab.settings => '/root-settings',
    };
  }

  (String, Widget) get item {
    return switch (this) {
      NavigationTab.home => ('Home', const Icon(Icons.home)),
      NavigationTab.detail => ('Detail', const Icon(Icons.insights)),
      NavigationTab.settings => ('Settings', const Icon(Icons.settings)),
    };
  }

  GlobalKey<NavigatorState> get key {
    return switch (this) {
      NavigationTab.home => GlobalKey<NavigatorState>(debugLabel: rootRoute),
      NavigationTab.detail => GlobalKey<NavigatorState>(debugLabel: rootRoute),
      NavigationTab.settings =>
        GlobalKey<NavigatorState>(debugLabel: rootRoute),
    };
  }

  StatefulShellBranch get branch {
    switch (this) {
      case NavigationTab.home:
        return StatefulShellBranch(
          navigatorKey: key,
          routes: <RouteBase>[
            GoRoute(
              path: rootRoute,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomePage(),
              ),
              routes: <RouteBase>[
                GoRoute(
                  path: Routes.sliver.subRouteName,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: SliverPage(),
                  ),
                ),
              ],
            ),
          ],
        );
      case NavigationTab.detail:
        return StatefulShellBranch(
          navigatorKey: key,
          routes: <RouteBase>[
            GoRoute(
              path: rootRoute,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: DetailPage(),
              ),
              routes: const <RouteBase>[],
            ),
          ],
        );
      case NavigationTab.settings:
        return StatefulShellBranch(
          navigatorKey: key,
          routes: <RouteBase>[
            GoRoute(
              path: rootRoute,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SettingsPage(),
              ),
              routes: const <RouteBase>[],
            ),
          ],
        );
    }
  }
}
