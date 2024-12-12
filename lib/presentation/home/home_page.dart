import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/presentation/base/base_material_page.dart';
import 'package:fluttour/presentation/home/home_bloc.dart';
import 'package:fluttour/util/util.dart';
import 'package:fluttour/util/app_global.dart' as global;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin, RouteAware {
  /// HomeBloc
  late HomeBloc _homeBloc;

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    // Init home bloc
    _homeBloc = BlocProvider.of(context, listen: false);
    // Call fluttour doctor api
    await _getFluttourDoctor();
  }

  /// Fetch flutter version information
  Future<void> _getFluttourDoctor() async {
    await _homeBloc.getFluttourDoctor();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe routeAware
    final ModalRoute<dynamic>? modalRoute = ModalRoute.of(context);
    if (modalRoute != null) {
      global.navigationObserver.subscribe(this, modalRoute);
    }
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
    return BaseMaterialPage(
      child: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.fluttour != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: <Widget>[
                  AppText.h6(
                    LocaleTexts.appName.tr(),
                    textAlign: TextAlign.center,
                  ),
                  AppText.body(
                    state.fluttour?.flutterVersion ?? '',
                    color: AppColor.black,
                    textAlign: TextAlign.center,
                    fontSize: 12,
                  ),
                  const SizedBox(height: 32),
                  /*
                  AppPrimaryButton(
                    title: LocaleTexts.next.tr().toUpperCase(),
                    onPressed: () {
                      transitionToSliverPage();
                    },
                  )
                   */
                ],
              );
            } else {
              return const SizedBox(
                width: 24,
                height: 24,
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
