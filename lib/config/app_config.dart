import 'package:fluttour/config/app_config_type.dart';
import 'package:fluttour/environment/environment.dart';

class AppConfig with AppConfigType {
  static final AppConfig shared = AppConfig._instance();

  factory AppConfig({required Environment env}) {
    shared.env = env;
    return shared;
  }

  AppConfig._instance();
  Environment? env;

  @override
  String get baseDomain => env?.kaguyaBaseDomain ?? '';

  @override
  String get graphqlEndPoint => env?.graphqlEndPoint ?? '';
}