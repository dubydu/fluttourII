// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fluttour_doctor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FluttourDoctorResponse _$FluttourDoctorResponseFromJson(
        Map<String, dynamic> json) =>
    FluttourDoctorResponse(
      flutterVersion: json['flutterVersion'] as String?,
      dartVersion: json['dartVersion'] as String?,
      devToolsVersion: json['devToolsVersion'] as String?,
      cocoapodsVersion: json['cocoapodsVersion'] as String?,
      frameworkRevision: json['frameworkRevision'] as String?,
    );

Map<String, dynamic> _$FluttourDoctorResponseToJson(
        FluttourDoctorResponse instance) =>
    <String, dynamic>{
      'flutterVersion': instance.flutterVersion,
      'dartVersion': instance.dartVersion,
      'devToolsVersion': instance.devToolsVersion,
      'cocoapodsVersion': instance.cocoapodsVersion,
      'frameworkRevision': instance.frameworkRevision,
    };
