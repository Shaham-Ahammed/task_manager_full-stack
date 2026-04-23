import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final bool isHeader;
  final double? size;
  final Color? color;
  final int? maxLines;
  final FontWeight? fontweight;

  const AppText(
    this.text, {
    super.key,
    this.isHeader = false,
    this.color,
    this.size,
    this.maxLines,
    this.fontweight
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      
      text,
      
      style: isHeader
          ? Theme.of(context).textTheme.titleMedium
          : Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: color, fontSize: size,
            fontWeight: fontweight
            ),
    maxLines: maxLines,
    );
  }
}
