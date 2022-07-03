import 'package:flutter/widgets.dart';
import 'app_image.dart';

abstract class AppIcon {
  AppIcon._();

  static const String _assetPath = "assets/icons/";

  static AppImageBuilder get iconStar =>
      AppImageBuilder('${_assetPath}ic_star.svg');

  static AppImageBuilder get iconDeliveryTime =>
      AppImageBuilder('${_assetPath}ic_delivery_time.svg');

  static AppImageBuilder get iconDeliveryPrice =>
      AppImageBuilder('${_assetPath}ic_delivery_price.svg');

  static AppImageBuilder get iconBack =>
      AppImageBuilder('${_assetPath}ic_back.svg');

  static AppImageBuilder get iconShare =>
      AppImageBuilder('${_assetPath}ic_share.svg');

  static AppImageBuilder get iconSearch =>
      AppImageBuilder('${_assetPath}ic_search.svg');
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