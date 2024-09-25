part of 'wishlist_bloc.dart';

sealed class WishlistState extends Equatable {
  const WishlistState();
  
 
}

final class WishlistInitial extends WishlistState {
   @override
  List<Object> get props => [];
}


class WishListSuccessState extends WishlistState{
 final  List<String> favorites;
  const WishListSuccessState({required this.favorites});
   @override
  List<Object> get props => [];
}

class WishListFailureState extends WishlistState{
   @override
  List<Object> get props => [];
}

class WishListLoadingState extends WishlistState{
   @override
  List<Object> get props => [];
}

//class WishListSuccessState extends WishlistState{}

class AddWishListFailureState extends WishlistState{
  final String errorMessage;
  const AddWishListFailureState({required this.errorMessage});

   @override
  List<Object> get props => [];
}

class AddWishListSuccessState extends WishlistState{
  final List<String> favorite;

  const AddWishListSuccessState({required this.favorite});

   @override
  List<Object> get props => [];
}

class AddWishListLoadingState extends WishlistState{

   @override
  List<Object> get props => [];
}

class RemoveWishListFailureState extends WishlistState{
  final String errorMessage;
  const RemoveWishListFailureState({required this.errorMessage});
   @override
  List<Object> get props => [];
}

class RemoveWishListSuccessState extends WishlistState{
  final List<String> favorite;
  const RemoveWishListSuccessState({required this.favorite});
   @override
  List<Object> get props => [];
}

class RemoveWishListLoadingState extends WishlistState{

   @override
  List<Object> get props => [];
}

