import 'package:flutter/material.dart';

import '../../../../core/components/components.dart';
import '../../../../core/configs/configs.dart';

class FilterCards extends StatelessWidget {
  const FilterCards({
    super.key, required this.text, required this.isSelected
  });
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.dx, bottom: 8.dy),
      padding: EdgeInsets.symmetric(horizontal: 8.dx, vertical: 8.dy),
              decoration: BoxDecoration(
              color: isSelected? kBlack: kWhite,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xffA1A1A1),
              )),
      child: CustomText(
            text: text,
            overflow: TextOverflow.ellipsis,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: isSelected? kWhite :const Color(0xff45403B),
          ),
    );
  }
}