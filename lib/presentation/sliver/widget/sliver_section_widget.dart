import 'package:flutter/material.dart';
import 'package:fluttour/util/util.dart';

class SliverSectionWidget extends StatelessWidget {
  const SliverSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 18.h),
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppText.h4('Most Populars'),
            SizedBox(height: 24.h),
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return SizedBox(
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
                                  AppText.itemTitleLarge('Combo Burger', maxLines: 1),
                                  SizedBox(height: 4.h),
                                  AppText.body('Shortbread, chocolate turtle cookies, and red velvet.', maxLines: 2),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  AppText.regular('Deshi  •  Chinese', color: AppColor.black),
                                  AppText.regular('USD7.4', color: AppColor.active, fontWeight: FontWeightType.semiBold)
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
                  margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
                  height: 1,
                  color: AppColor.lightGray,
                );
              },
              itemCount: 3)
          ],
        ),
      ),
    );
  }
}
