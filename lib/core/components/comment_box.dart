import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travoli/core/components/components.dart';
import 'package:travoli/core/configs/configs.dart';

class CommentTextFormField extends StatelessWidget {
  const CommentTextFormField(
      {Key? key,
      required this.hintText,
      required this.labelText,
      required this.controller,
      this.width = 343,
      this.suffixIcon,
      this.onChanged,
       this.keyboardType,
    this.inputFormatters,
      required this.validator, })
      : super(key: key);
  final String? hintText;
  final String labelText;
  final TextEditingController controller;
  final double width;
  final Widget? suffixIcon;
  final String? Function(String?) validator;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
       CustomText(text: labelText, fontSize: 14.sp, fontWeight: FontWeight.w700),
        SpaceY(4.dy),
        TextFormField(
        controller: controller,
        maxLines: null, // Allow unlimited lines
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
               color: kTextColorsLight,
               fontSize: 14.sp,
               fontWeight: FontWeight.w400),
           cursorHeight: 20.dy,
           cursorColor: kTextColorsLight,
            keyboardType: keyboardType,
             inputFormatters: inputFormatters,
        decoration: InputDecoration(
           suffixIcon: suffixIcon,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
           borderSide: const BorderSide(color: Color(0xffE0DFDF)),
          borderRadius: BorderRadius.circular(8),
        ),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffE0DFDF)),
              borderRadius: BorderRadius.circular(8),
            ),
           focusedBorder: OutlineInputBorder(
         borderSide: const BorderSide(color: kTextColorsLight),
          borderRadius: BorderRadius.circular(8),
        ),
          fillColor:  const Color(0xffF9FAFB),
          filled: true,
        ),
      ),
      ],
    );
  }
}
