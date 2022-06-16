import 'package:flutter/material.dart';
import 'package:fluttour/util/assets/app_image.dart';
import 'package:fluttour/util/util.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with ResponsiveMixin, AfterLayoutMixin {

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      transitionToHomePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    initResponsive(context);
    return Material(
      color: AppColor.white,
      child: Center(
        child: SizedBox(
          width: 124.w,
          height: 124.w,
          child: AppImage.appYolo.widget(),
        ),
      ),
    );
  }
}
