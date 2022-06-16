import 'package:flutter/widgets.dart';
import 'app_image.dart';

abstract class AppIcon {
  AppIcon._();

  static const String _assetPath = "assets/icons/";

  static AppImageBuilder get iconBurgerMenu =>
      AppImageBuilder('${_assetPath}ic_burger_menu.svg');
}

class AppImageBuilder {
  final String assetPath;

  AppImageBuilder(this.assetPath);

  Widget widget(
      {Key? key,
        bool matchTextDirection = false,
        AssetBundle? bundle,
        String? package,
        double? width,
        double? height,
        BoxFit fit = BoxFit.contain,
        Alignment alignment = Alignment.center,
        Color? color,
        BorderRadius? borderRadius,
        Widget? placeholder,
        String? errorImageUrl,
        int? memCacheHeight}) {
    return ImageBuilder(
      assetPath,
      key: key,
      width: width,
      height: height,
      fit: fit,
      color: color,
      alignment: alignment,
      placeholder: placeholder,
      errorImageUrl: errorImageUrl,
      memCacheHeight: memCacheHeight,
    );
  }
}