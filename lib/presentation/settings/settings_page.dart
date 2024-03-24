import 'package:flutter/material.dart';
import 'package:fluttour/router/navigation_tab.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(NavigationTab.settings.item.$1),
        elevation: 1,
      ),
      body: Container(),
    );
  }
}
