import 'development/development_env.dart';
import 'production/production_env.dart';

class Environment {
  /// Prod environment
  factory Environment.production() {
    return ProductionEnvironment.production();
  }

  /// Dev environment
  factory Environment.development() {
    return DevelopmentEnvironment.development();
  }

  Environment({
    required this.kaguyaBaseDomain
  });

  final String kaguyaBaseDomain;
}