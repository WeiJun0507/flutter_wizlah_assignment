import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wizlah_assignment/api/util/images.dart';
import 'package:wizlah_assignment/model/person/person_info.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class MovieCastingItem extends StatelessWidget {
  final PersonInfo info;
  final VoidCallback? onDetailTap;

  const MovieCastingItem({
    super.key,
    required this.info,
    this.onDetailTap,
  });

  Widget imageLoadStateCallback(ExtendedImageState imageState) {
    switch (imageState.extendedImageLoadState) {
      case LoadState.failed:
        return Image.asset(
          'assets/image/tmdb_loading_placeholder.png',
          height: 60.0,
          width: 60.0,
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
    return InkWell(
      onTap: onDetailTap,
      child: Container(
        width: 80.0,
        padding: const EdgeInsets.symmetric(horizontal: SysSize.paddingMedium),
        child: Column(
          children: <Widget>[
            (info.profilePath?.isEmpty ?? true)
                ? Image.asset(
                    'assets/image/tmdb_loading_placeholder.png',
                    height: 60.0,
                    width: 60.0,
                    fit: BoxFit.cover,
                  )
                : ExtendedImage.network(
                    Images.getUrl(
                      info.profilePath,
                      size: Images.profileMedium,
                    ),
                    shape: BoxShape.circle,
                    height: 60.0,
                    width: 60.0,
                    fit: BoxFit.cover,
                    loadStateChanged: imageLoadStateCallback,
                  ),
            const SizedBox(height: SysSize.paddingSmall),
            StText.small(
              info.name,
              align: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
