import 'package:flutter/material.dart';
import 'package:fluttour/domain/model/dish.dart';
import 'package:fluttour/util/assets/app_image.dart';
import 'package:fluttour/util/util.dart';

class SliverSectionWidget extends StatelessWidget {
  const SliverSectionWidget({
    super.key,
    required this.dishCategory,
    required this.globalKey,
  });

  final DishCategory dishCategory;
  final GlobalKey globalKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: globalKey,
      padding: const EdgeInsets.symmetric(
        vertical: 9,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppText.h4(dishCategory.name ?? ''),
          const SizedBox(height: 24),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppColor.lightGray, width: .6)),
                        alignment: Alignment.center,
                        width: 110,
                        height: 110,
                        child: ImageBuilder(dishCategory.dishes![index].image,
                            fit: BoxFit.fitWidth)),
                    Flexible(
                      child: Container(
                        margin:
                            const EdgeInsets.only(left: 18, top: 2, bottom: 4),
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AppText.itemTitleLarge(
                                    dishCategory.dishes![index].name!,
                                    maxLines: 1),
                                const SizedBox(height: 4),
                                AppText.body(
                                    dishCategory.dishes![index].description!,
                                    maxLines: 2),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                AppText.regular(
                                    dishCategory.dishes![index].category!,
                                    color: AppColor.black),
                                AppText.currency(
                                    '${dishCategory.dishes![index].price!}¥')
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (_, __) {
              return Container(
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                height: 1,
                color: AppColor.lightGray,
              );
            },
            itemCount: dishCategory.dishes?.length ?? 0,
          )
        ],
      ),
    );
  }
}
