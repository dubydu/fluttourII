// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fluttour_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FluttourResponse _$FluttourResponseFromJson(Map<String, dynamic> json) =>
    FluttourResponse(
      flutterVersion: json['flutterVersion'] as String?,
      dartVersion: json['dartVersion'] as String?,
      devToolsVersion: json['devToolsVersion'] as String?,
      cocoapodsVersion: json['cocoapodsVersion'] as String?,
      frameworkRevision: json['frameworkRevision'] as String?,
    );

Map<String, dynamic> _$FluttourResponseToJson(FluttourResponse instance) =>
    <String, dynamic>{
      'flutterVersion': instance.flutterVersion,
      'dartVersion': instance.dartVersion,
      'devToolsVersion': instance.devToolsVersion,
      'cocoapodsVersion': instance.cocoapodsVersion,
      'frameworkRevision': instance.frameworkRevision,
    };
