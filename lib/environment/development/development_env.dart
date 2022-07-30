import 'package:fluttour/environment/environment.dart';

extension DevelopmentEnvironment on Environment {
  static Environment development() {
    return Environment(
        kaguyaBaseDomain: 'https://62a97b663b3143855433e19d.mockapi.io/api/dev',
        graphqlEndPoint: 'https://api-ap-northeast-1.hygraph.com/v2/ckpphjwhcz1bo01xsbdkx7rjx/master'
    );
  }
}