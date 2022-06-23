import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/presentation/base/base_material_page.dart';
import 'package:fluttour/presentation/home/home_bloc.dart';
import 'package:fluttour/util/util.dart';
import 'package:fluttour/util/app_global.dart' as global;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with ResponsiveMixin, AfterLayoutMixin, RouteAware {

  late HomeBloc _homeBloc;

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    // Init home bloc
    _homeBloc = BlocProvider.of(context, listen: false);
    // Call fluttour doctor api
    await _getFluttourDoctor();
  }

  Future<void> _getFluttourDoctor() async {
    await _homeBloc.getFluttourDoctor();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe routeAware
    global.navigationObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() async {
    // Call fluttour doctor api
    await _getFluttourDoctor();
    super.didPopNext();
  }

  @override
  void dispose() {
    // Unsubscribe routeAware
    global.navigationObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initResponsive(context);
    return BaseMaterialPage(
      child: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.fluttourDoctor != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppText.h6(
                    LocaleTexts.appName.tr(),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  AppText.body(
                    state.fluttourDoctor?.flutterVersion ?? '',
                    color: AppColor.black,
                    textAlign: TextAlign.center,
                    fontSize: 12,
                  ),
                  SizedBox(height: 32.h),
                  AppPrimaryButton(
                    title: LocaleTexts.next.tr(),
                    onPressed: () {
                      transitionToSliverPage();
                    },
                  )
                ],
              );
            } else {
              return SizedBox(
                width: 24.sp,
                height: 24.sp,
                child: const CupertinoActivityIndicator(),
              );
            }
          },
        ),
      )
    );
  }
}