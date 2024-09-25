
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

void  moveAndClearStack({required BuildContext context, required String page,}){
   Navigator.of(context).pushNamedAndRemoveUntil(
     page, (Route<dynamic> route) => false);
}


void  moveToNextScreen({required BuildContext context, required String page, Object? arguments}){
   Navigator.of(context).pushNamed(page, arguments: arguments);
}

void  moveToOldScreen({required BuildContext context, Object? arguments}){
   Navigator.of(context).pop();
}

void moveFromBottomNavBarScreen({required BuildContext context, required Widget targetScreen}){
  pushScreen(
        context,
        screen: targetScreen,
        withNavBar: false, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
}

// Navigator.of(context, rootNavigator: true)
                          //     .pushAndRemoveUntil(
                          //   MaterialPageRoute(
                          //     builder: (BuildContext context) {
                          //       return const OnBoardingScreen2();
                          //     },
                          //   ),
                          //   (_) => false,
                          // );