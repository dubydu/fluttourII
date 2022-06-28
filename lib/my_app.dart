import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttour/di/service%20_locator.dart';
import 'package:fluttour/domain/usecase/home/home_usecase.dart';
import 'package:fluttour/presentation/home/home_bloc.dart';
import 'package:fluttour/presentation/sliver/sliver_bloc.dart';
import 'package:fluttour/router/gen_route.dart';
import 'package:fluttour/router/navigation_controller.dart';
import 'package:fluttour/util/app_global.dart' as global;
import 'package:fluttour/util/assets/app_locale.dart';
import 'package:get_it/get_it.dart';

Future<void> myMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await ServiceLocator.ensureServiceLocator();

  runApp(
      EasyLocalization(
        supportedLocales: const [AppLocales.en, AppLocales.zh],
        path: AppLocales.path,
        fallbackLocale: AppLocales.zh,
        child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => HomeBloc(
                useCase: GetIt.I<HomeUseCase>()
              )),
              BlocProvider(create: (_) => SliverBloc(

              ))
            ],
            child: const MyApp()),
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      navigatorObservers: [global.navigationObserver],
      theme: global.them,
      onGenerateRoute: generateRoute,
      navigatorKey: NavigationController.globalNavigatorKey,
    );
  }
}