import 'package:fluttour/data/api/api_client/api_client_type.dart';
import 'package:fluttour/domain/model/fluttour_doctor.dart';
import 'package:fluttour/domain/translator/home_translator.dart';
import 'home_datasource_type.dart';

class HomeDataSource extends APIClientType implements HomeDataSourceType {
  HomeDataSource({required super.baseDomain});

  @override
  Future<FluttourDoctor> getFluttourDoctor() async {
    final response = await apiClient.getFluttourDoctor();
    return HomeTranslator.toModel(response: response);
  }
}