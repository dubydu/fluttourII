import 'package:fluttour/data/api/response/fluttour_doctor_response.dart';

abstract class HomeDataSourceType {
  Future<FluttourDoctorResponse> getFluttourDoctor();
}