import 'package:fluttour/domain/model/fluttour_doctor.dart';

class HomeResponsesMock {
  static get fluttourDoctorResponse {
    return const FluttourDoctor(
        flutterVersion: 'Channel stable, 3.0.2',
        dartVersion: '2.17.3',
        devToolsVersion: '2.12.2',
        cocoapodsVersion: '1.11.3');
  }
}