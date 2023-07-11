import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin ResponsiveMixin {
  void initResponsive(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
  }
}

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => afterFirstLayout(context));
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
