import 'package:fluttour/config/app_config.dart';
import 'package:fluttour/config/app_config_type.dart';
import 'package:fluttour/config/app_secure_config.dart';
import 'package:fluttour/config/app_secure_config_type.dart';

mixin ConfigModule {
  /// App config
  AppConfigType get appConfig {
    return AppConfig.shared;
  }
  /// App Secure config
  AppSecureConfigType get appSecureConfig {
    return AppSecureConfig();
  }
}