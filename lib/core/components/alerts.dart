import 'package:flutter/material.dart';

import '../configs/configs.dart';
// import 'package:froddo_rider/features/dashboard/custom_navigation_bar.dart';
// import 'package:froddo_rider/features/dashboard/explore/screens/pay_with_card.dart';
// import 'package:froddo_rider/features/dashboard/explore/screens/pay_with_earnings.dart';
// import 'package:froddo_rider/features/dashboard/explore/screens/pay_with_saving.dart';


void generalDialog(
    {
    required BuildContext context,
    // required Function() onPressed,
    // required String title,
    // required String image,
    // required String buttonText,
     required Widget children,
    }) {
  showGeneralDialog(
    context: context,
    barrierLabel: "General Dialog",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return Center(
        child: children
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
      }
      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}

void showPaymentOption({required BuildContext context, required VoidCallback onPressed,}){
    generalDialog(context: context, 
    children: Container(
       decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(8)
      ),
      height: 298.dy, width: 350.dx,
      child: Column(
          children: [
            SpaceY(26.dy),
              Text("Payment Options",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: kTextColorsLight)),
              SpaceY(4.dy),
               Text("Amount - \$20",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: kPrimaryColor)),
                SpaceY(24.dy),
                GestureDetector(
                  onTap: () {
                   // moveToNextScreen(context: context, page: PayWithCard.routeName);
                  },
                child: const PaymentListTile(option: "Pay with card",)),
                GestureDetector(
                  onTap: () {
                    //moveToNextScreen(context: context, page: PayWithEarning.routeName);
                  },
                  child: const PaymentListTile(option: "Pay with earnings",)),
                GestureDetector(
                  onTap: () {
                   // moveToNextScreen(context: context, page: PayWithSaving.routeName);
                  },
                  child: const PaymentListTile(option: "Pay with savings",))
          ],
      ),
    ));
}


void showFundingOption({required BuildContext context, required VoidCallback onPressed,}){
    generalDialog(context: context, 
    children: Container(
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(8)
      ),
      height: 298.dy, width: 350.dx,
      child: Column(
          children: [
            SpaceY(56.dy),
              Text("Payment Options",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: kTextColorsLight)),
              SpaceY(4.dy),
               Text("Amount - \$20",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: kPrimaryColor)),
                SpaceY(24.dy),
                const PaymentListTile(option: "Pay with card",),
                const PaymentListTile(option: "Pay with earnings",),
                SpaceY(47.dy)
          ],
      ),
    ));
}

class PaymentListTile extends StatelessWidget {
  const PaymentListTile({
    super.key, required this.option
  });
  final String option;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.dy, width: 307.dx,
      margin: EdgeInsets.only(bottom: 8.dy),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: const Color(0xffF2F4F7),),
      child: Center(
        child: Text(option,
            softWrap: true,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: kTextColorsLight)),
      ),
    );
  }
}

void showOrderAcceptedDialog({required BuildContext context, required VoidCallback onPressed,}){
    generalDialog(context: context, 
    children: Container(
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(8)
      ),
      height: 223.dy, width: 327.dx,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.dx),
        child: Column(
            children: [
              SpaceY(25.dy),
             // Image.asset(AssetsImages.check, height: 40.dy, width: 40.dx,),
                SpaceY(4.dy),
                 Text("Order accepted",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: kTextColorsLight)),
                  SpaceY(4.dy),
                  Text("You just accepted an order from Chef Nora",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: kGrey)),
                    SpaceY(16.dy),
                    Container(
              height: 44.dy, width: kScreenWidth(context),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, color: kWhite,),
                  Text("View Location on Map",
               textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: kWhite)),
                ],
              ),
            ),
                 
            ],
        ),
      ),
    ));
}

