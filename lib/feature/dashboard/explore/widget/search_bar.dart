import 'package:flutter/material.dart';
import 'package:travoli/core/configs/configs.dart';

import '../../../../core/components/components.dart';

class ExploreSearchBar extends StatelessWidget {
  const ExploreSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.dx),
      padding: EdgeInsets.symmetric(horizontal: 15.dx),
      height: 48.dy, width: double.infinity,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffE0DFDF),)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
      text:
          "Search house type, location...",
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xffA1A1A1),
      fontFamily: kSecondaryFontFamily,
    ),
      Image.asset(AssetsImages.filterIcon,height: 16.dy, width: 16.dx,),
        ],
      ),
    );
  }
}