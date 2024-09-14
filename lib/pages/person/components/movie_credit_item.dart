import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wizlah_assignment/api/util/images.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/model/person/person_movie_cast.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class MovieCreditItem extends StatelessWidget {
  final PersonMovieCast cast;
  final VoidCallback? onDetailTap;

  const MovieCreditItem({
    super.key,
    required this.cast,
    this.onDetailTap,
  });

  MovieInfo get info => MovieInfo.fromJson(cast.toJson());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onDetailTap?.call,
      child: Container(
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
            ExtendedImage.network(
              Images.getUrl(
                cast.backdropPath,
                size: Images.backdropMedium,
              ),
              width: AppService().appScreenSize.width * 0.7,
              height: AppService().appScreenSize.height * 0.2,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: SysSize.paddingBig,
                vertical: SysSize.paddingMedium,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  StText.normal(cast.title),
                  const SizedBox(height: SysSize.paddingSmall),

                  StText.small('Casting: ${cast.character}'),

                  // Genre Listing
                  if (info.genreTitle.isNotEmpty)
                    const SizedBox(height: SysSize.paddingSmall),
                  if (info.genreTitle.isNotEmpty)
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        if (info.originalLanguage?.isNotEmpty ?? false)
                          Container(
                            margin: const EdgeInsets.only(
                              right: SysSize.paddingSmall,
                              bottom: SysSize.paddingSmall,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: SysSize.paddingSmall,
                              horizontal: SysSize.paddingMedium,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.whitePrimaryColor,
                              borderRadius: BorderRadius.circular(
                                SysSize.paddingSmall,
                              ),
                            ),
                            child: StText.small(
                              info.originalLanguage!.toUpperCase(),
                              style: StandardTextStyle.small.copyWith(
                                fontSize: SysSize.tiny,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                        ...List<Widget>.generate(
                          info.genreTitle.length,
                          (int index) {
                            return Container(
                              margin: const EdgeInsets.only(
                                right: SysSize.paddingSmall,
                                bottom: SysSize.paddingSmall,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: SysSize.paddingSmall,
                                horizontal: SysSize.paddingMedium,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.whiteAccentColor,
                                borderRadius: BorderRadius.circular(
                                  SysSize.paddingSmall,
                                ),
                              ),
                              child: StText.small(
                                info.genreTitle[index],
                                style: StandardTextStyle.small.copyWith(
                                  fontSize: SysSize.tiny,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
