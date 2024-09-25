import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:travoli/core/helpers/network_call_managers.dart';
import 'package:travoli/feature/authentication/presentation/screens/splash_screen.dart';
import 'package:travoli/feature/dashboard/explore/domain/models/rentals.dart';
import 'package:travoli/feature/dashboard/explore/domain/services/rental_service.dart';
import 'package:travoli/feature/dashboard/general/bloc/filter_bloc.dart';
import 'package:travoli/feature/dashboard/manage_apartments/domain/bloc/upload_bloc.dart';
import 'package:travoli/feature/dashboard/manage_apartments/domain/modals/xfile.dart';
import 'package:travoli/feature/dashboard/manage_apartments/domain/services/upload_service.dart';
import 'package:travoli/feature/dashboard/profile/domain/modals/profile.dart';
import 'package:travoli/feature/dashboard/wishlist/bloc/wishlist_bloc.dart';
import 'package:travoli/feature/dashboard/wishlist/domain/service/favorite_service.dart';
import 'core/configs/configs.dart';
import 'core/helpers/router/app_route.dart';
import 'core/helpers/shared_preference_manager.dart';
import 'feature/authentication/domain/services/auth_services.dart';
import 'feature/authentication/domain/bloc/authentication_bloc.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'feature/dashboard/explore/bloc/rentals_bloc.dart';
import 'feature/dashboard/general/bloc/agent_bloc.dart';
import 'feature/dashboard/general/domain/agent_service.dart';
import 'feature/dashboard/general/domain/general_service.dart';
import 'feature/dashboard/general/modals/agent.dart';
import 'feature/dashboard/profile/bloc/profile_bloc.dart';
import 'feature/dashboard/profile/domain/services/profile_service.dart';
import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager.init();
  await _openHive();
  final apiClient = ApiClient();
  final customApiClient = CustomApiClient();
  final authenticationService = AuthenticationService(apiClient: apiClient);
  final rentalService = RentalService(apiClient: apiClient);
  final profileService = ProfileService(apiClient: apiClient);
  final favoriteService = FavoriteService(apiClient: apiClient);
  final generalService = GeneralService(apiClient: customApiClient);
  final rentalUpload =  RentalUpload(customApiClient: customApiClient, apiClient: apiClient);
  final agentService = AgentService(apiClient: apiClient);
  runApp(MyApp(
    authenticationService: authenticationService,
    rentalService: rentalService,
    profileService: profileService,
    favoriteService: favoriteService,
    generalService: generalService,
    rentalUpload: rentalUpload,
    agentService: agentService,
  ));

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  Bloc.observer = AppBlocObserver();
  Bloc.transformer;
}

_openHive() async {
  var appDocDir = await pp.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path);
  Hive.init(appDocDir.path);
  Hive.registerAdapter(ProfileAdapter());
  Hive.registerAdapter(RentalsAdapter());
  Hive.registerAdapter(BillAdapter());
  Hive.registerAdapter(PhotoAdapter());
  Hive.registerAdapter(XFileAdapter());
  Hive.registerAdapter(AgentAdapter());
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.authenticationService,
      required this.rentalService,
      required this.profileService,
      required this.favoriteService,
      required this.generalService,
      required this.agentService,
      required this.rentalUpload});
  final AuthenticationService authenticationService;
  final RentalService rentalService;
  final ProfileService profileService;
  final FavoriteService favoriteService;
  final GeneralService generalService;
  final RentalUpload rentalUpload;
  final AgentService agentService;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => AuthenticationBloc(
                authenticationService: authenticationService)),
        BlocProvider<RentalsBloc>(
            create: (BuildContext context) =>
                RentalsBloc(rentalService: rentalService)),
        BlocProvider<ProfileBloc>(
            create: (BuildContext context) =>
                ProfileBloc(profileService: profileService)),
        BlocProvider<WishlistBloc>(
            create: (BuildContext context) =>
                WishlistBloc(favoriteService: favoriteService)),
        BlocProvider<FilterBloc>(
            create: (BuildContext context) => FilterBloc()),
        BlocProvider<UploadBloc>(
            create: (BuildContext context) =>
                UploadBloc(rentalUpload: rentalUpload)),
        BlocProvider<AgentBloc>(
            create: (BuildContext context) =>
                AgentBloc(agentService: agentService)),
      ],
      child: GlobalLoaderOverlay(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Travoli',
          theme: AppTheme().lightTheme,
          onGenerateRoute: AppRouter.onGenerated,
          builder: (context, widget) {
            final media = MediaQuery.of(context);
            Dims.setSize(media);
            return widget!;
          },
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
