import 'package:fluttour/data/api/response/fluttour_doctor_response.dart';

class HomeResponsesMock {
  static get fluttourDoctorResponse {
    return FluttourDoctorResponse(
        flutterVersion: 'Channel stable, 3.0.2',
        dartVersion: '2.17.3',
        devToolsVersion: '2.12.2',
        cocoapodsVersion: '1.11.3',
        frameworkRevision: 'f15f824b57'
    );
  }
}