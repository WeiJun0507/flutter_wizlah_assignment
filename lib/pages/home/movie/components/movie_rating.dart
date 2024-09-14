import 'package:flutter/material.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class MovieRating extends StatelessWidget {
  final MovieInfo info;

  const MovieRating({
    super.key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Icon(
          Icons.star,
          color: Colors.orange,
          size: SysSize.normal,
        ),
        const SizedBox(width: SysSize.paddingSmall),
        StText.small(info.voteAverage.toString()),
        if (info.voteCount != null) const SizedBox(width: SysSize.paddingSmall),
        if (info.voteCount != null)
          StText.small('(${info.voteCount} review(s))'),
      ],
    );
  }
}
