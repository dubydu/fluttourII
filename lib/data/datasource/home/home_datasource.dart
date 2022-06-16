import 'package:fluttour/data/api/api_client/api_client_type.dart';
import 'package:fluttour/data/api/response/fluttour_doctor_response.dart';
import 'home_datasource_type.dart';

class HomeDataSource extends APIClientType implements HomeDataSourceType {
  HomeDataSource({required super.baseDomain});

  @override
  Future<FluttourDoctorResponse> getFluttourDoctor() async {
    return await apiClient.getFluttourDoctor();
  }
}