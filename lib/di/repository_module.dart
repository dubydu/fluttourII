import 'package:fluttour/di/datasource_module.dart';
import 'package:fluttour/repository/home/home_repository.dart';
import 'package:fluttour/repository/home/home_repository_type.dart';
import 'package:fluttour/repository/sliver/sliver_repository.dart';
import 'package:fluttour/repository/sliver/sliver_repository_type.dart';

mixin RepositoryModule on DatasourceModule {
  /// HomeRepository
  HomeRepositoryType get homeRepository {
    return HomeRepository(dataSource: homeDataSource);
  }
  /// SliverRepository
  SliverRepositoryType get sliverRepository {
    return SliverRepository(dataSource: sliverDataSource);
  }
}