import 'package:flutter/material.dart';
import 'package:travoli/core/configs/configs.dart';

import '../screens/onboarding_screen.dart';


class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem(
      {Key? key,
      required this.description,
      required this.image,
      required this.currentIndex,
      required this.positionIndex,
      required this.positionIndex2,
      required this.title})
      : super(key: key);

  final String image;
  final String title;
  final String description;
  final int currentIndex, positionIndex, positionIndex2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Image.asset(
            image,
         // height: 340.dy, width: 390.dx,
          ),
          SpaceY(16.dy),
         Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Indicator(positionIndex: positionIndex, currentIndex: currentIndex),
          Indicator(positionIndex: positionIndex2, currentIndex: currentIndex),
          //Indicator(positionIndex: 2, currentIndex: currentIndex)
        ],
      ),
      SpaceY(40.dy),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24.dx),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 32.sp,
                color: const Color(0xff111315)),
          ),
        ),
        SpaceY(8.dy),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24.dx),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: const Color(0xff100C08)
                ),
          ),
        ),
      ],
    );
  }
}