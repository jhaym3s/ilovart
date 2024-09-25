import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:travoli/core/configs/configs.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:travoli/core/helpers/regex_validation.dart';
import 'package:travoli/core/helpers/shared_preference_manager.dart';
import 'package:travoli/feature/dashboard/explore/domain/models/rentals.dart';
import 'package:travoli/feature/dashboard/general/presentation/screens/agent_screen.dart';
import '../../../../core/components/components.dart';
import '../../../../core/configs/storage_box.dart';
import '../../../../core/helpers/router/router.dart';
import '../../general/bloc/agent_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../wishlist/bloc/wishlist_bloc.dart';

class HouseDetailScreen extends StatefulWidget {
  static const routeName = "houseDetail";
  const HouseDetailScreen({super.key, this.rentals, });
  final Rentals? rentals;

  @override
  State<HouseDetailScreen> createState() => _HouseDetailScreenState();
}

class _HouseDetailScreenState extends State<HouseDetailScreen> {
  late String agentId;
  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    agentId = widget.rentals!.agentId;
    favorites = SharedPreferencesManager.getStringList(PrefKeys.favorite);
    // print("object ${widget.rentals!.bills.firstWhere((map) => map.name == "john").price.toString()}");
  }

  Future<void> _launchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.platformDefault,
    )) {
      throw Exception('Could not launch $url');
    }
  }
  int imageNumber = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocConsumer<WishlistBloc, WishlistState>(
                listener: (context, state) {
            if (state is WishListSuccessState) {
              setState(() {
                 favorites = state.favorites;
              });
           }
            if (state is AddWishListSuccessState) {
              setState(() {
                favorites = state.favorite;
              });
           }
           if (state is RemoveWishListSuccessState) {
              setState(() {
                favorites = state.favorite;
              });
           }
            if (state is WishListSuccessState) {
             favorites = state.favorites;
           }
            if (state is WishlistInitial) {
            context.read<WishlistBloc>().add(GetWishListEvent());
           }
                },
                builder: (context, state) {
                  return FlutterCarousel.builder(
                    itemCount: widget.rentals!.photos.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      return DetailsTile(
                        favOnpressed: 
                        () {
                              if (!favorites.contains(widget.rentals!.id)) {
                              setState(() {
                                favorites.add(widget.rentals!.id);
                              });
                                print("$favorites stay 2");
                                context.read<WishlistBloc>().add(
                                AddWishListEvent(
                                    favorite: favorites));            
                              }else{
                              setState(() {
                                favorites.remove(widget.rentals!.id);
                              });
                                print("$favorites stay 3");
                                context.read<WishlistBloc>().add(
                                RemoveWishListEvent(favorite: favorites)); 
                              }
                          },
                        icon: favorites.contains(widget.rentals!.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        image: widget.rentals!.photos[itemIndex].url,
                        imageIndex: imageNumber,
                        imageCount: widget.rentals!.photos.length,
                      );
                    },
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          imageNumber = index + 1;
                        });
                      },
                      autoPlay: true,
                      viewportFraction: 1,
                      reverse: false,
                      enableInfiniteScroll: false,
                    ),
                  );
                },
              ),
              SpaceY(17.5.dy),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                child: CustomText(
                  text: widget.rentals!.propertyType.capitalize,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff100C08),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                child: CustomText(
                  text:
                      "${widget.rentals!.lga.capitalize}, ${widget.rentals!.state.capitalize} State",
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: kSecondaryFontFamily,
                  color: const Color(0xff45403B),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                child: CustomText(
                  text: CurrencyFormatter.format(
                      widget.rentals!.bills[0].price.toString(), nairaSettings,
                      decimal: 2),
                  overflow: TextOverflow.ellipsis,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff5C4500),
                ),
              ),
              SpaceY(19.dy),
              const Divider(
                color: Color(0xffE0DFDF),
              ),
              SpaceY(8.dy),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                child: CustomText(
                  text: "House  description",
                  overflow: TextOverflow.ellipsis,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: kTextColorsLight,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                child: ExpandableText(
                  widget.rentals!.houseAddress.capitalize +
                      ". " +
                      widget.rentals!.houseDirection.capitalize,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: kGrey),
                  linkTextStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: kPrimaryColor),
                  readMoreText: 'Read more',
                  readLessText: 'Read less',
                  trim: 3, // You can set the maximum number of lines to display
                ),
              ),
              SpaceY(14.dy),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                child: Wrap(
                    children: widget.rentals!.houseFeatures
                        .map((e) => HouseDetail(
                              houseDetails: e.capitalize,
                            ))
                        .toList()),
              ),
              SpaceY(24.dy),
              BlocBuilder<AgentBloc, AgentState>(
                builder: (context, state) {
                  return 
                  (state is AgentSuccessState)? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                    child: CustomText(
                      text: "Owned by",
                      overflow: TextOverflow.ellipsis,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: kTextColorsLight,
                    ),
                  ): Container();
                },
              ),
              SpaceY(8.dy),
              BlocConsumer<AgentBloc, AgentState>(
                listener: (context, state) {
                  if (state is AgentInitial) {
                    context.read<AgentBloc>().add(GetAgentInfo(id: agentId));
                  }
                },
                builder: (context, state) {
                  if (state is AgentInitial) {
                    context.read<AgentBloc>().add(GetAgentInfo(id: agentId));
                  }
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
                    child: (state is AgentSuccessState)?Row(
                      children: [
                        const CircleAvatar(
                          radius: 22.5,
                        ),
                        SpaceX(10.dx),
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: state.agent.firstName.capitalize +
                                        " " +
                                        state.agent.lastName.capitalize,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff45403B),
                                  ),
                                  Row(
                                    children: [
                                      // Icon(Icons.phone),
                                      // SpaceX(8.dx),
                                      CustomText(
                                        text: state.agent.phoneNumber,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff45403B),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                      ],
                    ):Container(),
                  );
                },
              ),
              SpaceY(40.dy),
              BlocBuilder<AgentBloc, AgentState>(
                builder: (context, state) {
                  return (state is AgentSuccessState)
                      ? CustomElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter modalSetState) {
                                    return Container(
                                      height: 300.dy,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              //topRight: Radius.circular(30.0),
                                              )),
                                      child: SingleChildScrollView(
                                        physics: const ScrollPhysics(),
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
                                                    "Contact Agent",
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
                                              SpaceY(16.dy),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        _launchInBrowser(
                                                            'tel:${state.agent.phoneNumber}');
                                                      },
                                                      child: AgentContact(
                                                        icon: Icons.phone,
                                                        text:
                                                            "Mobile call with ${state.agent.phoneNumber}",
                                                      )),
                                                  GestureDetector(
                                                      onTap: () {
                                                        _launchInBrowser(
                                                            'mailto:${state.agent.email}');
                                                      },
                                                      child: AgentContact(
                                                        icon: Icons.mail,
                                                        text:
                                                            "Email with ${state.agent.email}",
                                                      )),
                                                  GestureDetector(
                                                      onTap: () {
                                          moveFromBottomNavBarScreen(
                                              context: context,
                                              targetScreen: AgentScreen(
                                                agentId: agentId,
                                                name: state.agent.firstName.capitalize +
                                        " " +
                                        state.agent.lastName.capitalize,
                                              ));
                                                      },
                                                      child: AgentContact(
                                                        icon: Icons.list_sharp,
                                                        text: "More apartments",
                                                      )),
                                                  SpaceY(54.dy),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          buttonText: "Contact")
                      : Container();
                },
              ),
              SpaceY(40.dy),
            ],
          ),
        ),
      ),
    );
  }
}

class AgentContact extends StatelessWidget {
  const AgentContact({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpaceY(18.dy),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: kBlack),
              ),
            ),
            SpaceX(16.dx),
            Icon(icon),
          ],
        ),
        Divider(
          color: Colors.grey[400],
        ),
      ],
    );
  }
}

class HouseTermsButton extends StatelessWidget {
  const HouseTermsButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.dx),
      padding: EdgeInsets.symmetric(horizontal: 15.dx),
      height: 48.dy,
      width: double.infinity,
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xffE0DFDF),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: "House terms and conditions",
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: kTextColorsLight,
          ),
          Icon(Icons.arrow_forward)
        ],
      ),
    );
  }
}

class HouseDetail extends StatelessWidget {
  const HouseDetail({
    super.key,
    required this.houseDetails,
  });
  final String houseDetails;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: "• $houseDetails  ",
      fontSize: 14.sp,
      fontFamily: kSecondaryFontFamily,
      fontWeight: FontWeight.w400,
      color: const Color(0xff45403B),
    );
  }
}

class DetailsTile extends StatelessWidget {
  const DetailsTile(
      {super.key,
      required this.image,
      required this.imageCount,
      required this.icon,
      required this.favOnpressed,
      required this.imageIndex});

  final String image;
  final int imageCount, imageIndex;
  final IconData icon;
  final void Function()? favOnpressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230.dy,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.fill,
        ),
        color: kWhite,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.dy),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.dx, vertical: 1.dy),
                    decoration: BoxDecoration(
                      color: kBlack,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: CustomText(
                      text: "Available",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: kWhite,
                    ),
                  ),
                ),
                IconButton(icon: Icon(icon), onPressed: favOnpressed,)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.dx, vertical: 1.dy),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(3),
            ),
            child: CustomText(
              text: "$imageIndex/$imageCount",
              fontSize: 8.sp,
              fontWeight: FontWeight.w700,
              color: kWhite,
            ),
          ),
        ],
      ),
    );
  }
}
