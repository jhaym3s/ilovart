import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travoli/core/configs/configs.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        cursorColor: Colors.grey,
        //showCursor: ,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: kTextColorsLight),
        decoration:  InputDecoration(
          prefixIcon: const Icon(CupertinoIcons.search, color: kBlack,),
          border: InputBorder.none,
          hintText: 'Search for courses',
           enabledBorder: OutlineInputBorder(
          borderSide:  const BorderSide(color: Color(0xffD0D5DD)),
          borderRadius: BorderRadius.circular(8),
        ),
          hintStyle:  TextStyle(
      fontSize: 17.sp, fontWeight: FontWeight.w400, color: Colors.grey),
          contentPadding:  EdgeInsets.symmetric(horizontal: 16.dx,vertical: 16.dy),
        ),
      );
  }
}