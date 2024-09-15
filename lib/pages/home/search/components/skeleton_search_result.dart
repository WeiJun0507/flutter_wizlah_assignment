import 'package:flutter/material.dart';
import 'package:flutter_skeleton_plus/flutter_skeleton_plus.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class SkeletonSearchResult extends StatelessWidget {
  const SkeletonSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return SkeletonItem(
          child: Container(
            margin: const EdgeInsets.only(bottom: SysSize.paddingMedium),
            padding: const EdgeInsets.all(SysSize.paddingMedium),
            decoration: BoxDecoration(
              color: AppColor.whiteBorderColor,
              border: Border(
                bottom: BorderSide(
                  color: AppColor.whiteBorderColor,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: AppService().appScreenSize.width * 0.3,
                  height: AppService().appScreenSize.height * 0.2,
                  decoration: BoxDecoration(
                    color: AppColor.whiteAccentColor,
                  ),
                ),
                const SizedBox(width: SysSize.paddingBig),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 20,
                        color: AppColor.whiteAccentColor,
                      ),
                      const SizedBox(height: SysSize.paddingMedium),
                      Container(
                        height: 20,
                        color: AppColor.whiteAccentColor,
                      ),
                      const SizedBox(height: SysSize.paddingHuge),
                      Container(
                        height: 60,
                        color: AppColor.whiteAccentColor,
                      ),
                      const SizedBox(height: SysSize.paddingMedium),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
