import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travoli/core/configs/configs.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    Key? key,
    this.hintText,
    required this.hidePassword,
    required this.labelText,
    required this.suffixFunction,
    required this.controller,
    required this.validator,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.width = 343,
    this.suffixIcon,
  }) : super(key: key);
  final String? hintText;
  final String labelText;
  final bool hidePassword;
  final double width;
  final TextEditingController controller;
  final Function() suffixFunction;
  final String? Function(String?) validator;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: const Color(0xff1C1C1E)),
        ),
        SpaceY(8.dy),
        TextFormField(
          controller: controller,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: kTextColorsLight,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400),
          obscureText: hidePassword,
          obscuringCharacter: "*",
          cursorHeight: 20.dy,
          cursorColor: kTextColorsLight,
          keyboardType: keyboardType,
            inputFormatters: inputFormatters,
          decoration: InputDecoration(
            suffixIcon: suffixIcon ??
                IconButton(
                  color: kPrimaryColor,
                  iconSize: 16.dx,
                  onPressed: suffixFunction,
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility
                        : Icons.visibility_off_outlined,
                    color: const Color(0xFF1C1C1E),
                    size: 16,
                  ),
                ),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: const Color(0xFFB7B7B9),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
                filled: true,
        fillColor:  const Color(0xffF9FAFB),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0.dy, horizontal: 10.0.dx), 
         // border: InputBorder.none, 
          focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kTextColorsLight),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
               borderSide: const BorderSide(color: kTextColorsLight),
              borderRadius: BorderRadius.circular(8),
            ),
        enabledBorder: OutlineInputBorder(
           borderSide: const BorderSide(color: Color(0xffE0DFDF)),
          borderRadius: BorderRadius.circular(8),
        ),
           ),
          onChanged: onChanged,
          onSaved: (newValue) {},
          validator: validator,
        ),
      ],
    );
  }
}
