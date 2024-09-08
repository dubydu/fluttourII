import 'package:json_annotation/json_annotation.dart';
part 'fluttour_response.g.dart';

@JsonSerializable(explicitToJson: true)
class FluttourResponse {
  FluttourResponse({
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

  factory FluttourResponse.fromJson(Map<String, dynamic> json) =>
      _$FluttourResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FluttourResponseToJson(this);
}