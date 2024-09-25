import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travoli/core/configs/storage_box.dart';
import 'package:travoli/core/helpers/regex_validation.dart';
import 'package:travoli/feature/dashboard/wishlist/bloc/wishlist_bloc.dart';
import '../../../../core/components/components.dart';
import '../../../../core/components/custom_loader.dart';
import '../../../../core/configs/configs.dart';
import '../../../../core/helpers/app_global_functions.dart';
import '../../../../core/helpers/hive_repository.dart';
import '../../../../core/helpers/router/router.dart';
import '../../../../core/helpers/shared_preference_manager.dart';
import '../../explore/bloc/rentals_bloc.dart';
import '../../explore/domain/models/rentals.dart';
import '../../explore/screens/house_details.dart';
import '../../explore/widget/wish_list_tile.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late List<String> favList;

  @override
  void initState() {
    super.initState();
    context.read<WishlistBloc>().add(GetWishListEvent());
    context.read<RentalsBloc>().add(GetRentalsEvent());
    favList = SharedPreferencesManager.getStringList(PrefKeys.favorite);
  }

  final HiveRepository _hiveRepository = HiveRepository();
  @override
  Widget build(BuildContext context) {
    List<Rentals> rentalList =
        _hiveRepository.get(name: HiveKeys.rentals, key: HiveKeys.rentals) ??
            [];
    return Scaffold(
      body: BlocConsumer<WishlistBloc, WishlistState>(
        listener: (context, state) {
          if (state is RemoveWishListSuccessState) {
              setState(() {
                favList = state.favorite;
              });
           }
        },
        builder: (context, state) {
          return SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                child: CustomText(
                  text: "Wishlist(${favList.length})",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xff0B0B0B),
                  fontFamily: kFontFamily,
                ),
              ),
              SpaceY(16.dy),
              favList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: kScreenPadding.dx),
                          itemCount: favList.length,
                          itemBuilder: (context, index) {
                            List<Rentals> filteredRentals = rentalList
                                .where((rental) => favList.contains(rental.id))
                                .toList();
                            return GestureDetector(
                                onTap: () {
                                  moveFromBottomNavBarScreen(
                                      context: context,
                                      targetScreen: HouseDetailScreen(
                                        rentals: filteredRentals[index],
                                      ));
                                },
                                child: ExploreTile(
                                  favOnpressed: () {
                                    setState(() {
                                      favList.remove(filteredRentals[index].id);
                                    });
                                    context.read<WishlistBloc>().add(
                                        RemoveWishListEvent(
                                            favorite:favList));
                                  },
                                  icon: Icons.favorite,
                                  containerWidth: 360.dx,
                                  image: filteredRentals[index].photos[0].url,
                                  imageCount:
                                      filteredRentals[index].photos.length,
                                  city: filteredRentals[index]
                                      .state
                                      .toString()
                                      .capitalize,
                                  title: filteredRentals[index]
                                      .propertyType
                                      .toString()
                                      .capitalize,
                                  amount:
                                      "$currencySymbol${filteredRentals[index].bills[0].price.toString().addCommasToNumber}/month",
                                ));
                          }),
                    )
                  : Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 50,
                              backgroundColor: kBlack,
                              child: CircleAvatar(
                                  radius: 47,
                                  backgroundColor: kWhite,
                                  child: Image.asset(
                                    AssetsImages.rentHouse,
                                    height: 50.dy,
                                    width: 50.dx,
                                  ))),
                          CustomText(
                            text: "No Favorite Apartment found",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff0B0B0B),
                            fontFamily: kSecondaryFontFamily,
                          ),
                          SpaceY(10.dy),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 45.dx),
                            child: CustomText(
                              text:
                                  "Details of favorite apartments would apartment here",
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
            ],
          ));
        },
      ),
    );
  }
}
