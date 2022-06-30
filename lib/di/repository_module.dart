import 'package:fluttour/data/repository/home/home_repository.dart';
import 'package:fluttour/data/repository/home/home_repository_type.dart';
import 'package:fluttour/data/repository/sliver/sliver_repository.dart';
import 'package:fluttour/data/repository/sliver/sliver_repository_type.dart';
import 'package:fluttour/di/datasource_module.dart';

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