import 'package:flutter/widgets.dart';
import 'app_image.dart';

abstract class AppIcon {
  AppIcon._();

  static const String _assetPath = "assets/icons/";

  static AppIconBuilder get iconStar =>
      AppIconBuilder('${_assetPath}ic_star.svg');

  static AppIconBuilder get iconDeliveryTime =>
      AppIconBuilder('${_assetPath}ic_delivery_time.svg');

  static AppIconBuilder get iconDeliveryPrice =>
      AppIconBuilder('${_assetPath}ic_delivery_price.svg');

  static AppIconBuilder get iconBack =>
      AppIconBuilder('${_assetPath}ic_back.svg');

  static AppIconBuilder get iconShare =>
      AppIconBuilder('${_assetPath}ic_share.svg');

  static AppIconBuilder get iconSearch =>
      AppIconBuilder('${_assetPath}ic_search.svg');
}

class AppIconBuilder {
  final String assetPath;

  AppIconBuilder(this.assetPath);

  Widget widget({
    Key? key,
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
    int? memCacheHeight,
  }) {
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
