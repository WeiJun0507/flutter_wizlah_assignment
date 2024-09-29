import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wizlah_assignment/api/util/images.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class MovieCover extends StatelessWidget {
  final MovieInfo info;
  final VoidCallback? onDetailTap;

  const MovieCover({
    super.key,
    required this.info,
    this.onDetailTap,
  });

  Widget imageLoadStateCallback(ExtendedImageState imageState) {
    switch (imageState.extendedImageLoadState) {
      case LoadState.failed:
        return Image.asset(
          'assets/image/tmdb_loading_placeholder.png',
          height: 200,
          width: AppService().appScreenSize.width * 0.35,
          fit: BoxFit.cover,
        );
      case LoadState.completed:
        return imageState.completedWidget;
      default:
        return Center(
          child: CircularProgressIndicator(
            color: AppColor.themeColor,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: SysSize.normal),
      width: AppService().appScreenSize.width * 0.35,
      child: InkWell(
        onTap: onDetailTap,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(SysSize.paddingBig),
                child: Hero(
                  tag: info.id.toString(),
                  child: (info.posterPath?.isEmpty ?? true)
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
                          height: 200,
                          fit: BoxFit.fitHeight,
                          loadStateChanged: imageLoadStateCallback,
                        ),
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
