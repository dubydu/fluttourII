import 'package:fluttour/domain/model/fluttour_doctor.dart';

abstract class HomeDataSourceType {
  Future<FluttourDoctor> getFluttourDoctor();
}