import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttour/util/assets/app_color.dart';

class BaseMaterialPage extends StatelessWidget {
  const BaseMaterialPage({
    required this.child,
    this.backgroundColor = AppColor.white,
    super.key
  });

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _dismiss(unFocus: context);
        },
        child: child,
      ),
    );
  }

  void _dismiss({BuildContext? unFocus}) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (unFocus != null) {
      FocusScope.of(unFocus).unfocus();
    }
  }
}
