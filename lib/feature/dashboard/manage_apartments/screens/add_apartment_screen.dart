import 'package:flutter/material.dart';
import 'package:travoli/core/configs/configs.dart';
import 'package:travoli/core/configs/storage_box.dart';
import 'package:travoli/core/helpers/app_global_functions.dart';
import 'package:travoli/core/helpers/regex_validation.dart';
import 'package:travoli/core/helpers/router/router.dart';
import 'package:travoli/core/helpers/shared_preference_manager.dart';
import 'package:travoli/feature/dashboard/manage_apartments/screens/house_features_screen.dart';
import '../../../../core/components/comment_box.dart';
import '../../../../core/components/components.dart';
import '../widgets/property_type_popup.dart';

class AddApartmentScreen extends StatefulWidget {
  static const routeName = "addApartmentScreen";
  const AddApartmentScreen({super.key});

  @override
  State<AddApartmentScreen> createState() => _AddApartmentScreenState();
}

class _AddApartmentScreenState extends State<AddApartmentScreen> {
  final houseAddressController = TextEditingController();
  final houseDirectionController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final apartmentTypeController = TextEditingController();
  int selectedIndex = 1;
  List<String> propertyType = [
    "Single room",
    "Two Bedroom",
    "Three Bedroom",
    "Four Bedroom",
    "Five Bedroom",
    "Apartment Complex",
    "bungalow",
    "mansion",
    "fully detached duplex",
    "condos",
    "flat",
    "terraced house",
    "semi detached duplex"
  ];
 

   final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceY(38.dy),
                CustomText(
                  text: "House Details",
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
                SpaceY(32.dy),
                NormalTextFormField(
                   hintText: "2 bedroom",
                  labelText: "Property Type",
                    controller: apartmentTypeController,
                    suffixIcon: GestureDetector(child: const Icon(Icons.keyboard_arrow_down), 
                    onTap: (){
                      showModalSheetWithRadius(
                        context: context,
                        returnWidget: PropertyTypePopUp(
                          title: "Property Type",
                          height: 200,
                          wrapWidget: Wrap(
                            children: List.generate(
                              propertyType.length,
                              (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      apartmentTypeController.text =
                                          propertyType[index].capitalize;
                                      moveToOldScreen(context: context);
                                    });
                                  },
                                  child: PropertyTile(
                                    name: propertyType[index].capitalize,
                                  )),
                            ),
                          ),
                        ),
                        height: 200);
                    },),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                      return 'Please choose an apartment type';
                     }
                      return null;
                    }),
                 SpaceY(16.dy),
                    DropDownTextFormField(
                      hintText: "Abuja",
                      labelText: "State",
                      controller: stateController,
                      onTap: () {
                        showModalSheetWithRadius(
                            context: context,
                            returnWidget: PropertyTypePopUp(
                              height: 200,
                              wrapWidget: Wrap(
                                children: List.generate(
                                  demoStateList.length,
                                  (index) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          stateController.text = demoStateList[index].capitalize;
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
                       if (value!.isEmpty) {
                      return 'Please select a state';
                     }
                        return null;
                      },
                      suffixIcon: const Icon(Icons.keyboard_arrow_down),
                    ),
                  SpaceY(16.dy),
                NormalTextFormField(
                    hintText: "Wuse",
                    labelText: "City",
                    controller: cityController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                      return 'Please enter a city';
                     }
                      return null;
                    }),
                SpaceY(16.dy),
                NormalTextFormField(
                    hintText: "30 Lekki street",
                    labelText: "House Address",
                    controller: houseAddressController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                      return 'Please enter house address';
                     }
                      return null;
                    }),
                 SpaceY(16.dy),
                 CommentTextFormField(controller: houseDirectionController, labelText: "House Direction",validator: (String? value) {
                       if (value!.isEmpty) {
                      return 'Please enter direction to house';
                     }
                      return null;
                    }, hintText: "Enter directions or landmark",),
                SpaceY(16.dy),
                CustomText(
                  text: "Listing Type",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff0B0B0B),
                  fontFamily: kFontFamily,
                ),
                SpaceY(8.dy),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: ListingType(
                          type: "Rent",
                          index: 1,
                          selectedIndex: selectedIndex,
                        )),
                    SpaceX(12.dx),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 2;
                          });
                        },
                        child: ListingType(
                          type: "Shortlet",
                          index: 2,
                          selectedIndex: selectedIndex,
                        )),
                  ],
                ),
                SpaceY(24.dy),
                CustomElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                      SharedPreferencesManager.setString(
                        PrefKeys.propertyTypeKey,
                        apartmentTypeController.text,
                      );
                      SharedPreferencesManager.setString(
                        PrefKeys.lgaKey,
                        cityController.text,
                      );
                      SharedPreferencesManager.setString(
                        PrefKeys.state,
                        stateController.text,
                      );
                      SharedPreferencesManager.setString(
                        PrefKeys.houseDirectionKey,
                        houseDirectionController.text,
                      );
                      SharedPreferencesManager.setString(
                        PrefKeys.houseAddr,
                        houseAddressController.text,
                      );
                      SharedPreferencesManager.setString(
                        PrefKeys.listingTypeKey,
                        "Rent",
                      );
                      moveToNextScreen(
                        context: context,
                        page: HouseFeatures.routeName,
                      );
                      }
                    },
                    buttonText: "Next Step"),
                SpaceY(32.dy),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class ListingType extends StatelessWidget {
  const ListingType(
      {super.key,
      required this.type,
      required this.index,
      required this.selectedIndex});
  final String type;
  final int index, selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: index == selectedIndex ? kBlack : kWhite,
          border: Border.all(
              color: index == selectedIndex ? kWhite : kBlack, width: 1.dx),
          borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: CustomText(
            text: type,
            overflow: TextOverflow.ellipsis,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: index == selectedIndex ? kWhite : kBlack),
      ),
    );
  }
}

class Map extends StatelessWidget {
  const Map({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Image.asset(AssetsImages.map),
        Container(
          height: 141.dy,
          width: 350.dx,
          decoration: BoxDecoration(
              color: kWhite,
              border:
                  Border.all(color: const Color(0xffA1A1A1).withOpacity(0.1)),
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage(AssetsImages.map),
                fit: BoxFit.fill,
              )),
        ),
        Container(
          height: 40.dy,
          width: 133.dx,
          margin: EdgeInsets.only(bottom: 30.dy),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: kWhite, width: 3.dx),
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: CustomText(
              text: "Add on map",
              overflow: TextOverflow.ellipsis,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: kWhite,
            ),
          ),
        )
      ],
    );
  }
}
