import 'package:flutter/material.dart';
import 'package:fluttour/router/navigation_tab.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(NavigationTab.detail.item.$1),
        elevation: 1,
      ),
      body: Container(),
    );
  }
}
