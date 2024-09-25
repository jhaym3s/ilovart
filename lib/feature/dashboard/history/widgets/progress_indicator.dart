import 'package:flutter/material.dart';
import 'package:travoli/core/configs/configs.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key, required this.progress});
  final double progress; /// in decimal

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 8.dy,
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: kWarning
      ),
      child: Stack(
        children: [
          Container(
            width: 10,
            height: 8.dy,
            decoration: BoxDecoration(
              color: kWarning,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}