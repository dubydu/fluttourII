import 'package:flutter/material.dart';
import 'package:fluttour/util/util.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
          backgroundColor: AppColor.active,
          padding: EdgeInsets.only(bottom: 1.h, left: 15.w, right: 15.w)),
      onPressed: onPressed,
      child: AppText.primaryButtonText(
        title,
        color: AppColor.white,
        fontWeight: FontWeightType.bold,
      ),
    );
  }
}
