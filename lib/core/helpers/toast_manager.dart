import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:travoli/core/configs/configs.dart';


class ToastManager {
  static void successToast(BuildContext context, {required String message}) {
     ScaffoldMessenger.of(context).hideCurrentSnackBar();
    var snackBar = SnackBar(
      content: Align(
        alignment: Alignment.topCenter,
        child: Text(message,
         style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500)
        //  Theme.of(context).textTheme.bodyMedium!.copyWith(
        //   fontWeight: FontWeight.w500,
        //   fontSize: 14,
        //   fontFamily: kSecondaryFont,
        //   color: kBlack),
        ),
      ),
      backgroundColor: const Color(0xffA3CB00),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void errorToast(BuildContext context, {required String message}) {
     ScaffoldMessenger.of(context).hideCurrentSnackBar();
    var snackBar = SnackBar(
      content: Text(message, 
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500)
      
      ),
      backgroundColor: Colors.red,
       behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void normalToast(BuildContext context, {required String message}) {
     ScaffoldMessenger.of(context).hideCurrentSnackBar();
    var snackBar = SnackBar(
      content: Text(message, 
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500)
      
      ),
      backgroundColor: Colors.red,
       behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorToastAfterFrame(BuildContext context, String message) {
  SchedulerBinding.instance.addPostFrameCallback((_) { 
   errorToast(context, message: message);
  });
}
  static void showSuccessToastAfterFrame(BuildContext context, String message) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
   successToast(context, message: message);
  });
}

}


