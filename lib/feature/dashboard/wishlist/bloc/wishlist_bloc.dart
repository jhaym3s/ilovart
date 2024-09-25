import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travoli/core/configs/storage_box.dart';
import 'package:travoli/core/helpers/hive_repository.dart';
import 'package:travoli/core/helpers/shared_preference_manager.dart';
import 'package:travoli/feature/dashboard/wishlist/domain/service/favorite_service.dart';

import '../../explore/domain/models/rentals.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final FavoriteService favoriteService;
  HiveRepository _hiveRepository = HiveRepository();
  WishlistBloc({required this.favoriteService}) : super(WishlistInitial()) {
    on<GetWishListEvent>(getFavorites);
    on<AddWishListEvent>(addFavorites);
    on<RemoveWishListEvent>(removeFavorites);
  }

  FutureOr<void> getFavorites(GetWishListEvent event, Emitter<WishlistState> emit) async{
    emit(WishListLoadingState());
    final favorites = await favoriteService.getFavorite();
    favorites.fold((l) {
      emit(WishListFailureState());
    }, (r) {
      final List<dynamic> favorites = r["data"]["favorites"];
      print("my $favorites");
      List<String> favList = favorites.map((e) => e.toString()).toList();
      SharedPreferencesManager.setStringList(PrefKeys.favorite, favList);
      _hiveRepository.add(item: favorites,key:HiveKeys.favorite, name: HiveKeys.favorite);
      final listFavorite = SharedPreferencesManager.getStringList(PrefKeys.favorite);
      print("listFavorite $listFavorite");
      emit(WishListSuccessState(favorites: listFavorite));
    });
  }

  FutureOr<void> addFavorites(AddWishListEvent event, Emitter<WishlistState> emit) async {
    final addFavorite = await favoriteService.addFavorite(favorite: event.favorite);
    addFavorite.fold((l) {
      print("responds from adding favorites $l");
      emit(AddWishListFailureState(errorMessage: l));
    }, 
    (r) {
      print("responds from adding favorites $r");
      final List<dynamic> favorites = r["data"]["favorites"];
      List<String> favList = favorites.map((e) => e.toString()).toList();
      SharedPreferencesManager.setStringList(PrefKeys.favorite, favList);
      _hiveRepository.add(item: favorites,key:HiveKeys.favorite, name: HiveKeys.favorite);
      final fav = favList;
      emit(AddWishListSuccessState(favorite: fav));
    });
  }

  FutureOr<void> removeFavorites(RemoveWishListEvent event, Emitter<WishlistState> emit) async {
    final addFavorite = await favoriteService.removeFavorite(favorite: event.favorite);
    addFavorite.fold((l) {
      emit(RemoveWishListFailureState(errorMessage: l));
    }, 
    (r) {
      print("responds from removing favorites $r");
      List<String> favList = event.favorite.map((e) => e.toString()).toList();
       SharedPreferencesManager.setStringList(PrefKeys.favorite, favList);
      emit( RemoveWishListSuccessState(favorite: favList));
    });
  }
}