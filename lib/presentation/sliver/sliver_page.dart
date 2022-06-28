import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/presentation/base/base_material_page.dart';
import 'package:fluttour/presentation/sliver/sliver_bloc.dart';
import 'package:fluttour/presentation/sliver/widget/sliver_section_widget.dart';
import 'package:fluttour/util/assets/app_image.dart';
import 'package:fluttour/util/util.dart';

class SliverPage extends StatefulWidget {
  const SliverPage({Key? key}) : super(key: key);

  @override
  SliverPageState createState() => SliverPageState();
}

class SliverPageState extends State<SliverPage>
    with AfterLayoutMixin, ResponsiveMixin {

  late SliverBloc _sliverBloc;
  late final ScrollController _scrollController = ScrollController();
  final GlobalKey categoryWidgetKey = GlobalKey();

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    _sliverBloc = BlocProvider.of(context, listen: false);
    _scrollController.addListener(_scrollControllerObserver);
    await _sliverBloc.fetchBrand();
  }

  void _scrollControllerObserver() {
    double y = AppDevice.detectWidgetPosition(globalKey: categoryWidgetKey).dy;
    if (y <= 10.h) {
      if (!_sliverBloc.state.isCategoryWidgetOnTop) {
        _sliverBloc.onCategoryWidgetChanged(isOnTop: true);
      }
    } else {
      if (_sliverBloc.state.isCategoryWidgetOnTop) {
        _sliverBloc.onCategoryWidgetChanged(isOnTop: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    initResponsive(context);
    return BaseMaterialPage(
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: BlocBuilder<SliverBloc, SliverState>(
          buildWhen: (current, previous) => (current.brand != previous.brand),
          builder: (context, state) {
            if (state.brand != null) {
              return CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  // Header
                  SliverPersistentHeader(
                    pinned: false,
                    delegate: HeaderImageWidget(
                      state: state
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 0.h,
                    ),
                  ),
                  // Description
                  SliverToBoxAdapter(
                      child: HeaderDescriptionWidget(
                        state: state,
                      )
                  ),
                  // Featured Items
                  const SliverToBoxAdapter(
                      child: FeaturedItemsWidget()
                  ),
                  // Category Tabs
                  BlocBuilder<SliverBloc, SliverState>(
                    buildWhen: (previous, current)
                    => (previous.isCategoryWidgetOnTop != current.isCategoryWidgetOnTop),
                    builder: (context, state) {
                      return SliverPersistentHeader(
                          pinned: true,
                          delegate: CategoryWidget(
                              categoryWidgetKey: categoryWidgetKey,
                              isWidgetOnTop: state.isCategoryWidgetOnTop,
                              isHasNotch: AppDevice.isHasNotch(context: this.context)
                          )
                      );
                    },
                  ),
                  const SliverToBoxAdapter(
                      child: SectionWidget()
                  ),
                ],
              );
            } else {
              return Center(
                child: SizedBox(
                  width: 24.sp,
                  height: 24.sp,
                  child: const CupertinoActivityIndicator(),
                ),
              );
            }
          },
        )
      ),
    );
  }
}

class HeaderImageWidget extends SliverPersistentHeaderDelegate {
  HeaderImageWidget({required this.state});

  final SliverState state;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      width: double.infinity,
      height: 280.h,
      child: ImageBuilder(state.brand?.image, fit: BoxFit.cover),
    );
  }

  @override
  double get maxExtent => 280.h;

  @override
  double get minExtent => 280.h;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class HeaderDescriptionWidget extends StatelessWidget {
  const HeaderDescriptionWidget({Key? key, required this.state}) : super(key: key);

  final SliverState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppText.h3(state.brand?.name ?? ''),
          Container(
            padding: EdgeInsets.only(top: 14.h),
            child: AppText.body(state.brand?.tags?.join('  •  ') ?? ''),
          ),
          Container(
            padding: EdgeInsets.only(top: 14.h),
            child: Row(
              children: <Widget>[
                AppText.body('4.3'),
                SizedBox(width: 10.w),
                AppIcon.iconStar.widget(),
                SizedBox(width: 10.w),
                AppText.body('+200 Ratings'),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppIcon.iconDeliveryPrice.widget(),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AppText.body('Free', color: AppColor.black),
                            SizedBox(height: 4.h),
                            AppText.small('Delivery'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 20.w),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppIcon.iconDeliveryTime.widget(),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AppText.body(state.brand?.duration ?? '', color: AppColor.black),
                            SizedBox(height: 4.h),
                            AppText.small('Minutes'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 38.h,
                    width: 113.w,
                    child: AppPrimaryButton(
                      title: 'TAKE AWAY', onPressed: () {  },
                    ),
                  ),
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}

class FeaturedItemsWidget extends StatelessWidget {
  const FeaturedItemsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 18.h),
          child: AppText.h4('Featured Items'),
        ),
        SizedBox(
          height: 198.h,
          child: ListView.separated(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              scrollDirection: Axis.horizontal,
              itemBuilder: (state, index) {
                return SizedBox(
                  width: 140.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 140.h,
                        decoration: BoxDecoration(
                          color: AppColor.lightGray,
                          borderRadius: BorderRadius.circular(8.sp)
                        ),
                      ),
                      SizedBox(height: 8.h),
                      AppText.itemTitleSmall('Cookie Sandwich', maxLines: 1),
                      SizedBox(height: 4.h),
                      AppText.regular('Chinese')
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) {
                return SizedBox(width: 14.w);
          }, itemCount: 4),
        )
      ],
    );
  }
}

class CategoryWidget extends  SliverPersistentHeaderDelegate {
  const CategoryWidget({
    required this.categoryWidgetKey,
    required this.isWidgetOnTop,
    required this.isHasNotch
  });

  final GlobalKey categoryWidgetKey;
  final bool isWidgetOnTop;
  final bool isHasNotch;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: AppColor.white.withOpacity(.95),
      elevation: isWidgetOnTop ? 2 : 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        key: categoryWidgetKey,
        padding: EdgeInsets.only(top: isHasNotch ? (isWidgetOnTop ? 30.h : 0.h) : 15.h),
        alignment: Alignment.centerLeft,
        child: DefaultTabController(
          length: 4,
          child: TabBar(
            indicatorColor: AppColor.transparent,
            isScrollable: true,
            tabs: [
              AppText.h3('Dim Sum'),
              AppText.h3('Appetizers'),
              AppText.h3('Seafood'),
              AppText.h3('Beef & Lamb')
            ]
          ),
        ),
      ),
    );
  }

  double get extentHeight {
    return isHasNotch ? 90.h : 80.h;
  }

  @override
  double get maxExtent => extentHeight;

  @override
  double get minExtent => extentHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class SectionWidget extends StatelessWidget {
  const SectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 10.h),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return const SliverSectionWidget();
      },
      separatorBuilder: (_, __) {
        return SizedBox(
          height: 16.h,
        );
      },
      itemCount: 3);
  }
}

