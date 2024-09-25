import 'package:flutter/material.dart';
import 'package:travoli/core/configs/configs.dart';
import 'package:travoli/core/helpers/router/router.dart';
import 'package:travoli/feature/dashboard/dashbord.dart';

import '../../../../core/components/components.dart';

class Step2 extends StatefulWidget {
  static const routeName = "step2";
  const Step2({super.key});

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  final _stateController = TextEditingController();
  final _lgaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.dx),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceY(40.dy),
                CustomText(
                      text:
                          "Step 2/2 ",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff45403B),
                    ),
                    SpaceY(16.dy),
                    CustomText(
                        text: "House specifications?",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700),
                    SpaceY(4.dy),
                    CustomText(
                      text:
                          "Select the house specification that you are looking for. You can still change this later.  ",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: kSecondaryFontFamily,
                    ),
                    SpaceY(24.dy),
                DropDownTextFormField(
                  hintText: "Lagos",
                  labelText: "State",
                  controller: _stateController,
                  onTap: () {},
                  suffixIcon:const Icon(Icons.arrow_drop_down_sharp),
                  validator: (value) {
                    return null;
                  },
                ),
                 SpaceY(4.dy),
                CustomText(
                  text:
                      "Select your current location/the location you want to rent from.",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffA1A1A1),
                  fontFamily: kSecondaryFontFamily,
                ),
                SpaceY(12.dy),
                DropDownTextFormField(
                  hintText: "Uyo",
                  labelText: "Local Government Area",
                  controller: _lgaController,
                  onTap: () {},
                  suffixIcon:const Icon(Icons.arrow_drop_down_sharp),
                  validator: (value) {
                    return null;
                  },
                ),
                SpaceY(12.dy),
                DropDownTextFormField(
                  hintText: "Uyo",
                  labelText: "Local Government Area",
                  controller: _lgaController,
                  onTap: () {},
                  suffixIcon:const Icon(Icons.arrow_drop_down_sharp),
                  validator: (value) {
                    return null;
                  },
                ),
                SpaceY(12.dy),
                DropDownTextFormField(
                  hintText: "N100,000 - N200,000",
                  labelText: "Price Range",
                  controller: _lgaController,
                  onTap: () {},
                  suffixIcon:const Icon(Icons.arrow_drop_down_sharp),
                  validator: (value) {
                    return null;
                  },
                ),
                 SpaceY(4.dy),
                CustomText(
                  text:
                      "Note the house range is for a yearly plan.",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffA1A1A1),
                  fontFamily: kSecondaryFontFamily,
                ),
                SpaceY(12.dy),
                DropDownTextFormField(
                  hintText: "Single room",
                  labelText: "House Type",
                  controller: _lgaController,
                  onTap: () {},
                  suffixIcon:const Icon(Icons.arrow_drop_down_sharp),
                  validator: (value) {
                    return null;
                  },
                ),
                 SpaceY(10.dy),
                CustomText(
                  text:"*Please note that this will help us notify you on homes that match your specifications.",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: kTextColorsLight,
                  fontFamily: kSecondaryFontFamily,
                ),
                SpaceY(24.dy),
                 CustomElevatedButton(
                    onPressed: (){
                      moveAndClearStack(context: context, page: CustomNavigationBar.routeName);
                    }, buttonText: "Explore Houses"),
                    SpaceY(16.dy),
                    GestureDetector(
                      onTap: (){
                        moveToOldScreen(context: context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 48.dy,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: kBlack,),
                          borderRadius: BorderRadius.circular(8)
                        ),              
                        child: CustomText(
                                        text:
                        "Go Back",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        color: kBlack,
                                        fontFamily: kSecondaryFontFamily,
                                      ),
                      ),
                    ),
                SpaceY(24.dy),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
