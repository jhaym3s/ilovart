import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:travoli/feature/dashboard/explore/screens/explore_screen.dart';
import 'package:travoli/feature/dashboard/manage_apartments/screens/apartment_screen.dart';

import '../../core/configs/configs.dart';
import 'profile/screen/profile_screen.dart';
import 'wishlist/screens/favorite_screen.dart';

class AgentCustomNavigationBar extends StatefulWidget {
  static const routeName = "agent_nav_bar";
  const AgentCustomNavigationBar({Key? key}) : super(key: key);

  @override
  _AgentCustomNavigationBarState createState() => _AgentCustomNavigationBarState();
}

class _AgentCustomNavigationBarState extends State<AgentCustomNavigationBar> {
  late PersistentTabController _pageController;
  
  List<Widget> _children() {
    return [
      const ExploreScreen(),
      const WishlistScreen(),
      //const HistoryScreen(),
      const ApartmentScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentTabConfig> _navBarsItems() {
    return [

      PersistentTabConfig(
        screen: const ExploreScreen(),
          item: ItemConfig(
            activeForegroundColor: Colors.black,
            icon: Image.asset(AssetsImages.activeExplore, height: 24.dy, width: 24.dx),
            inactiveIcon: Image.asset(AssetsImages.inactiveExplore, height: 24.dy, width: 24.dx),
            title: "Explore",
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kPrimaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500,),
          ),
      ),
      
      PersistentTabConfig(
        screen: const WishlistScreen(),
          item: ItemConfig(
            activeForegroundColor: Colors.black,
            icon: Image.asset(AssetsImages.activeWishlist, height: 24.dy, width: 24.dx),
            inactiveIcon: Image.asset(AssetsImages.inactiveWishlist, height: 24.dy, width: 24.dx),
            title: "Wishlist",
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kPrimaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500,),
          ),
      ),
      PersistentTabConfig(
        screen: const ApartmentScreen(),
          item: ItemConfig(
            activeForegroundColor: Colors.black,
            icon: Image.asset(AssetsImages.activeAddHouse, height: 24.dy, width: 24.dx),
            inactiveIcon: Image.asset(AssetsImages.inactiveAddHouse, height: 24.dy, width: 24.dx),
            title: "Apartments",
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kPrimaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500,),
          ),
      ),
      PersistentTabConfig(
        screen: const ProfileScreen(),
          item: ItemConfig(
            icon: Image.asset(AssetsImages.activeProfile, height: 24.dy, width: 24.dx),
            activeForegroundColor: Colors.black,
            inactiveIcon: Image.asset(AssetsImages.inactiveProfile, height: 24.dy, width: 24.dx),
            title: "Profile",
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kPrimaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500,),
          ),
      ),
      
    ];
  }

  //late List<Map<Object, Object>> pages;

  int selectedPageIndex = 0;
  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pageController = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: _navBarsItems(),
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarDecoration: NavBarDecoration(),
          navBarConfig: navBarConfig,
        ),
    );
  }
}