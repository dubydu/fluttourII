import 'package:fluttour/environment/environment.dart';

class AppConfig {
  static final AppConfig shared = AppConfig._instance();

  factory AppConfig({required Environment env}) {
    shared.env = env;
    return shared;
  }

  AppConfig._instance();
  Environment? env;

  String get baseDomain {
    return env?.kaguyaBaseDomain ?? '';
  }
}