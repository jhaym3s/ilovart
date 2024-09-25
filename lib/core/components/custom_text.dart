import 'package:flutter/material.dart';
import 'package:travoli/core/configs/configs.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text, this.color = kTextColorsLight, 
  required this.fontSize, required this.fontWeight, this.textAlign= TextAlign.left, this.softWrap, this.overflow, this.fontFamily = kFontFamily});
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final bool? softWrap;
  final TextOverflow? overflow;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        textAlign: textAlign,
        overflow: overflow, softWrap: softWrap,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight, fontFamily: fontFamily),
    );
  }
}