import 'dart:ui';
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
  const SliverPage({super.key});

  @override
  SliverPageState createState() => SliverPageState();
}

class SliverPageState extends State<SliverPage>
    with AfterLayoutMixin, SingleTickerProviderStateMixin {
  /// Sliver bloc
  late SliverBloc _sliverBloc;

  /// Scroll controller
  final ScrollController _scrollController = ScrollController();

  /// Global key
  final GlobalKey _categoryWidgetKey = GlobalKey();

  /// Tab controller
  late TabController _tabController;

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    // Init sliver bloc
    _sliverBloc = BlocProvider.of(context, listen: false);
    // Add scroll listener
    _scrollController.addListener(_scrollControllerObserver);
    // Fetch brand data
    Future.delayed(const Duration(milliseconds: 300), () async {
      await _sliverBloc.fetchBrand();
      // Init tab controller
      _tabController = TabController(
          length: _sliverBloc.state.categories?.length ?? 0, vsync: this);
    });
  }

  void _scrollControllerObserver() {
    /// Handle the position of category widget
    double y = AppDevice.detectWidgetPosition(globalKey: _categoryWidgetKey).dy;
    _sliverBloc.onCategoryChanged(isOnTop: y <= 10);

    /// Handle the position of section widget
    final sectionIndex = _sliverBloc.onSectionChanged(isDeviceHasNotch());
    if (sectionIndex != -1) {
      _tabController.animateTo(sectionIndex);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _sliverBloc.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseMaterialPage(
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: isDeviceHasNotch()
            ? _buildBodyWidget()
            : SafeArea(child: _buildBodyWidget()),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<SliverBloc, SliverState>(
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
                    onSearchPressed: () {},
                    onSharePressed: () {},
                    isDeviceHasNotch: isDeviceHasNotch()),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 0,
                ),
              ),
              // Description
              SliverToBoxAdapter(
                  child: HeaderDescriptionWidget(
                state: state,
              )),
              // Featured Items
              SliverToBoxAdapter(
                  child: FeaturedItemsWidget(
                dishes: state.recommendDishes ?? [],
              )),
              // Category Tabs
              BlocBuilder<SliverBloc, SliverState>(
                builder: (context, state) {
                  return SliverPersistentHeader(
                    pinned: true,
                    delegate: CategoryWidget(
                      state: state,
                      categoryWidgetKey: _categoryWidgetKey,
                      isWidgetOnTop: state.isCategoryWidgetOnTop,
                      isDeviceHasNotch: isDeviceHasNotch(),
                      tabController: _tabController,
                      onCategoryPressed: (int index) async {
                        /// Select category
                        _sliverBloc.onCategorySelected(
                            dishCategory: state.categories![index]);

                        /// Scroll to specific section widget
                        Scrollable.ensureVisible(
                            state.categoryGlobalKeys![index].currentContext!,
                            duration: const Duration(microseconds: 100));

                        /// Move category widget on top
                        Future.delayed(const Duration(milliseconds: 150), () {
                          _sliverBloc.moveCategoryOnTop();
                        });
                      },
                    ),
                  );
                },
              ),
              // Dishes list
              SliverToBoxAdapter(
                  child: SectionWidget(
                categories: state.categories ?? [],
                globalKeys: state.categoryGlobalKeys ?? [],
              )),
              // Spacing
              SliverToBoxAdapter(
                child: SizedBox(
                  height: isDeviceHasNotch() ? 32 : 16,
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CupertinoActivityIndicator(),
            ),
          );
        }
      },
    );
  }
}

/// MARK: - The header image widget
class HeaderImageWidget extends SliverPersistentHeaderDelegate {
  HeaderImageWidget({
    required this.state,
    required this.onBackPressed,
    required this.onSharePressed,
    required this.onSearchPressed,
    required this.isDeviceHasNotch,
  });

  final SliverState state;
  final VoidCallback onBackPressed;
  final VoidCallback onSharePressed;
  final VoidCallback onSearchPressed;
  final bool isDeviceHasNotch;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      width: double.infinity,
      height: 220,
      child: Stack(children: <Widget>[
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: ImageBuilder(state.brand?.image, fit: BoxFit.cover),
        ),
        Positioned(
          left: 16,
          top: isDeviceHasNotch ? 0 : 16,
          right: 16,
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
                const SizedBox(width: 16),
                InkWell(
                  child: AppIcon.iconSearch.widget(),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  @override
  double get maxExtent => 220;

  @override
  double get minExtent => 220;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

/// MARK: - The header description widget
class HeaderDescriptionWidget extends StatelessWidget {
  const HeaderDescriptionWidget({super.key, required this.state});

  final SliverState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppText.h3(state.brand?.name ?? ''),
          Container(
            padding: const EdgeInsets.only(top: 14),
            child: AppText.body(state.brand?.tags?.join('  •  ') ?? ''),
          ),
          Container(
            padding: const EdgeInsets.only(top: 14),
            child: Row(
              children: <Widget>[
                AppText.body('4.3'),
                const SizedBox(width: 10),
                AppIcon.iconStar.widget(),
                const SizedBox(width: 10),
                AppText.body('+200 Ratings'),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppIcon.iconDeliveryPrice.widget(),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AppText.body('Free', color: AppColor.black),
                            const SizedBox(height: 4),
                            AppText.small('Delivery'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppIcon.iconDeliveryTime.widget(),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AppText.body(state.brand?.duration ?? '',
                                color: AppColor.black),
                            const SizedBox(height: 4),
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
                    height: 38,
                    child: AppPrimaryButton(
                      title: 'TAKE AWAY',
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// MARK: - The featured items widget
class FeaturedItemsWidget extends StatelessWidget {
  const FeaturedItemsWidget({super.key, required this.dishes});

  final List<Dish> dishes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 18),
          child: AppText.h4('Featured Items'),
        ),
        SizedBox(
          height: 200,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 16, right: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (state, index) {
              return SizedBox(
                width: 140,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: AppColor.lightGray, width: .6),
                        ),
                        child: ImageBuilder(dishes[index].image,
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppText.itemTitleSmall(dishes[index].name ?? '',
                        maxLines: 1),
                    const SizedBox(height: 4),
                    AppText.currency('${dishes[index].price!}¥')
                  ],
                ),
              );
            },
            separatorBuilder: (_, __) {
              return const SizedBox(width: 14);
            },
            itemCount: dishes.length,
          ),
        )
      ],
    );
  }
}

/// Returns a product index if any items were pressed
typedef OnCategoryPressed = Function(int index);

/// MARK: - The product category widget
class CategoryWidget extends SliverPersistentHeaderDelegate {
  const CategoryWidget({
    required this.state,
    required this.categoryWidgetKey,
    required this.isWidgetOnTop,
    required this.isDeviceHasNotch,
    required this.tabController,
    required this.onCategoryPressed,
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
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          key: categoryWidgetKey,
          padding: EdgeInsets.only(
              top: isDeviceHasNotch ? (isWidgetOnTop ? 30 : 0) : 15),
          alignment: Alignment.centerLeft,
          child: DefaultTabController(
            length: state.categories!.length,
            child: TabBar(
              splashBorderRadius: BorderRadius.circular(16),
              controller: tabController,
              onTap: onCategoryPressed,
              indicatorColor: AppColor.transparent,
              indicatorWeight: .1,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.only(left: 16),
              indicatorPadding: EdgeInsets.zero,
              dividerColor: AppColor.transparent,
              automaticIndicatorColorAdjustment: false,
              tabAlignment: TabAlignment.start,
              tabs: state.categories!
                  .map(
                    (category) => AppText.h3(
                      category.name ?? '',
                      textAlign: TextAlign.left,
                      color: category.isSelected
                          ? AppColor.active
                          : AppColor.black.withOpacity(.7),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  double get extentHeight {
    return state.extentHeight(isDeviceHasNotch: isDeviceHasNotch);
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

/// MARK: - Section Widget
class SectionWidget extends StatelessWidget {
  const SectionWidget({
    super.key,
    required this.categories,
    required this.globalKeys,
  });

  final List<DishCategory> categories;
  final List<GlobalKey> globalKeys;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.only(top: 10),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return SliverSectionWidget(
              dishCategory: categories[index], globalKey: globalKeys[index]);
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            height: 16,
          );
        },
        itemCount: categories.length);
  }
}
