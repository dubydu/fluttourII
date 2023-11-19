import 'package:flutter/material.dart';
import 'package:fluttour/util/util.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        backgroundColor: AppColor.active,
        padding: const EdgeInsets.only(bottom: 1, left: 15, right: 15),
      ),
      onPressed: onPressed,
      child: AppText.primaryButtonText(
        title,
        color: AppColor.white,
        fontWeight: FontWeightType.bold,
      ),
    );
  }
}
