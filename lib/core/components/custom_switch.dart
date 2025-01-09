import 'package:flutter/cupertino.dart';
import 'package:travoli/core/configs/configs.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch(
      {super.key, required this.isActive, required this.onChanged});
  final bool isActive;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.5, // Adjust the scale factor as needed to change the size
      child: CupertinoSwitch(
          activeColor: kSuccess,
          value: isActive, // Example value
          onChanged: onChanged),
    );
  }
}