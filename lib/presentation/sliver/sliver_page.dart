import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/domain/model/dish.dart';
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
    with AfterLayoutMixin, ResponsiveMixin, SingleTickerProviderStateMixin {

  // Sliver bloc
  late SliverBloc _sliverBloc;
  // Scroll controller
  late final ScrollController _scrollController = ScrollController();
  // Global key
  final GlobalKey categoryWidgetKey = GlobalKey();
  // Tab controller
  TabController? _tabController;

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    // Init sliver bloc
    _sliverBloc = BlocProvider.of(context, listen: false);
    // Add scroll listener
    _scrollController.addListener(_scrollControllerObserver);
    // Fetch brand data
    await _sliverBloc.fetchBrand();
    // Init tab controller
    _tabController = TabController(
        length: _sliverBloc.state.categories?.length ?? 0,
        vsync: this
    );
  }

  void _scrollControllerObserver() {
    /// Handle the position of category widget
    double y = AppDevice.detectWidgetPosition(globalKey: categoryWidgetKey).dy;
    _sliverBloc.onCategoryChanged(isOnTop: y <= 10.h);
    /// Handle the position of section widget
    final sectionIndex = _sliverBloc.onSectionChanged(isDeviceHasNotch());
    if (sectionIndex != -1) {
      _tabController?.animateTo(sectionIndex);
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _sliverBloc.dispose();
    super.dispose();
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
                      state: state,
                      onBackPressed: () {
                        pop();
                      },
                      onSearchPressed: () { },
                      onSharePressed: () { }
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
                    builder: (context, state) {
                      return SliverPersistentHeader(
                          pinned: true,
                          delegate: CategoryWidget(
                            state: state,
                            categoryWidgetKey: categoryWidgetKey,
                            isWidgetOnTop: state.isCategoryWidgetOnTop,
                            isDeviceHasNotch: isDeviceHasNotch(),
                            tabController: _tabController,
                            onCategoryPressed: (int index) async {
                              /// Select category
                              _sliverBloc.onCategorySelected(
                                  dishCategory: state.categories![index]
                              );
                              /// Scroll to specific section widget
                              Scrollable.ensureVisible(
                                  state.categoryGlobalKeys![index].currentContext!,
                                  duration: const Duration(microseconds: 100)
                              );
                              /// Move category widget on top
                              Future.delayed(const Duration(milliseconds: 150), () {
                                _sliverBloc.moveCategoryOnTop();
                              });
                            }
                          )
                      );
                    },
                  ),
                  // Dishes list
                  SliverToBoxAdapter(
                      child: SectionWidget(
                          categories: state.categories ?? [],
                          globalKeys: state.categoryGlobalKeys ?? [],
                      )
                  ),
                  // Spacing
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: isDeviceHasNotch() ? 32.h : 16.h,
                    ),
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
  HeaderImageWidget({
    required this.state,
    required this.onBackPressed,
    required this.onSharePressed,
    required this.onSearchPressed
  });

  final SliverState state;
  final VoidCallback onBackPressed;
  final VoidCallback onSharePressed;
  final VoidCallback onSearchPressed;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      width: double.infinity,
      height: 220.h,
      child: Stack(
          children: <Widget>[
            Positioned(
                left: 0, top: 0, right: 0, bottom: 0,
                child: ImageBuilder(state.brand?.image, fit: BoxFit.cover)
            ),
            Positioned(
                left: 16, top: 0, right: 16,
                child: SafeArea(
                  bottom: false,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: onBackPressed,
                        child: AppIcon.iconBack.widget(),
                      ),
                      const Spacer(),
                      InkWell(
                        child: AppIcon.iconShare.widget(),
                      ),
                      SizedBox(width: 16.w),
                      InkWell(
                        child: AppIcon.iconSearch.widget(),
                      ),
                    ],
                  ),
                ),
            ),
          ]
      ),
    );
  }

  @override
  double get maxExtent => 220.h;

  @override
  double get minExtent => 220.h;

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
                            AppText.body(
                                state.brand?.duration ?? '',
                                color: AppColor.black),
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

typedef OnCategoryPressed = Function(int index);

class CategoryWidget extends  SliverPersistentHeaderDelegate {
  const CategoryWidget({
    required this.state,
    required this.categoryWidgetKey,
    required this.isWidgetOnTop,
    required this.isDeviceHasNotch,
    required this.tabController,
    required this.onCategoryPressed
  });

  final SliverState state;
  final GlobalKey categoryWidgetKey;
  final bool isWidgetOnTop;
  final bool isDeviceHasNotch;
  final TabController? tabController;
  final OnCategoryPressed onCategoryPressed;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: AppColor.white.withOpacity(.95),
      elevation: isWidgetOnTop ? 2 : 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        key: categoryWidgetKey,
        padding: EdgeInsets.only(
            top: isDeviceHasNotch
                ? (isWidgetOnTop ? 30.h : 0.h)
                : 15.h),
        alignment: Alignment.centerLeft,
        child: DefaultTabController(
          length: state.categories!.length,
          child: TabBar(
            controller: tabController,
            onTap: onCategoryPressed,
            indicatorColor: AppColor.transparent,
            isScrollable: true,
            tabs: state.categories!.map((category) =>
                AppText.h3(
                    category.name ?? '',
                    color: category.isSelected
                        ? AppColor.active
                        : AppColor.black.withOpacity(.7)
                )
            ).toList()
          ),
        ),
      ),
    );
  }

  double get extentHeight {
    return state.extentHeight(isDeviceHasNotch: isDeviceHasNotch).h;
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
  const SectionWidget({
    Key? key,
    required this.categories,
    required this.globalKeys
  }) : super(key: key);

  final List<DishCategory> categories;
  final List<GlobalKey> globalKeys;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 10.h),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return SliverSectionWidget(
          dishCategory: categories[index],
          globalKey: globalKeys[index]
        );
      },
      separatorBuilder: (_, __) {
        return SizedBox(
          height: 16.h,
        );
      },
      itemCount: categories.length);
  }
}

