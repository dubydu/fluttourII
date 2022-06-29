import 'package:fluttour/di/repository_module.dart';
import 'package:fluttour/domain/usecase/home/home_usecase.dart';
import 'package:fluttour/domain/usecase/sliver/sliver_usecase.dart';
import 'package:fluttour/domain/usecase/sliver/sliver_usecase_type.dart';

mixin UseCaseModule on RepositoryModule {
  /// HomeUseCase
  HomeUseCase get homeUseCase {
    return HomeUseCase(repository: homeRepository);
  }

  /// SliverUseCase
  SliverUseCaseType get sliverUseCase {
    return SliverUseCase(repository: sliverRepository);
  }
}