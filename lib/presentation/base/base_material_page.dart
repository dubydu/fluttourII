import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttour/util/assets/app_color.dart';

class BaseMaterialPage extends StatelessWidget {
  const BaseMaterialPage({
    required this.child,
    this.backgroundColor = AppColor.white,
    Key? key
  }) : super(key: key);

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _dismiss(unfocus: context);
        },
        child: child,
      ),
    );
  }

  void _dismiss({BuildContext? unfocus}) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (unfocus != null) {
      FocusScope.of(unfocus).unfocus();
    }
  }
}
