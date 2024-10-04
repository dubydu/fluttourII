import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/di/client_module.dart';
import 'package:fluttour/di/config_module.dart';
import 'package:fluttour/di/datasource_module.dart';
import 'package:fluttour/di/repository_module.dart';
import 'package:fluttour/di/usecase_module.dart';
import 'package:fluttour/presentation/home/home_bloc.dart';
import 'package:fluttour/presentation/sliver/sliver_bloc.dart';
import 'package:fluttour/router/gen_route.dart';
import 'package:fluttour/util/app_global.dart' as global;
import 'package:fluttour/util/app_observer.dart';
import 'package:fluttour/util/assets/app_locale.dart';

Future<void> myMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppObserver();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: const [AppLocales.en, AppLocales.zh],
    path: AppLocales.path,
    fallbackLocale: AppLocales.en,
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp>
    with
        ConfigModule,
        ClientModule,
        DatasourceModule,
        RepositoryModule,
        UseCaseModule {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc(useCase: homeUseCase)),
        BlocProvider(create: (_) => SliverBloc(useCase: sliverUseCase))
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: global.theme,
        routerConfig: generateRoute,
      ),
    );
  }
}
