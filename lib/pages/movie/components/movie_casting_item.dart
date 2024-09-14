import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wizlah_assignment/api/util/images.dart';
import 'package:wizlah_assignment/model/person/person_info.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class MovieCastingItem extends StatelessWidget {
  final PersonInfo info;

  const MovieCastingItem({
    super.key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      padding: const EdgeInsets.symmetric(horizontal: SysSize.paddingMedium),
      child: Column(
        children: <Widget>[
          ExtendedImage.network(
            Images.getUrl(
              info.profilePath,
              size: Images.profileMedium,
            ),
            shape: BoxShape.circle,
            height: 60.0,
            width: 60.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: SysSize.paddingSmall),
          StText.small(
            info.name,
            align: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
