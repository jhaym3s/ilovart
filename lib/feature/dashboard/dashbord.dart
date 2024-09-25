import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:travoli/feature/dashboard/explore/screens/explore_screen.dart';
import 'package:travoli/feature/dashboard/history/screens/history.dart';
import 'package:travoli/feature/dashboard/manage_apartments/screens/apartment_screen.dart';
import '../../core/configs/configs.dart';
import 'profile/screen/profile_screen.dart';
import 'wishlist/screens/favorite_screen.dart';


class CustomNavigationBar extends StatefulWidget {
  static const routeName = "custom_nav_bar";
  const CustomNavigationBar({Key? key}) : super(key: key);
  

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  late PersistentTabController _pageController;
  List<PersistentTabConfig> _navBarsItems() {
    return [

      PersistentTabConfig(
        screen: const ExploreScreen(),
          item: ItemConfig(
            activeForegroundColor: Colors.black,
            icon: Image.asset(AssetsImages.activeExplore, height: 24.dy, width: 24.dx),
            inactiveIcon: Image.asset(AssetsImages.inactiveExplore, height: 24.dy, width: 24.dx),
            title: "Explore",
          ),
      ),
      
      PersistentTabConfig(
        screen: const WishlistScreen(),
          item: ItemConfig(
            activeForegroundColor: Colors.black,
            icon: Image.asset(AssetsImages.activeWishlist, height: 24.dy, width: 24.dx),
            inactiveIcon: Image.asset(AssetsImages.inactiveWishlist, height: 24.dy, width: 24.dx),
            title: "Wishlist",
          ),
      ),
      
      PersistentTabConfig(
        screen: const ProfileScreen(),
          item: ItemConfig(
            activeForegroundColor: Colors.black,
            icon: Image.asset(AssetsImages.activeProfile, height: 24.dy, width: 24.dx),
            inactiveIcon: Image.asset(AssetsImages.inactiveProfile, height: 24.dy, width: 24.dx),
            title: "Profile",
          ),
      ),
      
    ];
  }

  late List<Map<Object, Object>> pages;

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
          navBarConfig: navBarConfig,
        ),
    );
  }
}