import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttour/di/client_module.dart';
import 'package:fluttour/di/config_module.dart';
import 'package:fluttour/di/datasource_module.dart';
import 'package:fluttour/di/repository_module.dart';
import 'package:fluttour/di/usecase_module.dart';
import 'package:fluttour/presentation/home/home_bloc.dart';
import 'package:fluttour/presentation/sliver/sliver_bloc.dart';
import 'package:fluttour/router/gen_route.dart';
import 'package:fluttour/router/navigation_controller.dart';
import 'package:fluttour/util/app_global.dart' as global;
import 'package:fluttour/util/assets/app_locale.dart';

Future<void> myMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(
      EasyLocalization(
        supportedLocales: const [AppLocales.en, AppLocales.zh],
        path: AppLocales.path,
        fallbackLocale: AppLocales.zh,
        child: const MyApp(),
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp>
    with ConfigModule,
        ClientModule,
        DatasourceModule,
        RepositoryModule,
        UseCaseModule {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => HomeBloc(
              useCase: homeUseCase
          )),
          BlocProvider(create: (_) => SliverBloc(
              useCase: sliverUseCase
          ))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          navigatorObservers: [global.navigationObserver],
          theme: global.them,
          onGenerateRoute: generateRoute,
          navigatorKey: NavigationController.globalNavigatorKey,
        )
    );
  }
}