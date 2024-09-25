import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travoli/core/configs/storage_box.dart';
import 'package:travoli/core/helpers/hive_repository.dart';
import 'package:travoli/core/helpers/regex_validation.dart';
import 'package:travoli/core/helpers/router/router.dart';
import 'package:travoli/core/helpers/shared_preference_manager.dart';
import 'package:travoli/core/helpers/toast_manager.dart';
import 'package:travoli/feature/dashboard/agent_dashboard.dart';
import 'package:travoli/feature/dashboard/dashbord.dart';
import 'package:travoli/feature/dashboard/explore/domain/models/rentals.dart';
import 'package:travoli/feature/dashboard/explore/screens/house_details.dart';
import 'package:travoli/feature/dashboard/explore/widget/wish_list_tile.dart';
import 'package:travoli/feature/dashboard/manage_apartments/domain/bloc/upload_bloc.dart';

import '../../../../core/components/components.dart';
import '../../../../core/components/custom_loader.dart';
import '../../../../core/configs/configs.dart';

class RentalListingOverview extends StatefulWidget {
  static const routeName = "rentalListOverview";
  const RentalListingOverview({super.key});

  @override
  State<RentalListingOverview> createState() => _RentalListingOverviewState();
}

class _RentalListingOverviewState extends State<RentalListingOverview> {
  final HiveRepository _hiveRepository = HiveRepository();

  List<Widget> mapWidget(Map<String, dynamic> bills) {
    return bills.entries.map((entry) {
      return CustomText(
        text: "${entry.key.capitalize} - ${entry.value}",
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xff0B0B0B),
        fontFamily: kFontFamily,
      );
    }).toList();
  }

  int convertToAmount(String stringAmount) {
    // Remove the currency symbol (₦)
    String cleanedString = stringAmount.replaceAll('₦', '');
    // Remove commas
    cleanedString = cleanedString.replaceAll(',', '');
    // Remove the decimal part
    cleanedString = cleanedString.split('.')[0];
    // Convert to an integer
    int amount = int.parse(cleanedString);
    return amount;
  }

  late Map<String, dynamic> bills;
  late List<Bill> billList;
  @override
  void initState() {
    super.initState();
    bills = _hiveRepository.get(key: HiveKeys.bills, name: HiveKeys.bills);
    billList = bills.entries.map((entry) {
      return Bill(name: entry.key, price: convertToAmount(entry.value));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final images =
        _hiveRepository.get<List<XFile>>(key: HiveKeys.images, name: HiveKeys.images);
        final video =
        _hiveRepository.get<XFile>(key: HiveKeys.video, name: HiveKeys.video);
    final propertyType =
        SharedPreferencesManager.getString(PrefKeys.propertyTypeKey);
    final lga = SharedPreferencesManager.getString(PrefKeys.lgaKey);
    final rentalstate = SharedPreferencesManager.getString(PrefKeys.state);
    final houseDirection =
        SharedPreferencesManager.getString(PrefKeys.houseDirectionKey);
    final houseAddr = SharedPreferencesManager.getString(PrefKeys.houseAddr);
    final listingType =
        SharedPreferencesManager.getString(PrefKeys.listingTypeKey);
    final houseFeatures =
        SharedPreferencesManager.getStringList(PrefKeys.houseFeatures);
    print("bills $bills");
    print("image $images");
    print("propertyType $propertyType");
    print("lga $lga");
    print("state $rentalstate");
    print("houseDirection $houseDirection");
    print("houseAddress $houseAddr");
    print("listing type $listingType");
    print("features $houseFeatures");
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<UploadBloc, UploadState>(
          listener: (context, state) {
            if(state is UploadRentalFailureState){
                hideOverlayLoader(context);
          ToastManager.errorToast(context, message:state.failureMessage);
            }
             if(state is UploadRentalSuccessState){
        hideOverlayLoader(context);
          ToastManager.errorToast(context, message:state.successMessage);
          moveAndClearStack(context: context, page: AgentCustomNavigationBar.routeName);
            }
          },
          builder: (context, state) {
            return SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kScreenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SpaceY(40.dy),
                      CustomText(
                        text: "Overview",
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
                      SpaceY(24.dy),
                      WishlistTile(
                        type: listingType,
                        containerWidth: kScreenWidth(context),
                        onPressed: () {},
                        title: propertyType,
                        city: rentalstate,
                        amount: bills["rent"],
                        image: images[0],
                        count: images.length,
                      ),
                      SpaceY(12.dy),
                      CustomText(
                        text: "Address - $houseAddr",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff0B0B0B),
                        fontFamily: kFontFamily,
                      ),
                      SpaceY(8.dy),
                      CustomText(
                        text: "Location - $lga, $rentalstate state",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff0B0B0B),
                        fontFamily: kFontFamily,
                      ),
                      SpaceY(8.dy),
                      CustomText(
                        text: "Landmark - $houseDirection",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff0B0B0B),
                        fontFamily: kFontFamily,
                      ),
                      SpaceY(12.dy),
                      CustomText(
                        text: "House features and description",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff0B0B0B),
                        fontFamily: kFontFamily,
                      ),
                      Wrap(
                        children: houseFeatures
                            .map((e) => HouseDetail(houseDetails: e))
                            .toList(),
                      ),
                      SpaceY(12.dy),
                      CustomText(
                        text: "Bills",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff0B0B0B),
                        fontFamily: kFontFamily,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: mapWidget(bills),
                      ),
                      SpaceY(52.dy),
                      CustomElevatedButton(
                          onPressed: () {
                            context.read<UploadBloc>().add(UploadRentalEvent(
                                property_type: propertyType,
                                house_address: houseAddr,
                                house_direction: houseDirection,
                                state: rentalstate,
                                lga: lga,
                                listing_type: listingType,
                                house_features: houseFeatures,
                                images: images,
                                bills: billList,
                                video: video));
                          },
                          buttonText: "Post House"),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}
