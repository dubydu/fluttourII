import 'package:fluttour/data/api/response/fluttour_response.dart';
import 'package:fluttour/domain/model/fluttour.dart';

class HomeTranslator {
  /// To Model
  static Fluttour toModel({required FluttourResponse response}) {
    return Fluttour(
        flutterVersion: response.flutterVersion,
        dartVersion: response.dartVersion,
        devToolsVersion: response.devToolsVersion,
        cocoapodsVersion: response.cocoapodsVersion,
    );
  }
}