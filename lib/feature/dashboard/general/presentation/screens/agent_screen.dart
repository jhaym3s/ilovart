import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travoli/core/configs/storage_box.dart';
import 'package:travoli/core/helpers/regex_validation.dart';
import 'package:travoli/feature/dashboard/wishlist/bloc/wishlist_bloc.dart';
import '../../../../../core/components/components.dart';
import '../../../../../core/configs/configs.dart';
import '../../../../../core/helpers/hive_repository.dart';
import '../../../../../core/helpers/router/router.dart';
import '../../../../../core/helpers/shared_preference_manager.dart';
import '../../../../../core/helpers/toast_manager.dart';
import '../../../explore/bloc/rentals_bloc.dart';
import '../../../explore/domain/models/rentals.dart';
import '../../../explore/screens/house_details.dart';
import '../../../explore/widget/wish_list_tile.dart';
import '../../domain/logout.dart';

class AgentScreen extends StatefulWidget {
  static const routeName = "agentScreen";
  const AgentScreen({super.key, required this.agentId, required this.name});
  final String agentId, name;

  @override
  State<AgentScreen> createState() => _AgentScreenState();
}

class _AgentScreenState extends State<AgentScreen> {
  late List<Rentals> agentRentals;
  late List<String> favList;

  @override
  void initState() {
    super.initState();
    List<Rentals> rentalList =
        _hiveRepository.get(name: HiveKeys.rentals, key: HiveKeys.rentals) ??
            [];
    agentRentals =
        rentalList.where((rental) => rental.agentId == widget.agentId).toList();
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
          return SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                child: CustomText(
                  text: widget.name,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xff0B0B0B),
                  fontFamily: kFontFamily,
                ),
              ),
              SpaceY(16.dy),
              Expanded(
                child: ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                    itemCount: agentRentals.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            moveFromBottomNavBarScreen(
                                context: context,
                                targetScreen: HouseDetailScreen(
                                  rentals: agentRentals[index],
                                ));
                          },
                          child: ExploreTile(
                            favOnpressed: () {
                                if (!favList.contains(agentRentals[index].id)) {
                                              setState(() {
                                                favList.add(agentRentals[index].id);
                                              });
                                                print("$favList stay 2");
                                                context.read<WishlistBloc>().add(
                                                AddWishListEvent(
                                                    favorite: favList));            
                                             }else{
                                              setState(() {
                                                favList.remove(agentRentals[index].id);
                                              });
                                                print("$favList stay 3");
                                                context.read<WishlistBloc>().add(
                                                RemoveWishListEvent(favorite: favList)); 
                                             }
                            },
                            icon: Icons.favorite,
                            containerWidth: 360.dx,
                            image: agentRentals[index].photos[0].url,
                            imageCount: agentRentals[index].photos.length,
                            city:
                                agentRentals[index].state.toString().capitalize,
                            title: agentRentals[index]
                                .propertyType
                                .toString()
                                .capitalize,
                            amount:
                                "$currencySymbol${agentRentals[index].bills[0].price.toString().addCommasToNumber}/month",
                          ));
                    }),
              )
            ],
          ));
        },
      ),
    );
  }
}
