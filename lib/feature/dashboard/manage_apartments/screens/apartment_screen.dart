import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travoli/core/configs/configs.dart';
import 'package:travoli/core/helpers/router/router.dart';
import 'package:travoli/core/helpers/shared_preference_manager.dart';
import '../../../../core/components/components.dart';
import '../../../../core/configs/storage_box.dart';
import '../../../../core/helpers/hive_repository.dart';
import '../../explore/domain/models/rentals.dart';
import '../../history/widgets/custom_tab_bar.dart';
import 'add_apartment_screen.dart';

class ApartmentScreen extends StatefulWidget {
  const ApartmentScreen({super.key});

  @override
  State<ApartmentScreen> createState() => _ApartmentScreenState();
}

class _ApartmentScreenState extends State<ApartmentScreen>
    with SingleTickerProviderStateMixin{
  late String userId;
  late TabController _tabController;
  @override
  void initState() {
    userId = SharedPreferencesManager.getString(PrefKeys.userId);
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  final HiveRepository _hiveRepository = HiveRepository();

  @override
  Widget build(BuildContext context) {
    List<Rentals> rentalList =
        _hiveRepository.get(name: HiveKeys.rentals, key: HiveKeys.rentals) ??
            [];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.add),
        onPressed: (){
        moveFromBottomNavBarScreen(context: context, targetScreen: const AddApartmentScreen());
      }),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpaceY(20.dy),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                          text:"Your Apartments",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff0B0B0B),
                          fontFamily: kFontFamily,
                        ),
                ],
              ),
            ),
            SpaceY(20.dy),
           CustomTabBar(tabController: _tabController, label1: "Rented",  label2: "In-Market"),
           Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
              Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: kBlack,
                        child: CircleAvatar(radius: 47,  backgroundColor: kWhite,child: 
                        Image.asset(AssetsImages.rentHouse, height: 50.dy, width: 50.dx,))),
                      CustomText(
                        text: "No Rented Apartment found",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff0B0B0B),
                        fontFamily: kSecondaryFontFamily,
                      ),
                      SpaceY(10.dy),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 45.dx),
                        child: CustomText(
                          text: "Details of Rented apartments would apartment here",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                          color: const Color(0xffA1A1A1),
                          fontFamily: kSecondaryFontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
            Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: kBlack,
                        child: CircleAvatar(radius: 47,  backgroundColor: kWhite,child: 
                        Image.asset(AssetsImages.rentHouse, height: 50.dy, width: 50.dx,))),
                      CustomText(
                        text: "No Listed Apartment found",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff0B0B0B),
                        fontFamily: kSecondaryFontFamily,
                      ),
                      SpaceY(10.dy),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 45.dx),
                        child: CustomText(
                          text: "Click on the button below to list your apartments",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                          color: const Color(0xffA1A1A1),
                          fontFamily: kSecondaryFontFamily,
                        ),
                      ),
                    ],
                  ),
                ) ,
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}
