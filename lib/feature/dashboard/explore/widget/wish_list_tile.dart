import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travoli/core/configs/configs.dart';

import '../../../../core/components/components.dart';

class WishlistTile extends StatelessWidget {
  const WishlistTile({
    super.key, required this.containerWidth, 
    required this.title, 
    required this.city,
    required this.amount, 
    required this.image,
    required this.onPressed,
    required this.type,
    required this.count
  });
  final double containerWidth;
  final String title, city, amount, type;
  final void Function()? onPressed;
  final XFile image;
  final int count;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7.dx, bottom: 16.dy),
      height: 232.dy, width: containerWidth,
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xffE0DFDF),)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140.dy, width: containerWidth,
           decoration:   BoxDecoration(
            image:  DecorationImage(
              image: FileImage(File(image.path)),
              fit: BoxFit.fill,
          ),
          color: kWhite,
          borderRadius:  BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:  const EdgeInsets.all(9.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
          Padding(
             padding:   EdgeInsets.only(bottom: 10.dy),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.dx,vertical: 1.dy),
            decoration: BoxDecoration(
            color: kBlack,
            borderRadius: BorderRadius.circular(3),
                    ),
            child: CustomText(
                  text:type,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: kWhite,
                ),
                 ),
          ),
               //  IconButton(icon: const Icon(Icons.favorite_outline), onPressed: onPressed,)
                ],
              ),
            ),
              Container(
            padding: EdgeInsets.symmetric(horizontal: 8.dx,vertical: 1.dy),
          decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(3),
        ),
          child: CustomText(
      text:"1/$count",
      fontSize: 8.sp,
      fontWeight: FontWeight.w700,
      color: kWhite,
    ),
     ),
          ],
        ),
            ),
          SpaceY(17.5.dy),
          Padding(
    padding:  EdgeInsets.symmetric(horizontal: 10.dx),
    child: CustomText(
      text:title,
      overflow: TextOverflow.ellipsis,
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      color: const Color(0xff100C08),
    ),
                  ),
                  Padding(
    padding:  EdgeInsets.symmetric(horizontal: 10.dx),
    child: CustomText(
      text:city??"Abuja.",
      overflow: TextOverflow.ellipsis,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      fontFamily: kSecondaryFontFamily,
      color: const Color(0xff100C08),
    ),
                  ),
                  Padding(
    padding:  EdgeInsets.symmetric(horizontal: 10.dx),
    child: CustomText(
      text: amount,
      overflow: TextOverflow.ellipsis,
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
      color: const Color(0xff5C4500),
    ),
                  ),
          ],
        ),
    );
  }
}

class ExploreTile extends StatelessWidget {
  const ExploreTile({
    super.key, 
    required this.icon,
    required this.containerWidth, 
    required this.title, 
    required this.city, 
    required this.amount, 
    required this.image, 
    required this.imageCount,
    required this.favOnpressed
  });
  final double containerWidth;
  final String title, city, amount,image;
  final int imageCount;
  final IconData icon;
  final void Function()? favOnpressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7.dx, bottom: 16.dy),
      height: 232.dy, width: containerWidth,
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xffE0DFDF),)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140.dy, width: containerWidth,
           decoration:   BoxDecoration(
            image:  DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.fill,
          ),
          color: kWhite,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:  const EdgeInsets.all(9.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
          Padding(
             padding:   EdgeInsets.only(bottom: 10.dy),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.dx,vertical: 1.dy),
            decoration: BoxDecoration(
            color: kBlack,
            borderRadius: BorderRadius.circular(3),
                    ),
            child: CustomText(
                  text:"To let",
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: kWhite,
                ),
                 ),
          ),
                  IconButton(icon: Icon(icon), onPressed: favOnpressed,)
                ],
              ),
            ),
              Container(
            padding: EdgeInsets.symmetric(horizontal: 8.dx,vertical: 1.dy),
          decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(3),
        ),
          child: CustomText(
      text:"1/$imageCount",
      fontSize: 8.sp,
      fontWeight: FontWeight.w700,
      color: kWhite,
    ),
     ),
          ],
        ),
            ),
          SpaceY(17.5.dy),
          Padding(
    padding:  EdgeInsets.symmetric(horizontal: 10.dx),
    child: CustomText(
      text:title?? "Two bedroom flat",
      overflow: TextOverflow.ellipsis,
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      color: const Color(0xff100C08),
    ),
                  ),
                  Padding(
    padding:  EdgeInsets.symmetric(horizontal: 10.dx),
    child: CustomText(
      text:city??"Abuja.",
      overflow: TextOverflow.ellipsis,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      fontFamily: kSecondaryFontFamily,
      color: const Color(0xff100C08),
    ),
                  ),
                  Padding(
    padding:  EdgeInsets.symmetric(horizontal: 10.dx),
    child: CustomText(
      text:amount??"N300,000/month",
      overflow: TextOverflow.ellipsis,
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
      color: const Color(0xff5C4500),
    ),
                  ),
          ],
        ),
    );
  }
}