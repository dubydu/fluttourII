import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:connectivity/connectivity.dart';

mixin ResponsiveMixin {
  void initResponsive(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
  }
}

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding
        .instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }
  Future<void> afterFirstLayout(BuildContext context);
}

mixin ConnectivityMixin {
  final connectivity = Connectivity();
  Future<bool> isInConnection() async {
    var connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
