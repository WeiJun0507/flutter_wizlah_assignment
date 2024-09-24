import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// let text align center of line.
double get oneLineH {
  if (kIsWeb) return 1.25;
  return Platform.isIOS ? 1.3 : 1.25;
}

class StandardTextStyle {
  static const TextStyle big = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: SysSize.big,
    inherit: true,
    height: 1.2,
  );
  static const TextStyle medium = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: SysSize.normal,
    inherit: true,
    height: 1.2,
  );
  static const TextStyle normal = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: SysSize.normal,
    inherit: true,
    height: 1.2,
  );
  static const TextStyle small = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: SysSize.small,
    inherit: true,
    height: 1.2,
  );
}

/// Standard text in project
/// Auto set StandardTextStyle and did not change the usage of `Text` widget.
class StText extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final TextStyle defaultStyle;
  final TextAlign? align;
  final int? maxLines;

  const StText({
    super.key,
    this.text,
    this.style,
    required this.defaultStyle,
    this.maxLines,
    this.align,
  });

  const StText.small(
    String? text, {
    Key? key,
    TextStyle? style,
    TextAlign? align,
    int? maxLines,
  }) : this(
          key: key,
          text: text,
          style: style,
          defaultStyle: StandardTextStyle.small,
          maxLines: maxLines,
          align: align,
        );

  const StText.normal(
    String? text, {
    Key? key,
    TextStyle? style,
    TextAlign? align,
    int? maxLines,
  }) : this(
          key: key,
          text: text,
          style: style,
          defaultStyle: StandardTextStyle.normal,
          maxLines: maxLines,
          align: align,
        );

  const StText.medium(
    String? text, {
    Key? key,
    TextStyle? style,
    TextAlign? align,
    int? maxLines,
  }) : this(
          key: key,
          text: text,
          style: style,
          align: align,
          defaultStyle: StandardTextStyle.medium,
          maxLines: maxLines,
        );

  const StText.big(
    String? text, {
    Key? key,
    TextStyle? style,
    TextAlign? align,
    int? maxLines,
  }) : this(
          key: key,
          text: text,
          style: style,
          defaultStyle: StandardTextStyle.big,
          maxLines: maxLines,
          align: align,
        );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: defaultStyle.copyWith(
        height: oneLineH,
      ),
      child: Text(
        text ?? '',
        maxLines: maxLines ?? 50,
        textAlign: align,
        overflow: TextOverflow.ellipsis,
        style: style,
      ),
    );
  }
}

String overflowEllipsisMiddle(String text) {
  if (text.length > 10) {
    return '${text.substring(0, 6)}...${text.substring(text.length - 4)}';
  }
  return text;
}

/// Standard size of text or icon.
class SysSize {
  static const double huge = 24;
  static const double big = 18;
  static const double normal = 16;
  static const double small = 14;
  static const double tiny = 12;

  static const double paddingSmall = 4.0;
  static const double paddingMedium = 8.0;
  static const double paddingBig = 12.0;

  static const double paddingHuge = 24.0;
}
