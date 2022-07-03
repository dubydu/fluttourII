import 'package:flutter/material.dart';
import 'package:fluttour/domain/model/dish.dart';
import 'package:fluttour/util/assets/app_image.dart';
import 'package:fluttour/util/util.dart';

class SliverSectionWidget extends StatelessWidget {
  const SliverSectionWidget({
    Key? key,
    required this.dishCategory,
    required this.globalKey
  }) : super(key: key);

  final DishCategory dishCategory;
  final GlobalKey globalKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: globalKey,
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 9, bottom: 9.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppText.h4(dishCategory.name ?? ''),
          SizedBox(height: 24.h),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 110.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: AppColor.lightGray,
                            borderRadius: BorderRadius.circular(8.sp)
                        ),
                        width: 110.h,
                        child: ImageBuilder(dishCategory.dishes![index].image),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: 18.w, top: 2.h, bottom: 4.h),
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AppText.itemTitleLarge(dishCategory.dishes![index].name!, maxLines: 1),
                                  SizedBox(height: 4.h),
                                  AppText.body(dishCategory.dishes![index].description!, maxLines: 2),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  AppText.regular(dishCategory.dishes![index].category!, color: AppColor.black),
                                  AppText.regular(dishCategory.dishes![index].price!, color: AppColor.active, fontWeight: FontWeightType.semiBold)
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) {
              return Container(
                margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
                height: 1,
                color: AppColor.lightGray,
              );
            },
            itemCount: dishCategory.dishes?.length ?? 0)
        ],
      ),
    );
  }
}
