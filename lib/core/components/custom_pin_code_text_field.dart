import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:travoli/core/configs/configs.dart';
//import 'package:pin_code_text_field/pin_code_text_field.dart';


class CustomPinCodeTextField extends StatelessWidget {
  const CustomPinCodeTextField({
    Key? key,
    required this.controller,
    required this.onSaved,
    required this.onSubmitted,
    this.isReadOnly = false,
    required this.onComplete,
    this.color = const Color(0xffF8F8FC),
  }) : super(key: key);
  final TextEditingController controller;
  final Function(String) onComplete;
  final Function(String) onSaved;
  final Function(String) onSubmitted;
  final bool isReadOnly;
  final Color? color;
  
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      appContext: context,
      length: 6,
      controller: controller,
      obscureText: true,
      obscuringCharacter: "-",
      //backgroundColor: color,
      showCursor: false,
      enableActiveFill: true,
      //backgroundColor: const  Color(0xFFF8F8FC),
      textStyle: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: kTextColorsLight, fontSize: 16.sp),
      blinkWhenObscuring: true,
      keyboardType: TextInputType.number,
      readOnly: isReadOnly,
      onChanged: (value) {},
      onCompleted: onComplete,
      onSaved: (value) {},
      onSubmitted: (value) {},
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 48.dy,
        borderWidth: 1.dx,
        selectedFillColor: color,
        fieldWidth: 52.dx,
        inactiveFillColor: color,
        activeFillColor: color,
        //fieldOuterPadding: EdgeInsets.symmetric(horizontal: padding != null? padding!:0),
        activeColor: kPrimaryColor,
        inactiveColor: Color(0xffE0DFDF),
        selectedColor: Color(0xffE0DFDF),
      ),
    );
  }
}
