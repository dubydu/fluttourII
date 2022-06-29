import 'package:fluttour/data/api/response/fluttour_response.dart';

class HomeResponsesMock {
  static get fluttourResponse {
    return FluttourResponse(
        flutterVersion: 'Channel stable, 3.0.2',
        dartVersion: '2.17.3',
        devToolsVersion: '2.12.2',
        cocoapodsVersion: '1.11.3',
        frameworkRevision: 'f15f824b57'
    );
  }
}