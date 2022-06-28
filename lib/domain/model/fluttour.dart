import 'package:equatable/equatable.dart';

class Fluttour extends Equatable {
  const Fluttour({
    required this.flutterVersion,
    required this.dartVersion,
    required this.devToolsVersion,
    required this.cocoapodsVersion
  });
  final String? flutterVersion;
  final String? dartVersion;
  final String? devToolsVersion;
  final String? cocoapodsVersion;

  @override
  List<Object?> get props => [
    flutterVersion,
    dartVersion,
    devToolsVersion,
    cocoapodsVersion
  ];

  Map<String, dynamic> toJson() => {
    "flutterVersion": flutterVersion,
    "dartVersion": dartVersion,
    "devToolsVersion": devToolsVersion,
    "cocoapodsVersion": cocoapodsVersion,
  };
}
