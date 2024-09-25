import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travoli/core/helpers/regex_validation.dart';
import '../../../../core/components/components.dart';
import '../../../../core/configs/configs.dart';
import '../../../../core/helpers/router/router.dart';
import '../../explore/screens/house_details.dart';
import '../../explore/widget/wish_list_tile.dart';
import '../../general/bloc/filter_bloc.dart';

class FilterDoneScreen extends StatefulWidget {
  static const routeName =  "filterDonScreen";
  const FilterDoneScreen({super.key, });

  @override
  State<FilterDoneScreen> createState() => _FilterDoneScreenState();
}

class _FilterDoneScreenState extends State<FilterDoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpaceY(14.dy),
           Padding(
                padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                child: CustomText(
                  text: "Filtered",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff0B0B0B),
                  fontFamily: kFontFamily,
                ),
              ),
          SpaceY(24.dy),
          BlocConsumer<FilterBloc, FilterState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return (state is ApplyFilterSuccessState)
                  ? Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: kScreenPadding.dx),
                          itemCount: state.rentals.length,
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
                                    // setState(() {
                                    //  print("not like us");
                                    //  filteredRentals
                                     //     .remove(filteredRentals[index].id);
                                       // print("$filteredRentals not like us");
                                    // });
                                    //instantList.contains(state.rentals[index].id)?
                                    // context.read<WishlistBloc>().add(
                                    //     RemoveWishListEvent(
                                    //         favorite: removeFavorite(
                                    //             currentFav: favList,
                                    //             rentalId: filteredRentals[index]
                                    //                 .id)));
                                  },
                                  icon: Icons.favorite,
                                  containerWidth: 360.dx,
                                  image: state.rentals[index].photos[0].url,
                                  imageCount:
                                      state.rentals[index].photos.length,
                                  city: state.rentals[index]
                                      .state
                                      .toString()
                                      .capitalize,
                                  title: state.rentals[index].propertyType
                                      .toString()
                                      .capitalize,
                                  amount:"$currencySymbol${state.rentals[index].bills[0].
                                  price.toString().addCommasToNumber}/month",
                                ));
                          }),
                    )
                  : (state is ApplyFilterFailureState)
                      ? Expanded(
                        child:  Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              CircleAvatar(
                        radius: 35,
                        backgroundColor: kBlack,
                        child: CircleAvatar(radius: 47,  backgroundColor: kWhite,child: 
                        Image.asset(AssetsImages.rentHouse, height: 50.dy, width: 50.dx,))),
                        SpaceY(12.dy),
                      CustomText(
                        text: "No Apartment found",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff0B0B0B),
                        fontFamily: kSecondaryFontFamily,
                      ),
                      SpaceY(10.dy),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 45.dx),
                        child: CustomText(
                          text: state.errorMessage,
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
                      )
                      : Container();
            },
          ),
        ],
      )),
    );
  }
}
