import 'package:flutter/material.dart';
import 'package:travoli/core/components/components.dart';

import '../../../../core/configs/configs.dart';
import '../screens/house_features_screen.dart';

class FeaturePopup extends StatefulWidget {
  const FeaturePopup(
      {Key? key,
      required this.title,
      this.height = 150,
      required this.nameController,
      required this.onPressed,
      required this.apartmentFeatures,
      required this.wrapWidget,
      })
      : super(key: key);
  final String title;
  final double? height;
  final TextEditingController nameController;
  final Function()? onPressed;
  final List<String> apartmentFeatures;
  final Widget wrapWidget;
  @override
  State<FeaturePopup> createState() => _FeaturePopupState();
}

class _FeaturePopupState extends State<FeaturePopup> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final searchController = TextEditingController();
  
   List<String> chosenList = [];
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
            key: _formKey,
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
                  SpaceY(24.dy),
                  NormalTextFormField(
                      hintText: "Constant Light",
                      labelText: "Add Custom Features",
                      controller: widget.nameController,
                      validator: (String? value) {
                        return null;
                      }),
                  SpaceY(30.dy),
                  widget.wrapWidget,
                  SpaceY(54.dy),
                  CustomElevatedButton(
                      onPressed: widget.onPressed, buttonText: "Add custom feature")
                ],
              ),
            )),
      ),
    );
  }
}
