import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/components/components.dart';
import '../../../../core/configs/configs.dart';

class StateDropDown extends StatelessWidget {
  const StateDropDown({super.key, required this.tabWidget});
  final Widget tabWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
     // height: kScreenHeight(context) * 1 - height.dy,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
        //topRight: Radius.circular(30.0),
        //bottomRight: Radius.circular(40.0),
        //topLeft: Radius.circular(30.0),
      )
          // bottomLeft: Radius.circular(40.0)),
          ),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: 24.dx, left: 19.dx, right: 19.dx),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisSize: MainAxisSize.min,
            children: [
              tabWidget
            ],
          ),
        ),
      ),
    );
  }
}