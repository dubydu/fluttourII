import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/presentation/home/home_bloc.dart';
import 'package:fluttour/util/util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with ResponsiveMixin, AfterLayoutMixin {

  late HomeBloc _homeBloc;

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    _homeBloc = BlocProvider.of(context, listen: false);
    await _homeBloc.getFluttourDoctor();
  }

  @override
  Widget build(BuildContext context) {
    initResponsive(context);
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.fluttourDoctor != null) {
              return Center(
                child: SizedBox(
                  height: 100.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AppText.h6(
                        LocaleTexts.appName.tr(),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      AppText.bodyMedium(
                        state.fluttourDoctor?.flutterVersion ?? '',
                        color: AppColor.black,
                        textAlign: TextAlign.center,
                        fontSize: 12,
                      )
                    ],
                  ),
                ),
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