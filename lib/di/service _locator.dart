import 'package:fluttour/config/app_config.dart';
import 'package:fluttour/data/datasource/home/home_datasource.dart';
import 'package:fluttour/data/repository/home/home_repository.dart';
import 'package:fluttour/domain/usecase/home/home_usecase.dart';
import 'package:get_it/get_it.dart';

GetIt get = GetIt.instance;

class ServiceLocator {

  static Future<void> ensureServiceLocator() async {
    final baseDomain = AppConfig.shared.baseDomain;

    /// Use case
    get.registerFactory(() => HomeUseCase(repository: get()));
    
    /// Repository
    get.registerFactory(() => HomeRepository(dataSource: get()));
    
    /// Data source
    get.registerFactory(() => HomeDataSource(baseDomain: baseDomain));
  }
}