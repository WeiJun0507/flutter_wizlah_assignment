import 'package:flutter/material.dart';
import 'package:flutter_skeleton_plus/flutter_skeleton_plus.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class SkeletonPersonDetailCasting extends StatelessWidget {
  const SkeletonPersonDetailCasting({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 80.0,
            height: 20.0,
            color: AppColor.whiteAccentColor,
          ),
          const SizedBox(height: SysSize.paddingMedium),
          Container(
            padding: const EdgeInsets.all(SysSize.paddingSmall),
            decoration: BoxDecoration(
              color: AppColor.whiteBorderColor,
              borderRadius: BorderRadius.circular(SysSize.paddingMedium),
              border: Border.all(color: AppColor.whiteAccentColor),
            ),
            height: 100.0,
          ),
          const SizedBox(height: SysSize.paddingHuge),
          Container(
            width: 80.0,
            height: 20.0,
            color: AppColor.whiteAccentColor,
          ),
          const SizedBox(height: SysSize.paddingMedium),
          Container(
            width: AppService().appScreenSize.width * 0.7,
            margin: const EdgeInsets.only(right: SysSize.paddingBig),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SysSize.small),
              border: Border.all(color: AppColor.whiteAccentColor),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: AppColor.whiteAccentColor,
                  width: AppService().appScreenSize.width * 0.7,
                  height: AppService().appScreenSize.height * 0.2,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SysSize.paddingBig,
                    vertical: SysSize.paddingMedium,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 80.0,
                        height: 20.0,
                        color: AppColor.whiteAccentColor,
                      ),
                      const SizedBox(
                        height: SysSize.paddingSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
