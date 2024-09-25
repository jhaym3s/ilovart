import 'package:flutter/cupertino.dart';
import 'package:travoli/core/helpers/hive_repository.dart';
import 'package:travoli/core/helpers/router/router.dart';
import 'package:travoli/core/helpers/shared_preference_manager.dart';
import 'package:travoli/feature/authentication/presentation/screens/sign_in_screen.dart';

import '../../../../core/configs/storage_box.dart';

class Logout {


  Future<void> logOut(BuildContext context) async {
    HiveRepository _hiveRepository = HiveRepository();
    // moveAndClearStack(context: context, page: SignInScreen.routeName);
    moveFromBottomNavBarScreen(context: context, targetScreen: SignInScreen());
    SharedPreferencesManager.setBool(PrefKeys.isFirstTime, true);
    SharedPreferencesManager.setString(PrefKeys.userId, "");
    SharedPreferencesManager.setString(PrefKeys.email, "");
    SharedPreferencesManager.setStringList(PrefKeys.signUpDetails, []);
    SharedPreferencesManager.setBool(PrefKeys.isTenant, true);
    SharedPreferencesManager.setStringList(PrefKeys.favorite, []);
    SharedPreferencesManager.setString(PrefKeys.propertyTypeKey, "");
    SharedPreferencesManager.setString(PrefKeys.state, "");
    SharedPreferencesManager.setString(PrefKeys.lgaKey, "");
    SharedPreferencesManager.setString(PrefKeys.houseDirectionKey, "");
    SharedPreferencesManager.setString(PrefKeys.houseAddr, "");
    SharedPreferencesManager.setString(PrefKeys.listingTypeKey, "");
    SharedPreferencesManager.setStringList(PrefKeys.houseFeatures, []);
    SharedPreferencesManager.setString(PrefKeys.country, "");
    _hiveRepository.clear(name: HiveKeys.favorite);
    _hiveRepository.clear(name: HiveKeys.rentals);
    _hiveRepository.clear(name: HiveKeys.bills);
    _hiveRepository.clear(name: HiveKeys.images);
    _hiveRepository.clear(name: HiveKeys.video);







    
    

  }
}