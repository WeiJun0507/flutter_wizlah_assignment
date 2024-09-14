import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wizlah_assignment/api/util/images.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class MovieCover extends StatelessWidget {
  final MovieInfo info;
  final VoidCallback? onDetailTap;

  const MovieCover({
    super.key,
    required this.info,
    this.onDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onDetailTap?.call,
      child: Container(
        padding: const EdgeInsets.only(right: SysSize.normal),
        width: AppService().appScreenSize.width * 0.4,
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(SysSize.paddingBig),
              child: Hero(
                tag: info.id.toString(),
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
            ),
            const SizedBox(height: SysSize.paddingMedium),
            StText.small(
              info.title,
              maxLines: 2,
              align: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
