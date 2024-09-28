import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wizlah_assignment/api/util/images.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/pages/home/movie/components/movie_rating.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class MovieSearchResult extends StatelessWidget {
  final MovieInfo info;
  final VoidCallback? onDetailTap;

  const MovieSearchResult({
    super.key,
    required this.info,
    this.onDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onDetailTap,
      child: Container(
        padding: const EdgeInsets.all(SysSize.paddingMedium),
        decoration: BoxDecoration(
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
            (info.posterPath?.isEmpty ?? true)
                ? Image.asset(
                    'assets/image/tmdb_loading_placeholder.png',
                    height: 200,
                    width: AppService().appScreenSize.width * 0.35,
                    fit: BoxFit.cover,
                  )
                : ExtendedImage.network(
                    Images.getUrl(
                      info.posterPath,
                      size: Images.posterMedium,
                    ),
                    width: AppService().appScreenSize.width * 0.3,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(width: SysSize.paddingBig),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  StText.big(info.title),
                  const SizedBox(height: SysSize.paddingMedium),
                  if (info.originalLanguage?.isNotEmpty ?? false)
                    StText.small(
                      'Language: ${info.originalLanguage}',
                      style: StandardTextStyle.small.copyWith(
                        fontSize: SysSize.tiny,
                        color: AppColor.whitePrimaryColor.withOpacity(0.8),
                      ),
                    ),
                  if (info.originalLanguage?.isNotEmpty ?? false)
                    const SizedBox(height: SysSize.paddingMedium),
                  if (info.genreIds?.isNotEmpty ?? false)
                    StText.small(
                      'Type: ${info.genreTitle.fold('', (r, e) => '${r.isNotEmpty ? "$r," : r} $e')}',
                      style: StandardTextStyle.small.copyWith(
                        fontSize: SysSize.tiny,
                        color: AppColor.whitePrimaryColor.withOpacity(0.8),
                      ),
                    ),
                  if (info.genreIds?.isNotEmpty ?? false)
                    const SizedBox(height: SysSize.paddingMedium),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: SysSize.paddingSmall,
                      horizontal: SysSize.paddingMedium,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SysSize.normal),
                      color: AppColor.whiteAccentColor,
                    ),
                    child: MovieRating(info: info),
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
