import 'package:fluttour/environment/environment.dart';

extension ProductionEnvironment on Environment {
  static Environment production() {
    return Environment(
        kaguyaBaseDomain: 'https://62a97c86ec36bf40bdb82e70.mockapi.io/api',
        graphqlEndPoint: 'https://api-ap-northeast-1.hygraph.com/v2/ckpphjwhcz1bo01xsbdkx7rjx/master'
    );
  }
}