import 'package:flutter/material.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class EmptyStateView extends StatelessWidget {
  final String title;
  final VoidCallback? onRetry;

  const EmptyStateView({super.key, required this.title, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRetry,
      child: Container(
        height: 250,
        width: AppService().appScreenSize.width,
        decoration: BoxDecoration(
          color: AppColor.whiteBorderColor,
          borderRadius: BorderRadius.circular(SysSize.paddingMedium),
        ),
        alignment: Alignment.center,
        child: StText.big('No $title display. Try again.'),
      ),
    );
  }
}
