import 'package:flutter/cupertino.dart';

class AppDevice {
  /// Detect the device that has notch
  static bool isHasNotch({required BuildContext context}) {
    return MediaQuery.of(context).viewPadding.bottom > 0;
  }

  /// Detect the position of specific Widget
  static Offset detectWidgetPosition({required GlobalKey globalKey}) {
    RenderBox box = globalKey.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    return position;
  }
}