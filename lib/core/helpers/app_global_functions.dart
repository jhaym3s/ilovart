import 'package:travoli/core/configs/storage_box.dart';
import 'package:travoli/core/helpers/shared_preference_manager.dart';

import '../../feature/dashboard/explore/domain/models/rentals.dart';

List<dynamic> addFavorite({
required List<dynamic> currentFav, 
required String rentalId}){
  currentFav.add(rentalId);
  return currentFav;
}

List<dynamic> removeFavorite({
required List<dynamic> currentFav, 
required String rentalId}){
  currentFav.remove(rentalId);
   List<String> favList = currentFav.map((e) => e.toString()).toList();
   SharedPreferencesManager.setStringList(PrefKeys.favorite, favList);
  return currentFav;
}

List<String> demoStateList  = [
  "Abia",
  "Adamawa",
  "Akwa Ibom",
  "Anambra",
  "Bauchi",
  "Bayelsa",
  "Benue",
  "Borno",
  "Cross River",
  "Delta",
  "Ebonyi",
  "Edo",
  "Ekiti",
  "Enugu",
  "Gombe",
  "Imo",
  "Jigawa",
  "Kaduna",
  "Kano",
  "Katsina",
  "Kebbi",
  "Kogi",
  "Kwara",
  "Lagos",
  "Nasarawa",
  "Niger",
  "Ogun",
  "Ondo",
  "Osun",
  "Oyo",
  "Plateau",
  "Rivers",
  "Sokoto",
  "Taraba",
  "Yobe",
  "Zamfara",
  "Federal Capital Territory (FCT)"
];
