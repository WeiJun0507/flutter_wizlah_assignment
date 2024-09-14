import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wizlah_assignment/api/util/images.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class MovieCover extends StatelessWidget {
  final MovieInfo info;

  const MovieCover({
    super.key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: SysSize.normal),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(SysSize.paddingBig),
            child: ExtendedImage.network(
              Images.getUrl(
                info.posterPath,
                size: Images.posterMedium,
              ),
              width: AppService().appScreenSize.width * 0.4,
              height: AppService().appScreenSize.height * 0.3,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(height: SysSize.paddingSmall),
          StText.small(
            info.title,
            maxLines: 1,
            style: StandardTextStyle.small.copyWith(
              fontSize: SysSize.tiny,
            ),
          ),
        ],
      ),
    );
  }
}
