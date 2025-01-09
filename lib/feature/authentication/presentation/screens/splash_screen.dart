import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travoli/feature/dashboard/agent_dashboard.dart';
import 'package:travoli/feature/dashboard/dashbord.dart';
import '../../../../core/components/custom_text.dart';
import '../../../../core/configs/configs.dart';
import '../../../../core/configs/storage_box.dart';
import '../../../../core/helpers/hive_repository.dart';
import '../../../../core/helpers/router/router.dart';
import '../../../../core/helpers/shared_preference_manager.dart';
import '../../../dashboard/explore/domain/models/rentals.dart';
import 'onboarding_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


class SplashScreen extends StatefulWidget {
  static const routeName = "splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
    late AnimationController _controller;
    late Animation<double> _animation;
    final HiveRepository _hiveRepository = HiveRepository();
    late bool firstTime;
    late bool tenant;
    late String token;
    
     @override
  void initState() {
     firstTime = SharedPreferencesManager.getBool(PrefKeys.isFirstTime);
     tenant = SharedPreferencesManager.getBool(PrefKeys.isTenant);
     token = SharedPreferencesManager.getString(PrefKeys.accessToken);
     print("tenant? $tenant");
    _prepareAppState();
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _animation = Tween<double>(begin: -300, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );
      _controller.forward();
       Future.delayed(const Duration(seconds: 3)).then((value) {
        if (firstTime) {
          moveAndClearStack(context: context,  
        page:  OnBoardingScreen.routeName);
        return;
        }else if(tenant){
        moveAndClearStack(context: context,  
        page:  CustomNavigationBar.routeName);
        return;
        }else{
             moveAndClearStack(context: context,  
        page:  AgentCustomNavigationBar.routeName);
        return;
        }
      });
      super.initState();
  }
   _prepareAppState() async {
     await HiveRepository.openHives([
     HiveKeys.favorite,
     HiveKeys.rentals,
     HiveKeys.bills,
     HiveKeys.images,
     HiveKeys.video,
    ]);
     List<dynamic> favorite;
     List<Rentals> rentals;
     List<dynamic> bills;
     List<XFile> images;
     XFile video;
     try {
       favorite = _hiveRepository.get<List<dynamic>>(
           key: HiveKeys.favorite, name: HiveKeys.favorite,);
          rentals = _hiveRepository.get<List<Rentals>>(
           key: HiveKeys.rentals, name: HiveKeys.rentals,);
           bills = _hiveRepository.get<List<dynamic>>(
           key: HiveKeys.bills, name: HiveKeys.bills,);
           bills = _hiveRepository.get<List<XFile>>(
           key: HiveKeys.images, name: HiveKeys.images,);
          video = _hiveRepository.get<XFile>(
           key: HiveKeys.video, name: HiveKeys.video,);
       
     } catch (e) {}
   }


  //  Future<void> _getCountry() async {
  //   try {
  //     // Check if location services are enabled
  //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       return; // Location services are not enabled
  //     }
  //     // Request location permission
  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
  //         return; // Permissions are denied
  //       }
  //     }
  //     // Get the current position
  //     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //     // Reverse geocoding to get place details
  //     List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  //     Placemark place = placemarks[0];
  //     print("country ${placemarks}");
  //     print("country ${place}");
  //     print("country ${place.country}");
  //     SharedPreferencesManager.setString(PrefKeys.country, place.country);
  //   } catch (e) {
  //     print('Error getting location: $e');
  //   }
  // }
 
  @override
  Widget build(BuildContext context) {
    //final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: CustomText(
                  text: "Travoli",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff0B0B0B),
                ),
      ),
    );
  }
     @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }
}

bool tokenHasExpired(String token){
  bool isTokenExpired = JwtDecoder.isExpired(token);
  print("expired $isTokenExpired");
  return isTokenExpired;
}