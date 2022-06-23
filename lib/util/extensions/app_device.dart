import 'package:flutter/cupertino.dart';

class AppDevice {
  static bool isHasNotch({required BuildContext context}) {
    return MediaQuery.of(context).viewPadding.bottom > 0;
  }
}