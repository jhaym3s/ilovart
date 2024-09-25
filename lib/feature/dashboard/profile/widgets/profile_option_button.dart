import 'package:flutter/material.dart';
import 'package:travoli/core/configs/configs.dart';

import '../../../../core/components/components.dart';

class ProfileOptionButton extends StatelessWidget {
  const ProfileOptionButton({
    super.key, required this.images, required this.text, required this.borderColor
  });
  final String images,text;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.dx),
      height: 48.dy,
      width: double.infinity,
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: borderColor,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
               Image.asset(images, width: 20.dx, height: 20.dy,),
               SpaceX(8.dx),
              CustomText(
                text: text,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: kTextColorsLight,
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.dx),
      height: 48.dy,
      width: double.infinity,
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xffFF0F0F
).withOpacity(.1),
          )),
      child: Row(
        children: [
          const Icon(Icons.logout_outlined,color: Color(0xffEB5757),),
          CustomText(
            text: "Logout",
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xffEB5757),
          ),
          
        ],
      ),
    );
  }
}