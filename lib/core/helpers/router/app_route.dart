import 'package:flutter/material.dart';
import 'package:travoli/feature/authentication/presentation/screens/number_verification.dart';
import 'package:travoli/feature/authentication/presentation/screens/onboarding_screen.dart';
import 'package:travoli/feature/authentication/presentation/screens/sign_up_screen.dart';
import 'package:travoli/feature/authentication/presentation/screens/splash_screen.dart';
import 'package:travoli/feature/authentication/presentation/screens/step1.dart';
import 'package:travoli/feature/dashboard/dashbord.dart';
import 'package:travoli/feature/dashboard/explore/domain/models/rentals.dart';
import 'package:travoli/feature/dashboard/explore/screens/filter_done_screen.dart';
import 'package:travoli/feature/dashboard/explore/screens/filter_screen.dart';
import 'package:travoli/feature/dashboard/explore/screens/house_details.dart';
import 'package:travoli/feature/dashboard/explore/screens/terms_and_condition_screen.dart';
import 'package:travoli/feature/dashboard/manage_apartments/screens/add_bills_screen.dart';
import 'package:travoli/feature/dashboard/manage_apartments/screens/add_image_screen.dart';
import 'package:travoli/feature/dashboard/manage_apartments/screens/house_features_screen.dart';

import '../../../feature/authentication/presentation/screens/sign_in_screen.dart';
import '../../../feature/authentication/presentation/screens/step2.dart';
import '../../../feature/dashboard/agent_dashboard.dart';
import '../../../feature/dashboard/general/presentation/screens/agent_screen.dart';
import '../../../feature/dashboard/manage_apartments/screens/add_apartment_screen.dart';
import '../../../feature/dashboard/manage_apartments/screens/rental_listing_overview.dart';

class AppRouter {
  static Route onGenerated(RouteSettings settings) {
    //print("Route name is ${settings.name}");
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
        case CustomNavigationBar.routeName:
        return MaterialPageRoute(builder: (_) => const CustomNavigationBar());
        
       case OnBoardingScreen.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case SignUpScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
        case SignInScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
         case NumberVerificationScreen.routeName:
        return MaterialPageRoute(builder: (_) => const NumberVerificationScreen());
        case Step1.routeName:
        return MaterialPageRoute(builder: (_) => const Step1());
        case Step2.routeName:
        return MaterialPageRoute(builder: (_) => const Step2());
        case HouseDetailScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HouseDetailScreen());
        case FilterScreen.routeName:
        return MaterialPageRoute(builder: (_) => const FilterScreen());
        case TermsAndConditionScreen.routeName:
        return MaterialPageRoute(builder: (_) => const TermsAndConditionScreen());
      case AgentCustomNavigationBar.routeName:
        return MaterialPageRoute(builder: (_) => const AgentCustomNavigationBar());
        case AddApartmentScreen.routeName:
        return  MaterialPageRoute(builder: (_) => const AddApartmentScreen());
         case HouseFeatures.routeName:
        return  MaterialPageRoute(builder: (_) => const HouseFeatures());
        case AddImagesScreen.routeName:
        return  MaterialPageRoute(builder: (_) => const AddImagesScreen());
        case AddBillsScreen.routeName:
        return  MaterialPageRoute(builder: (_) => const AddBillsScreen());
        case RentalListingOverview.routeName:
        return  MaterialPageRoute(builder: (_) => const RentalListingOverview());
        case FilterDoneScreen.routeName:
        return  MaterialPageRoute(builder: (_) => const FilterDoneScreen());
        case AgentScreen.routeName:
        return  MaterialPageRoute(builder: (_) => const AgentScreen(agentId: "",name: "",));
      default:
        return onError();
    }
  }
  static Route onError() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                child: Text(
                  "Error Screen",
                  style: Theme.of(_).textTheme.headlineMedium,
                ),
              ),
            ));
  }
}
