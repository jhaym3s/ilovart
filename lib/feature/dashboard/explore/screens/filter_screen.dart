import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travoli/core/configs/dimensions.dart';
import 'package:travoli/core/helpers/regex_validation.dart';
import 'package:travoli/core/helpers/router/router.dart';
import 'package:travoli/core/helpers/toast_manager.dart';
import 'package:travoli/feature/dashboard/explore/screens/filter_done_screen.dart';
import 'package:travoli/feature/dashboard/explore/widget/search_bar.dart';
import 'package:travoli/feature/dashboard/general/bloc/filter_bloc.dart';

import '../../../../core/components/components.dart';
import '../../../../core/configs/configs.dart';
import '../../../../core/helpers/app_global_functions.dart';
import '../../manage_apartments/widgets/property_type_popup.dart';
import '../widget/filter_cards.dart';
import '../widget/state_drop_down.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = "filterScreen";
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> selectedRanges = [];

  List<String> selectedApartmentTypes = [];
  List<String> apartmentTypes = [
    "one bedroom",
    "Two Bedroom",
    "Three Bedroom",
    "Four Bedroom",
    "Five Bedroom",
    "apartment",
    "bungalow",
    "mansion",
    "fully detached duplex",
    "condos",
    "flat",
    "terraced house",
    "semi detached duplex"
  ];
  final List<String> amountRange = [
    "100k -350k",
    "350k - 500k",
    "500k - 1.5M",
    "1.5M - 3.5M",
    "3.5M - 5M",
    "5M and Above"
  ];

// void selectRange(String amount){
//     switch (amount) {
//     case "100k -350k":
//      selectedRanges.addAll([100000,350000]);
//     case "350k - 500k":
//      selectedRanges.addAll([350000,500000]);
//     case "500k - 1.5M":
//      selectedRanges.addAll([500000,1500000]);
//     case "1.5M - 3.5M":
//      selectedRanges.addAll([1500000,3500000]);
//     case "3.5M - 5M":
//      selectedRanges.addAll([3500000,5000000]);
//     case "5M and Above":
//      selectedRanges.addAll([5000000,100000000]);
// }
// }

  late List<bool> amountIsSelected;
  late List<bool> apartmentIsSelected;
  @override
  void initState() {
    super.initState();
    amountIsSelected = List.generate(amountRange.length, (_) => false);
    apartmentIsSelected = List.generate(apartmentTypes.length, (_) => false);
  }

  final _formKey = GlobalKey<FormState>();
  final locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpaceY(18.dy),
              const ExploreSearchBar(),
              SpaceY(13.dy),
              const Divider(
                color: Color(0xffE0DFDF),
              ),
              SpaceY(24.dy),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                child: CustomText(
                  text: "House type",
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: kTextColorsLight,
                ),
              ),
              SpaceY(8.dy),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.dx),
                child: Wrap(
                  children: List.generate(
                      apartmentTypes.length,
                      (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedApartmentTypes.contains(
                                      apartmentTypes[index].toLowerCase())
                                  ? selectedApartmentTypes.remove(
                                      apartmentTypes[index].toLowerCase())
                                  : selectedApartmentTypes
                                      .add(apartmentTypes[index].toLowerCase());
                              apartmentIsSelected[index] =
                                  !apartmentIsSelected[index];
                              print(
                                  "result ${selectedApartmentTypes.toString()}");
                            });
                          },
                          child: FilterCards(
                            text: apartmentTypes[index],
                            isSelected: apartmentIsSelected[index],
                          ))).toList(),
                ),
              ),
              SpaceY(16.dy),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                child: CustomText(
                  text: "Price range",
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: kTextColorsLight,
                ),
              ),
              SpaceY(8.dy),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                child: Wrap(
                  children: List.generate(
                      amountRange.length,
                      (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRanges.contains(amountRange[index])
                                  ? selectedRanges.remove(amountRange[index])
                                  : selectedRanges.add(amountRange[index]);
                              amountIsSelected[index] =
                                  !amountIsSelected[index];
                            });
                          },
                          child: FilterCards(
                            text: amountRange[index],
                            isSelected: amountIsSelected[index],
                          ))).toList(),
                ),
              ),
              SpaceY(11.dy),
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                 child: DropDownTextFormField(
                      hintText: "Abuja",
                      labelText: "State",
                      controller: locationController,
                      onTap: () {
                        showModalSheetWithRadius(
                            context: context,
                            returnWidget: PropertyTypePopUp(
                              title: "States",
                              height: 200,
                              wrapWidget: Wrap(
                                children: List.generate(
                                  demoStateList.length,
                                  (index) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          locationController.text = demoStateList[index].capitalize;
                                          moveToOldScreen(context: context);
                                        });
                                      },
                                      child: PropertyTile(
                                        name: demoStateList[index].capitalize,
                                      )),
                                ),
                              ),
                            ),
                            height: 200);
                      },
                      validator: (String? value) {
                        return null;
                      },
                      suffixIcon: const Icon(Icons.keyboard_arrow_down),
                    ),
               ),
              SpaceY(20.dy),
              CustomElevatedButton(
                  onPressed: () {
                    print("location ${locationController.text}");
                    print("type ${selectedApartmentTypes}");
                    print("price ${selectedRanges}");
                    // if (selectedApartmentTypes.isNotEmpty &&
                    //     selectedRanges.isNotEmpty && _formKey.currentState!.validate()) {
                      if (selectedApartmentTypes.isEmpty|| selectedRanges.isEmpty||locationController.text=="") {
                        ToastManager.errorToast(context,
                          message: "Please pick from all filter categories");
                      }else{
                          context.read<FilterBloc>().add(ApplyFilter(
                          location: locationController.text.toLowerCase(),
                          selectedRanges: selectedRanges,
                          apartmentTypes: selectedApartmentTypes));
                      moveToNextScreen(
                          context: context, page: FilterDoneScreen.routeName);
                      }
                      
                    // } else {
                    //   ToastManager.errorToast(context,
                    //       message: "Please pick from all filter categories");
                    // }
                  },
                  buttonText: "Apply filter"),
              SpaceY(40.dy),
            ],
          ),
        ),
      ),
    );
  }
}
