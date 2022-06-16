import 'package:json_annotation/json_annotation.dart';
part 'fluttour_doctor_response.g.dart';

@JsonSerializable(explicitToJson: true)
class FluttourDoctorResponse {
  FluttourDoctorResponse({
    this.flutterVersion,
    this.dartVersion,
    this.devToolsVersion,
    this.cocoapodsVersion,
    this.frameworkRevision,
  });

  final String? flutterVersion;
  final String? dartVersion;
  final String? devToolsVersion;
  final String? cocoapodsVersion;
  final String? frameworkRevision;

  factory FluttourDoctorResponse.fromJson(Map<String, dynamic> json) =>
      _$FluttourDoctorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FluttourDoctorResponseToJson(this);
}