import 'package:flutter/material.dart';
import 'package:flutter_skeleton_plus/flutter_skeleton_plus.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class SkeletonMovieCover extends StatelessWidget {
  const SkeletonMovieCover({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppService().appScreenSize.height * 0.35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return SkeletonItem(
            child: Container(
              margin: const EdgeInsets.only(right: SysSize.paddingSmall),
              child: Column(
                children: <Widget>[
                  Container(
                    width: AppService().appScreenSize.width * 0.4,
                    height: AppService().appScreenSize.height * 0.3,
                    decoration: BoxDecoration(
                      color: AppColor.whiteAccentColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: SysSize.paddingMedium,
                    ),
                    width: AppService().appScreenSize.width * 0.3,
                    height: 20,
                    color: AppColor.whiteAccentColor,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
