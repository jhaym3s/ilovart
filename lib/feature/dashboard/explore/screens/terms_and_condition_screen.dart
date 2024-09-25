import 'package:flutter/material.dart';

import '../../../../core/components/components.dart';
import '../../../../core/configs/configs.dart';
import '../../../../core/helpers/toast_manager.dart';

class TermsAndConditionScreen extends StatefulWidget {
  static const  routeName = "termsAndCondition";
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                      text:"Terms And Condition",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff0B0B0B),
                      fontFamily: kSecondaryFontFamily,
                    ),
              SpaceY(20.dy),
              CustomText(
                        text:"Below contains rules and regulations that govern the Landlord expects the tenant to obey and follow up.",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: kGrey,
                        fontFamily: kSecondaryFontFamily,
                      ),
              SpaceY(20.dy),
              Expanded(
                child:  ListView.builder(
                  itemCount: 4,
                           itemBuilder: (context,index){
                        return CustomText(
                        text:"${index+1}. No Pets allowed",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: kGrey,
                        fontFamily: kSecondaryFontFamily,
                      );
                         }),
              ),
               CustomElevatedButton(onPressed:(){
                 // moveToNextScreen(context: context, page: NumberVerificationScreen.routeName);
                 ToastManager.successToast(context, message: "Agent has been notified and would contact you shortly");
                }, buttonText: "Continue"),
          ],
        ),
      )
      ),
    );
  }
}