import 'package:fluttour/data/datasource/home/home_datasource.dart';
import 'package:fluttour/data/datasource/home/home_datasource_type.dart';
import 'package:fluttour/data/datasource/sliver/sliver_datasource.dart';
import 'package:fluttour/data/datasource/sliver/sliver_datasource_type.dart';
import 'package:fluttour/di/client_module.dart';

mixin DatasourceModule on ClientModule {
  /// HomeDataSource
  HomeDataSourceType get homeDataSource {
    return HomeDataSource(
        graphqlClient: graphqlClient
    );
  }
  /// SliverDataSource
  SliverDataSourceType get sliverDataSource {
    return SliverDataSource(apiClient: apiClient);
  }
}