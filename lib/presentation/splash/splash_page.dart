import 'package:flutter/material.dart';
import 'package:fluttour/util/assets/app_image.dart';
import 'package:fluttour/util/util.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AfterLayoutMixin {
  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      transitionToHomePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white,
      child: Center(
        child: SizedBox(
          width: 124,
          height: 124,
          child: AppImage.appYolo.widget(),
        ),
      ),
    );
  }
}
