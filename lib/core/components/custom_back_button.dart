import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key,required this.onTap}) : super(key: key);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: onTap,
          child: 
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xffF1F3F5),
            child:  Icon(Icons.arrow_back, size: 18,color: Color(0xff37414A),)),
          );
  }
}