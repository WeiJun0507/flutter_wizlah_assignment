import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wizlah_assignment/api/util/images.dart';
import 'package:wizlah_assignment/model/person/person_info.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class PersonCover extends StatelessWidget {
  final PersonInfo info;
  final VoidCallback? onDetailTap;

  const PersonCover({
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
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(SysSize.paddingBig),
              ),
              child: Hero(
                tag: info.id.toString(),
                child: (info.profilePath?.isEmpty ?? true)
                    ? Image.asset(
                        'assets/image/tmdb_loading_placeholder.png',
                        height: 200,
                        width: AppService().appScreenSize.width * 0.35,
                        fit: BoxFit.cover,
                      )
                    : ExtendedImage.network(
                        Images.getUrl(
                          info.profilePath,
                          size: Images.profileMedium,
                        ),
                        width: AppService().appScreenSize.width * 0.3,
                        height: 150,
                        fit: BoxFit.cover,
                        loadStateChanged: imageLoadStateCallback,
                      ),
              ),
            ),
            const SizedBox(
              width: SysSize.paddingBig,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  StText.big(info.name),
                  const SizedBox(height: SysSize.paddingMedium),
                  StText.small(
                    '${info.genderString} · ${info.knownForDepartment}',
                    style: StandardTextStyle.small.copyWith(
                      fontSize: SysSize.tiny,
                      color: AppColor.whitePrimaryColor.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: SysSize.paddingMedium),
                  if (info.knownFor?.isNotEmpty ?? false)
                    _buildKnownInfo(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKnownInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const StText.big('Known for'),
        const SizedBox(height: SysSize.paddingMedium),
        ...List<Widget>.generate(
          min(info.knownFor?.length ?? 0, 5),
          (i) {
            final knownFor = info.knownFor![i];

            return Container(
              padding: const EdgeInsets.all(SysSize.paddingSmall),
              margin: const EdgeInsets.only(bottom: SysSize.paddingSmall),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SysSize.paddingSmall),
                color: AppColor.whiteBorderColor,
              ),
              child: StText.small(
                '${i + 1}. ${knownFor.personTitle}',
                style: StandardTextStyle.small.copyWith(
                  fontSize: SysSize.tiny,
                  color: AppColor.whitePrimaryColor.withOpacity(0.8),
                ),
                align: TextAlign.center,
              ),
            );
          },
        ),
      ],
    );
  }
}
