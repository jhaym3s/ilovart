import 'package:flutter/material.dart';
import 'package:travoli/core/components/components.dart';
import 'package:travoli/core/helpers/regex_validation.dart';
import 'package:travoli/feature/dashboard/manage_apartments/screens/house_features_screen.dart';
import '../../../../core/configs/configs.dart';

class PropertyTypePopUp extends StatefulWidget {
  const PropertyTypePopUp({
    Key? key,
    this.height = 150, required this.wrapWidget, this.title = "Property Type"
  }) : super(key: key);
  final double? height;
  final Widget wrapWidget;
  final String title;
  
  @override
  State<PropertyTypePopUp> createState() => _PropertyTypePopUpState();
}

class _PropertyTypePopUpState extends State<PropertyTypePopUp> {

  List<String> propertyType = [
    "bungalow",
    "duplex",
    "mansion",
    "fully detached duplex",
    "apartment",
    "condos",
    "flat",
    "terraced house",
    "semi detached duplex"
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      height: kScreenHeight(context) * 1 - widget.height!.dy,
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
        child: Form(
            child: Padding(
              padding: EdgeInsets.only(top: 24.dx, left: 19.dx, right: 19.dx),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                            color: kBlack),
                      ),
                    ],
                  ),
                  SpaceY(32.dy),
                  widget.wrapWidget,
                  
                ],
              ),
            )),
      ),
    );
  }
}


class PropertyTile extends StatefulWidget {
  const PropertyTile({
    super.key, required this.name,  
  });
  final String name;

  @override
  State<PropertyTile> createState() => _PropertyTileState();
}

class _PropertyTileState extends State<PropertyTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
       margin:  EdgeInsets.only(right:8.dx, bottom: 12.dy),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffA1A1A1))
      ),
      child: CustomText(
      text: widget.name,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: kBlack,
      fontFamily: kFontFamily,
      ),
    );
  }
}