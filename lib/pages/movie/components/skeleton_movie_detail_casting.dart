import 'package:flutter/material.dart';
import 'package:flutter_skeleton_plus/flutter_skeleton_plus.dart';
import 'package:wizlah_assignment/pages/home/movie/components/skeleton_movie_cover.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class SkeletonMovieDetailCasting extends StatelessWidget {
  const SkeletonMovieDetailCasting({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // top casts
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 80.0,
              height: 20.0,
              color: AppColor.whiteAccentColor,
            ),
            SizedBox(
              height: AppService().appScreenSize.height * 0.1,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return SkeletonItem(
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: SysSize.paddingMedium,
                      ),
                      width: 80.0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: SysSize.paddingMedium,
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.whiteAccentColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: SysSize.paddingSmall),
                          Container(
                            margin: const EdgeInsets.only(
                              top: SysSize.paddingMedium,
                            ),
                            width: 40.0,
                            height: 20,
                            color: AppColor.whiteAccentColor,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: SysSize.paddingHuge),
        // recommend for you
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: AppColor.whiteAccentColor,
              width: 100.0,
              height: 20.0,
            ),
            const SizedBox(height: SysSize.paddingMedium),
            const SkeletonMovieCover(),
          ],
        ),
      ],
    );
  }
}
