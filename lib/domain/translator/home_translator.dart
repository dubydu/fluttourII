import 'package:fluttour/data/api/response/fluttour_doctor_response.dart';
import 'package:fluttour/domain/model/fluttour_doctor.dart';

class HomeTranslator {
  /// To Model
  static FluttourDoctor toModel({required FluttourDoctorResponse response}) {
    return FluttourDoctor(
        flutterVersion: response.flutterVersion,
        dartVersion: response.dartVersion,
        devToolsVersion: response.devToolsVersion,
        cocoapodsVersion: response.cocoapodsVersion,
    );
  }
}