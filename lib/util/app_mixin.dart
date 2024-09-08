import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    beforeFirstLayout(context);
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => afterFirstLayout(context));
  }

  Future<void> afterFirstLayout(BuildContext context);

  Future<void> beforeFirstLayout(BuildContext context) async {}
}

mixin ConnectivityMixin {
  final connectivity = Connectivity();
  Future<bool> isInConnection() async {
    var connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.ethernet) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile);
  }
}
