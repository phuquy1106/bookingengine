import 'package:bookingengine_frontend/gen/fonts.gen.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:flutter/material.dart';

class NeutronTextContent extends StatelessWidget {
  final String message;
  final double? fontSize;
  final String? tooltip;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int maxLines;
  final FontWeight? fontWeight;
  final bool? softWrap;
  const NeutronTextContent(
      {Key? key,
      required this.message,
      this.fontSize,
      this.tooltip,
      this.color,
      this.textAlign = TextAlign.left,
      this.textOverflow,
      this.fontWeight,
      this.maxLines = 1,
      this.softWrap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tooltip != null) {
      return Tooltip(
        message: tooltip,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: Text(message,
            overflow: textOverflow ?? TextOverflow.ellipsis,
            textAlign: textAlign,
            maxLines: maxLines,
            softWrap: softWrap,
            style: TextStyle(
                fontWeight: fontWeight ?? FontWeight.normal,
                fontSize: fontSize ?? 14.0,
                fontFamily: FontFamily.aria,
                color: color ?? ColorManagement.lightColorText)),
      );
    }
    return Text(message,
        textAlign: textAlign,
        maxLines: maxLines,
        style: TextStyle(
            overflow: textOverflow ?? TextOverflow.ellipsis,
            fontWeight: FontWeight.normal,
            fontSize: fontSize ?? 14.0,
            color: color ?? ColorManagement.lightColorText));
  }
}
