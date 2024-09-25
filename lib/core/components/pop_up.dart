import 'package:flutter/material.dart';

import '../configs/configs.dart';

Future<void> showModalSheetWithRadius({
  required BuildContext context, required Widget returnWidget, required double height}) {
  return showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(40),
      ),
    ),
    isScrollControlled: true,
    //isDismissible: true,
    builder: (BuildContext context, ) {
      return StatefulBuilder(
         builder: (BuildContext context, StateSetter modalSetState) {
        return Container(
        height: kScreenHeight(context) * 1 - height.dy,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
          topLeft: Radius.circular(40.0),
        )
            ),
        child: returnWidget,
            );
         }
      );
    },
  );
}

Future<void> EditableModalSheet({required BuildContext context}) {
  return showModalBottomSheet(
    context: context,
   shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(40),
      ),
    ),
     isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter modalSetState) {
          return Container(
            child: Column(
              children: [
                // Your modal sheet content
                ElevatedButton(
                  onPressed: () {
                    // Update the state within the modal sheet
                    modalSetState(() {
                      // Update your state variables here
                    });
                  },
                  child: Text('Update State'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Future<void> showModalSheet({required BuildContext context, required Widget returnWidget}) {
  return showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        //top: Radius.circular(30),
      ),
    ),
    isScrollControlled: true,
    //isDismissible: true,
    builder: (BuildContext context) {
      return returnWidget;
    },
  );
}
