import 'package:dio/dio.dart';
import 'package:fluttour/data/api/response/fluttour_doctor_response.dart';
import 'package:retrofit/retrofit.dart' as retrofit;

part 'api_client.g.dart';

@retrofit.RestApi()
abstract class APIClient {
  factory APIClient(Dio dio, {String baseUrl}) = _APIClient;

  @retrofit.GET('/fluttour-doctor')
  Future<FluttourDoctorResponse> getFluttourDoctor();
}
