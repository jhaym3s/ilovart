import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travoli/core/configs/configs.dart';
import 'package:travoli/core/configs/storage_box.dart';
import 'package:travoli/core/helpers/app_global_functions.dart';
import 'package:travoli/core/helpers/regex_validation.dart';
import 'package:travoli/core/helpers/router/router.dart';
import 'package:travoli/core/helpers/shared_preference_manager.dart';
import 'package:travoli/core/helpers/toast_manager.dart';
import 'package:travoli/feature/dashboard/explore/screens/filter_screen.dart';
import 'package:travoli/feature/dashboard/explore/screens/house_details.dart';
import 'package:travoli/feature/dashboard/general/domain/logout.dart';
import 'package:travoli/feature/dashboard/wishlist/bloc/wishlist_bloc.dart';
import '../../../../core/components/components.dart';
import '../bloc/rentals_bloc.dart';
import '../widget/wish_list_tile.dart';
import '../widget/search_bar.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
   List<String> favList = [];
  @override
  void initState() {
    super.initState();
    context.read<WishlistBloc>().add(GetWishListEvent());
    context.read<RentalsBloc>().add(GetRentalsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<WishlistBloc, WishlistState>(
          listener: (context, state) {
            if (state is WishListSuccessState) {
              setState(() {
                 favList = state.favorites;
              });
           }
            if (state is AddWishListSuccessState) {
              setState(() {
                favList = state.favorite;
              });
             
           }
           if (state is RemoveWishListSuccessState) {
              setState(() {
                favList = state.favorite;
              });
           }
            if (state is WishListSuccessState) {
             favList = state.favorites;
           }
            if (state is WishlistInitial) {
            context.read<WishlistBloc>().add(GetWishListEvent());
           }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpaceY(18.dy),
                  GestureDetector(
                      onTap: () {
                        moveFromBottomNavBarScreen(
                            context: context,
                            targetScreen: const FilterScreen());
                      },
                      child: const ExploreSearchBar()),
                  SpaceY(13.dy),
                  const Divider(
                    color: Color(0xffE0DFDF),
                  ),
                  SpaceY(13.dy),
                  const ExploreInfo(),
                  SpaceY(24.dy),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                    child: CustomText(
                      text: "Newly Added",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff0B0B0B),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                    child: CustomText(
                      text: "Recently added houses in your location.",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff45403B),
                      fontFamily: kSecondaryFontFamily,
                    ),
                  ),
                  SpaceY(16.dy),
                  BlocConsumer<RentalsBloc, RentalsState>(
                    listener: (context, state) {
                      if (state is GetRentalFailureState) {
                        if (state.errorMessage
                            .contains("refresh token is deprecated")) {
                          Logout().logOut(context);
                        } else {
                          ToastManager.errorToast(context,
                              message: state.errorMessage.capitalize);
                        }
                      }
                      
                      if (state is AddWishListSuccessState) {
                        ToastManager.successToast(context,
                            message: "Added Successfully");
                      }
                      if (state is RemoveWishListSuccessState) {
                        ToastManager.errorToast(context,
                            message: "Remove Successfully");
                      }
                    },
                    builder: (context, state) {
                      if (state is RentalsInitial) {
                        context.read<WishlistBloc>().add(GetWishListEvent());
                        context.read<RentalsBloc>().add(GetRentalsEvent());
                      }
                      return (state is GetRentalSuccessState)
                          ? SizedBox(
                              height: 240.dy,
                              child: ListView.builder(
                                  padding: EdgeInsets.only(left: 20.dx),
                                  itemCount: state.rentals.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          moveFromBottomNavBarScreen(
                                              context: context,
                                              targetScreen: HouseDetailScreen(
                                                rentals: state.rentals[index],
                                              ));
                                        },
                                        child: ExploreTile(
                                          favOnpressed: () {
                                             if (!favList.contains(state.rentals[index].id)) {
                                              setState(() {
                                                favList.add(state.rentals[index].id);
                                              });
                                                print("$favList stay 2");
                                                context.read<WishlistBloc>().add(
                                                AddWishListEvent(
                                                    favorite: favList));            
                                             }else{
                                              setState(() {
                                                favList.remove(state.rentals[index].id);
                                              });
                                                print("$favList stay 3");
                                                context.read<WishlistBloc>().add(
                                                RemoveWishListEvent(favorite: favList)); 
                                             }
                                          },
                                          icon: favList.contains(
                                                  state.rentals[index].id)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          containerWidth: 202.dx,
                                          image: state
                                              .rentals[index == 4 ? 0 : index]
                                              .photos[0]
                                              .url,
                                          imageCount: state
                                              .rentals[index].photos.length,
                                          city: state
                                              .rentals[index].state.capitalize,
                                          title: state.rentals[index]
                                              .propertyType.capitalize,
                                          amount:
                                              "$currencySymbol${state.rentals[index].bills[0].price.toString().addCommasToNumber}/month",
                                        ));
                                  }),
                            )
                          : (state is GetRentalLoadingState)
                              ? const Center(
                                  child: CupertinoActivityIndicator(),
                                )
                              : Container();
                    },
                  ),
                  SpaceY(16.dy),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                    child: CustomText(
                      text: "Recommendations",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff0B0B0B),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                    child: CustomText(
                      text: "Similar to your house types.",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff45403B),
                      fontFamily: kSecondaryFontFamily,
                    ),
                  ),
                  SpaceY(16.dy),
                  BlocConsumer<RentalsBloc, RentalsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SizedBox(
                        height: kScreenHeight(context) / 1.5,
                        child: (state is GetRentalSuccessState)
                            ? ListView.builder(
                                //physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.rentals.length,
                                padding: EdgeInsets.symmetric(
                                    horizontal: kScreenPadding.dx),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        moveFromBottomNavBarScreen(
                                            context: context,
                                            targetScreen: HouseDetailScreen(
                                              rentals: state.rentals[index],
                                            ));
                                      },
                                      child: ExploreTile(
                                        favOnpressed: () {
                                             if (!favList.contains(state.rentals[index].id)) {
                                              setState(() {
                                                favList.add(state.rentals[index].id);
                                              });
                                                print("$favList stay 2");
                                                context.read<WishlistBloc>().add(
                                                AddWishListEvent(
                                                    favorite: favList));            
                                             }else{
                                              setState(() {
                                                favList.remove(state.rentals[index].id);
                                              });
                                                print("$favList stay 3");
                                                context.read<WishlistBloc>().add(
                                                RemoveWishListEvent(favorite: favList)); 
                                             }
                                          },
                                        icon: favList.contains(
                                                state.rentals[index].id)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        containerWidth: double.infinity,
                                        image: state
                                            .rentals[index == 4 ? 0 : index]
                                            .photos[0]
                                            .url,
                                        imageCount:
                                            state.rentals[index].photos.length,
                                        city: state
                                            .rentals[index].state.capitalize,
                                        title: state.rentals[index].propertyType
                                            .capitalize,
                                        amount:
                                            "$currencySymbol${state.rentals[index].bills[0].price.toString().addCommasToNumber}/month",
                                      ));
                                })
                            : (state is GetRentalLoadingState)
                                ? const Center(
                                    child: CupertinoActivityIndicator(),
                                  )
                                : Container(),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ExploreInfo extends StatelessWidget {
  const ExploreInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.dx),
      padding: EdgeInsets.symmetric(horizontal: 12.dx, vertical: 13.dy),
      height: 62.dy,
      width: double.infinity,
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xff5C4500),
          )),
      child: CustomText(
        text:
            "Keep searching more houses, save houses and get your feed better and ready, Its all within your search.",
        fontSize: 12.sp,
        //overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w400,
        softWrap: true,
        color: const Color(0xff45403B),
        fontFamily: kSecondaryFontFamily,
      ),
    );
  }
}
