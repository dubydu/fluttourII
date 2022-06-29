import 'package:fluttour/data/api/response/fluttour_response.dart';

abstract class HomeDataSourceType {
  Future<FluttourResponse> getFluttourDoctor();
}