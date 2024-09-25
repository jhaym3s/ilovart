import 'package:flutter/material.dart';
import 'package:travoli/core/configs/configs.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key, required this.progress});
  final double progress; /// in decimal

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 184.dx,
      height: 8.dy,
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffD0D5DD)
      ),
      child: Stack(
        children: [
          Container(
            width: 258.dx * progress.dx,
            height: 8.dy,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}

