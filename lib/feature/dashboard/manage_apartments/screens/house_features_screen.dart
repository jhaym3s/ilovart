import 'package:flutter/material.dart';
import 'package:travoli/core/configs/storage_box.dart';
import 'package:travoli/core/helpers/shared_preference_manager.dart';
import 'package:travoli/core/helpers/toast_manager.dart';
import 'package:travoli/feature/dashboard/manage_apartments/screens/add_image_screen.dart';
import 'package:travoli/feature/dashboard/manage_apartments/widgets/features_popup.dart';

import '../../../../core/components/components.dart';
import '../../../../core/configs/configs.dart';
import '../../../../core/helpers/router/router.dart';

class HouseFeatures extends StatefulWidget {
  static const routeName = "houseFeaturesScreen";
  const HouseFeatures({super.key});

  @override
  State<HouseFeatures> createState() => _HouseFeaturesState();
}

class _HouseFeaturesState extends State<HouseFeatures> {
  final _ = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final featureNameController = TextEditingController();
  List<String> apartmentFeatures = [];
  List<String> customApartmentFeatures = [
    "Electricity",
    "Water supply",
    "Gated compound",
    "Security guards",
    "CCTV",
    "Parking space",
    "Backup generator",
    "Air conditioning",
    "WiFi",
    "satellite TV",
    "Laundry",
    "Gym",
    "Swimming pool",
    "Maintenance",
  ];
  late List<bool> isSelectedList;
  @override
  void initState() {
    super.initState();
    isSelectedList =
        List.generate(customApartmentFeatures.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    print("apartment $apartmentFeatures");
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceY(40.dy),
                CustomText(
                  text: "House Features",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff0B0B0B),
                  fontFamily: kFontFamily,
                ),
                SpaceY(4.dy),
                CustomText(
                  text: "Lets get your house listed with the correct details.",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff100C08),
                  fontFamily: kSecondaryFontFamily,
                ),
                DropDownTextFormField(
                    hintText: "Click to add feature",
                    labelText: "",
                    controller: _,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context,
                                StateSetter modalSetState) {
                              return Container(
                                height: kScreenHeight(context) - 150.dy,
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
                                        padding: EdgeInsets.only(
                                            top: 24.dx,
                                            left: 19.dx,
                                            right: 19.dx),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Feature",
                                                  textAlign: TextAlign.left,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 18.sp,
                                                          color: kBlack),
                                                ),
                                              ],
                                            ),
                                            SpaceY(24.dy),
                                            NormalTextFormField(
                                                hintText: "Constant Light",
                                                labelText:
                                                    "Add Custom Features",
                                                controller:
                                                    featureNameController,
                                                validator: (String? value) {
                                                  return null;
                                                }),
                                            SpaceY(30.dy),
                                            Wrap(
                                              children: List.generate(
                                                customApartmentFeatures.length,
                                                (index) => GestureDetector(
                                                    onTap: () {
                                                      modalSetState(() {
                                                        isSelectedList[index] =
                                                            !isSelectedList[
                                                                index];
                                                      });
                                                      setState(() {
                                                        if (apartmentFeatures
                                                            .contains(
                                                                customApartmentFeatures[
                                                                    index])) {
                                                          print(
                                                              " feature removed");
                                                          apartmentFeatures.remove(
                                                              customApartmentFeatures[
                                                                  index]);
                                                        } else {
                                                          print(
                                                              "feature removed");
                                                          apartmentFeatures.add(
                                                              customApartmentFeatures[
                                                                  index]);
                                                        }
                                                      });
                                                    },
                                                    child: FeaturesListTile(
                                                      name:
                                                          customApartmentFeatures[
                                                              index],
                                                      isSelected:
                                                          isSelectedList[index],
                                                    )),
                                              ),
                                            ),
                                            SpaceY(54.dy),
                                            CustomElevatedButton(
                                              onPressed: () {
                                              if (featureNameController.text != ""&& !apartmentFeatures.contains(featureNameController.text.trim)) {
                                                setState(() {
                                                apartmentFeatures.add(featureNameController.text.trim());
                                                });
                                              }
                                              featureNameController.clear();
                                              },
                                              buttonText: 'Add Custom Feature',
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    validator: (String? value) {
                      return null;
                    }),
                SpaceY(18.dy),
                Wrap(
                  children: List.generate(
                      apartmentFeatures.length,
                      (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                             String indexFeature = apartmentFeatures[index];
                            if (customApartmentFeatures.contains(indexFeature)){
                              final removeIndex = customApartmentFeatures.indexOf(indexFeature);
                              isSelectedList[removeIndex] = !isSelectedList[removeIndex];
                            }
                              apartmentFeatures
                                  .remove(apartmentFeatures[index]);
                            });
                          },
                          child: FeaturesListTile(
                            name: apartmentFeatures[index],
                            isSelected: true,
                          ))).toList(),
                ),
                SpaceY(52.dy),
                CustomElevatedButton(
                    onPressed: apartmentFeatures.isNotEmpty
                        ? () {
                            SharedPreferencesManager.setStringList(
                                PrefKeys.houseFeatures, apartmentFeatures);
                            moveToNextScreen(
                                context: context,
                                page: AddImagesScreen.routeName);
                          }
                        : null,
                    buttonText: "Next Step"),
                SpaceY(32.dy),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeaturesListTile extends StatefulWidget {
  const FeaturesListTile(
      {super.key, required this.name, required this.isSelected});
  final String name;
  final bool isSelected;

  @override
  State<FeaturesListTile> createState() => _FeaturesListTileState();
}

class _FeaturesListTileState extends State<FeaturesListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: EdgeInsets.only(right: 8.dx, bottom: 12.dy),
      decoration: BoxDecoration(
          color: widget.isSelected ? kBlack : kWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xffA1A1A1))),
      child: CustomText(
        text: widget.name,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: widget.isSelected ? kWhite : kBlack,
        fontFamily: kFontFamily,
      ),
    );
  }
}
