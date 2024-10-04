import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'navigation_tab.dart';

/// MARK: - NavigationController
class NavigationController extends StatelessWidget {
  const NavigationController({
    Key? key,
    required this.navigationShell,
    required this.state,
  }) : super(key: key ?? const ValueKey<String>('NavigationController'));
  final StatefulNavigationShell navigationShell;
  final GoRouterState state;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryNavigationBar(
      body: navigationShell,
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: _goBranch,
    );
  }
}

/// MARK: - PrimaryNavigationBar
class PrimaryNavigationBar extends StatelessWidget {
  const PrimaryNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: NavigationTab.values.map((tab) {
          return NavigationDestination(
            label: tab.item.$1,
            icon: tab.item.$2,
          );
        }).toList(),
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}
