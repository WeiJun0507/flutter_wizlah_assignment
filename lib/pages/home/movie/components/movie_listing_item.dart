import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wizlah_assignment/api/util/images.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/pages/home/movie/components/movie_rating.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class MovieListingItem extends StatelessWidget {
  final MovieInfo info;
  final VoidCallback? onDetailTap;

  const MovieListingItem({
    super.key,
    required this.info,
    this.onDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        return Stack(
          children: <Widget>[
            if (info.backdropPath?.isNotEmpty ?? false)
              Hero(
                tag: info.id.toString(),
                child: ExtendedImage.network(
                  Images.getUrl(
                    info.backdropPath,
                    size: Images.backdropHighest,
                  ),
                  constraints: constraints,
                  fit: BoxFit.cover,
                ),
              ),
            // top gradient
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              height: kToolbarHeight * 3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const <double>[
                      0.05,
                      0.3,
                      0.5,
                      0.7,
                      1.0,
                    ],
                    colors: <Color>[
                      AppColor.primaryColor,
                      AppColor.primaryColor.withOpacity(0.8),
                      AppColor.secondaryColor,
                      AppColor.blackAccentColor,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // bottom gradient
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              height: constraints.maxHeight * 0.8,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColor.primaryColor,
                      AppColor.primaryColor.withOpacity(0.8),
                      AppColor.secondaryColor,
                      AppColor.blackAccentColor,
                      Colors.transparent,
                    ],
                    stops: const [
                      0.1,
                      0.4,
                      0.6,
                      0.8,
                      1.0,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: SysSize.big,
                  horizontal: SysSize.paddingBig,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    StText.big(
                      info.title,
                      style: StandardTextStyle.big.copyWith(
                        fontSize: SysSize.huge,
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(height: SysSize.paddingMedium),

                    // genre type
                    if (info.genreIds?.isNotEmpty ?? false)
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          if (info.originalLanguage?.isNotEmpty ?? false)
                            Container(
                              margin: const EdgeInsets.only(
                                right: SysSize.paddingMedium,
                                bottom: SysSize.paddingMedium,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: SysSize.paddingSmall,
                                horizontal: SysSize.paddingMedium,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.whitePrimaryColor,
                                borderRadius: BorderRadius.circular(
                                  SysSize.paddingMedium,
                                ),
                              ),
                              child: StText.small(
                                info.originalLanguage!.toUpperCase(),
                                style: StandardTextStyle.small.copyWith(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ),
                          ...List<Widget>.generate(info.genreIds!.length,
                              (int index) {
                            return Container(
                              margin: const EdgeInsets.only(
                                right: SysSize.paddingMedium,
                                bottom: SysSize.paddingMedium,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: SysSize.paddingSmall,
                                horizontal: SysSize.paddingMedium,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.whiteAccentColor,
                                borderRadius: BorderRadius.circular(
                                  SysSize.paddingMedium,
                                ),
                              ),
                              child: StText.small(info.genreTitle[index]),
                            );
                          })
                        ],
                      ),
                    if (info.genreIds?.isNotEmpty ?? false)
                      const SizedBox(height: SysSize.paddingSmall),
                    // movie overview
                    StText.small(
                      info.overview,
                      maxLines: 4,
                      style: StandardTextStyle.small.copyWith(
                        color: AppColor.whitePrimaryColor.withOpacity(0.8),
                      ),
                    ),

                    const SizedBox(height: SysSize.paddingBig),
                    InkWell(
                      onTap: onDetailTap?.call,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: SysSize.paddingMedium,
                          horizontal: SysSize.paddingHuge,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.themeColor,
                          borderRadius: BorderRadius.circular(SysSize.big),
                        ),
                        child: const StText.normal('Details'),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // Top Right Popular Info
            Positioned(
              top: AppService().appViewPadding.top + 12,
              right: SysSize.paddingBig,
              child: // vote average + vote count
                  Container(
                padding: const EdgeInsets.symmetric(
                  vertical: SysSize.paddingMedium,
                  horizontal: SysSize.paddingMedium,
                ),
                decoration: BoxDecoration(
                  color: AppColor.whiteAccentColor,
                  borderRadius: BorderRadius.circular(SysSize.big),
                ),
                child: Row(
                  children: <Widget>[
                    if (info.voteAverage != null) MovieRating(info: info),
                    if (info.adult ?? false)
                      const SizedBox(width: SysSize.paddingSmall),
                    if (info.adult ?? false)
                      Icon(
                        Icons.eighteen_up_rating,
                        size: 20.0,
                        color: AppColor.whitePrimaryColor,
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
