import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wizlah_assignment/api/util/images.dart';
import 'package:wizlah_assignment/model/movie/movie_review.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class MovieReviewItem extends StatelessWidget {
  final MovieReview info;

  const MovieReviewItem({
    super.key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: SysSize.paddingMedium),
      padding: const EdgeInsets.symmetric(
        horizontal: SysSize.paddingMedium,
        vertical: SysSize.paddingSmall,
      ),
      width: AppService().appScreenSize.width * 0.8,
      decoration: BoxDecoration(
        color: AppColor.whiteBorderColor,
        borderRadius: BorderRadius.circular(SysSize.paddingBig),
        border: Border.all(
          color: AppColor.whiteAccentColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: SysSize.paddingMedium),
          StText.small(
            info.content,
            style: StandardTextStyle.small.copyWith(
              color: AppColor.whiteSecondaryColor,
            ),
            maxLines: 7,
          ),
          const Spacer(),
          Row(
            children: <Widget>[
              const Spacer(),
              StText.small(
                'Commented At · ${info.createdDateString}',
                style: StandardTextStyle.small.copyWith(
                  color: AppColor.whiteSecondaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              (info.authorDetails?.avatarPath?.isEmpty ?? true)
                  ? Image.asset(
                      'assets/image/tmdb_loading_placeholder.png',
                      height: 30.0,
                      width: 30.0,
                      fit: BoxFit.cover,
                    )
                  : ExtendedImage.network(
                      Images.getUrl(
                        info.authorDetails?.avatarPath,
                        size: Images.profileSmallest,
                      ),
                      width: 30.0,
                      height: 30.0,
                      fit: BoxFit.cover,
                      shape: BoxShape.circle,
                    ),
              if (info.authorDetails != null)
                const SizedBox(width: SysSize.paddingMedium),
              Expanded(
                child: StText.big(
                  info.author ?? '',
                  style: StandardTextStyle.small.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  const Icon(Icons.star, color: Colors.yellow, size: 24.0),
                  StText.small(info.authorDetails?.ratingTitle),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
