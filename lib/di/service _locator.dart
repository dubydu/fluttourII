import 'package:fluttour/config/app_config.dart';
import 'package:fluttour/data/datasource/home/home_datasource.dart';
import 'package:fluttour/data/datasource/sliver/sliver_datasource.dart';
import 'package:fluttour/data/repository/home/home_repository.dart';
import 'package:fluttour/data/repository/sliver/sliver_repository.dart';
import 'package:fluttour/domain/usecase/home/home_usecase.dart';
import 'package:fluttour/domain/usecase/sliver/sliver_usecase.dart';
import 'package:get_it/get_it.dart';

GetIt get = GetIt.instance;

class ServiceLocator {

  static Future<void> ensureServiceLocator() async {
    final baseDomain = AppConfig.shared.baseDomain;

    /// Use case
    get.registerFactory(() => HomeUseCase(repository: get()));
    get.registerFactory(() => SliverUseCase(repository: get()));
    
    /// Repository
    get.registerFactory(() => HomeRepository(dataSource: get()));
    get.registerFactory(() => SliverRepository(dataSource: get()));
    
    /// Data source
    get.registerFactory(() => HomeDataSource(baseDomain: baseDomain));
    get.registerFactory(() => SliverDataSource(baseDomain: baseDomain));
  }
}